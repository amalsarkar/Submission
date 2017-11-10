#! /usr/bin/env python2
import time
import sys
import os
import subprocess
import cPickle
import shutil
from collections import defaultdict
import multiprocessing
import logging
import glob
import re
import datetime
import traceback
log = logging.getLogger(__name__)
log.addHandler(logging.NullHandler())

def submitWorker(job):
    job.submit()
    return job

def runWorker(job):
    job.runLocal()
    return job

def resubmitWorker(job):
    job.resubmit()
    return job

def killWorker(job):
    job.kill()
    return job


class Task:
    """This is a collection of jobs"""
    def __init__(self,sample,run_folder):
        self.run_folder=run_folder
        self.sample=sample
        self.frontendstatus="None"
        self.starttime=datetime.datetime.now()
        self.endtime=datetime.datetime.now()
        self.condorlog=glob.glob(os.path.join(self.run_folder,self.sample)+"/condor*.log")[0]
        self.id =int(self.condorlog.split("_")[-1].split(".")[0])
        self.condorfile=os.path.join(self.run_folder,self.sample,"condor.jdl")
        self.jobs=[]
        self.njobs=len(glob.glob(os.path.join(run_folder,sample)+"/run_*.sh"))
        for i in range(self.njobs):
            self.jobs.append(Job(i,self))
    
    def status(self,condor_output):
        condor_output=condor_output.split("\n")
        this_job_status=filter(lambda x: "%d"%self.id in x,condor_output)
        staus_translate={
        "H":"HOLD",
        "R":"RUNNING",
        "I":"IDLE",
        "C":"COMPLETED",
        "X":"REMOVED",
        "S":"SUSPENDED",
        ">":"FINISHING",
        "<":"STARTING",
        }
        self.jobs=[]
        for i in range(self.njobs):
            self.jobs.append(Job(i,self))
        #ID      OWNER            SUBMITTED     RUN_TIME ST PRI SIZE CMD               
        #270462.18  kpadeken       10/2  09:30   0+02:57:19 R  0   976.6 wrapper.sh /uscms_
        #270470.80  kpadeken       10/2  09:30   0+02:55:39 R  0   976.6 wrapper.sh /uscms_
        #270470.112 kpadeken       10/2  09:30   0+02:55:30 R  0   976.6 wrapper.sh /uscms_
        for stati in this_job_status:
            tmp=stati.split()
            if len(tmp)>7:
                comb_id,user,date_subm,time_subm,run_time,status,priority,size_job =tmp[:8]
                job_id=int(comb_id.split(".")[-1])
                submitted_time=datetime.datetime(*time.strptime("%d "%(time.localtime().tm_year)+date_subm+" "+time_subm, "%Y %m/%d %H:%M")[:6])
                days=run_time.split("+")[0]
                rest=run_time.split("+")[1]
                hour,minute,sec=rest.split(":")
                runtime=datetime.timedelta(days=int(days),hours=int(hour),minutes=int(minute),seconds=int(sec))
                try:
                    status=staus_translate[status]
                except:
                    log.info(status)
                    log.info(stati)
                self.jobs[job_id].update(status,"None",submitted_time,runtime)
        for i in range(self.njobs):
            #log.info(self.jobs[i].status)
            if self.jobs[i].status=="None" or self.jobs[i].status=="COMPLETED" :
                output_status="Done OK"
                total_runtime=datetime.timedelta(0)
                if(os.path.getsize(self.jobs[i].errorfile)>0):
                    output_status="Error"
                
                start_time=None
                end_time=None
                condor_log=open(self.condorlog)
                condor_log=condor_log.read()
                condor_log=condor_log.split("\n")
                this_task=filter(lambda x: "%d"%self.id in x,condor_log)
                for line in this_task:
                    #345964.004
                    if "Job executing on host" in line and "%s.%03d"%(self.id,self.jobs[i].id) in line:
                        tmp=line.split()
                        start_time=time.strptime("%d "%(time.localtime().tm_year)+tmp[2]+" "+tmp[3], "%Y %m/%d %H:%M:%S")
                    elif "Job terminated" in line and "%s.%03d"%(self.id,self.jobs[i].id) in line:
                        tmp=line.split()
                        end_time=time.strptime("%d "%(time.localtime().tm_year)+tmp[2]+" "+tmp[3], "%Y %m/%d %H:%M:%S")
                        break
                
                if start_time is not None and end_time is not None:
                    self.jobs[i].starttime=datetime.datetime(*start_time[:6])
                    self.jobs[i].runtime=datetime.datetime(*end_time[:6])-datetime.datetime(*start_time[:6])
                    self.jobs[i].endtime=datetime.datetime(*end_time[:6])
                self.jobs[i].frontendstatus=output_status
                if output_status=="Error":
                    self.jobs[i].status="FAILED"
                else:
                    self.jobs[i].status="COMPLETED"
        overall_state = "Done OK"
        for i in range(self.njobs):
            tmp_state = self.jobs[i].frontendstatus
            
            if tmp_state == "REMOVED":
                overall_state = "ERROR"
                break
            if tmp_state == "IDLE":
                overall_state = "IDLE"
                break
            if tmp_state == "Error":
                overall_state = "FAILED"
                break
            if tmp_state != "COMPLETED":
                overall_state = "RUNNING"
            if tmp_state == "Done OK":
                overall_state = "Done OK"
        self.frontendstatus = overall_state
    
    def jobStatusNumbers(self):
        jobStatusNumbers=defaultdict(int)
        good, bad = 0, 0
        for job in self.jobs:
            if job.status!=job.frontendstatus:
                jobStatusNumbers[job.status]+=1
                jobStatusNumbers[job.frontendstatus]+=1
            else:
                jobStatusNumbers[job.status]+=1
            if job.status in ["ABORTED", "FAILED","ERROR"]:
                bad += 1
            if job.frontendstatus == "Done OK":
                good += 1
        jobStatusNumbers["total"]=len(self.jobs)
        jobStatusNumbers["good"] = good
        jobStatusNumbers["bad"] = bad
        return jobStatusNumbers
    
    def resubmit(self,tasklist):
        condor_jdl_file=open(self.condorfile)
        condor_jdl_resubmit_file=open(self.condorfile.replace(".jdl","_resubmit.jdl"),"w")
        removed_line=False
        for line in condor_jdl_file:
            if "arguments" in line:
                failedTask=False
                for itask in tasklist:
                    if "_%d.sh"%itask in line:
                        failedTask=True
                if failedTask:
                    condor_jdl_resubmit_file.write(line)
                else:
                    removed_line=True
            elif not removed_line:
                condor_jdl_resubmit_file.write(line)
            else:
                removed_line=False
        condor_jdl_file.close()
        condor_jdl_resubmit_file.close()
        cwd=os.getcwd()
        os.chdir(os.path.join(self.run_folder,self.sample))
        command="condor_submit condor_resubmit.jdl"
        log.debug(command)
        subprocess.call(command, shell=True)
        os.chdir(cwd)
        
    def kill(self,tasklist):
        condor_jdl_file=open(self.condorfile)
        condor_jdl_resubmit_file=open(self.condorfile.replace(".jdl","_resubmit.jdl"),"w")
        removed_line=False
        for itask in tasklist:
            command="condor_rm %d.%d"%(self.id,itask)
            log.debug(command)
            subprocess.call(command, shell=True)
    
    def run_time(self):
        runtime=datetime.timedelta(0)
        now=datetime.datetime.now()
        for ijob in self.jobs:
            if (ijob.starttime-now)>runtime:
                runtime=ijob.starttime-now
            if ijob.runtime > runtime:
                runtime=ijob.runtime
        return runtime


class Job:
    """This is represents one actual process on condor"""
    def __init__(self,_id,job):
        self.status="None"
        self.frontendstatus="None"
        self.id = _id
        self.starttime=datetime.datetime.now()
        self.runtime=datetime.timedelta(0)
        self.endtime=None
        self.errorfile=os.path.join(job.run_folder,job.sample,"err.%d_%d"%(self.id,job.id))
        self.outfile=os.path.join(job.run_folder,job.sample,"out.%d_%d"%(self.id,job.id))
      
    def update(self,_status="None",_frontendstatus="None",_starttime=datetime.datetime.now(),_runtime=datetime.timedelta(0),_endtime=None):
        self.status=_status
        self.frontendstatus=_frontendstatus
        self.starttime=_starttime
        self.runtime=_runtime
        self.endtime=_endtime
    
    

class ProxyError( Exception ):
    pass

def timeLeftVomsProxy():
    log.debug('Check time left of VomsProxy')
    """Return the time left for the proxy."""
    proc = subprocess.Popen( ['voms-proxy-info', '-timeleft' ], stdout=subprocess.PIPE, stderr=subprocess.STDOUT )
    output = proc.communicate()[0]
    log.debug('Check time left of VomsProxy [Done]')
    if proc.returncode != 0:
        return False
    else:
        return int( output )

def checkVomsProxy( time=86400 ):
    """Returns True if the proxy is valid longer than time, False otherwise."""
    timeleft = timeLeftVomsProxy()
    return timeleft > time

def renewVomsProxy( voms='cms', passphrase=None ):
    """Make a new proxy with a lifetime of one week."""
    if passphrase:
        p = subprocess.Popen(['voms-proxy-init', '--voms', voms, '--valid', '192:00'], stdout=subprocess.PIPE, stdin=subprocess.PIPE, stderr=subprocess.STDOUT)
        stdout = p.communicate(input=passphrase+'\n')[0]
        retcode = p.returncode
        if not retcode == 0:
            raise ProxyError( 'Proxy initialization command failed: '+stdout )
    else:
        retcode = subprocess.call( ['voms-proxy-init', '--voms', voms, '--valid', '192:00'] )
    if not retcode == 0:
        raise ProxyError( 'Proxy initialization command failed.')

def checkAndRenewVomsProxy( time=604800, voms='cms', passphrase=None ):
    log.debug('Check and renew VomsProxy')
    """Check if the proxy is valid longer than time and renew if needed."""
    if not checkVomsProxy( time ):
        renewVomsProxy(passphrase=passphrase)
        if not checkVomsProxy( time ):
            raise ProxyError( 'Proxy still not valid long enough!' )
    log.debug('Check and renew VomsProxy [Done]')


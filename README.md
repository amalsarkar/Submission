# Submission
A python version of the grid submission


In order to submit:
* source your environment
* set ANALYSISDIR (export ANALYSISDIR=/path/to/your/analysisdir)
* choose the files you want to run in SAMPLES_LIST.cfg (you can name it what you want)
* run ./remote.py SAMPLES_LIST.cfg
* add files ./add_root_files.py

There are some options you might want to look at ./remote.py -h or ./add_root_files.py -h

```bash
./remote.py -h
Usage: remote.py [options] CONFIG_FILE

Options:
  -h, --help            show this help message and exit
  -C DIRECTORY, --configdir=DIRECTORY
                        Define the config directory. [default = PartDet]
  -c, --CR              Run with the CR flag. [default = False]
  -o DIRECTORY, --outputFolder=DIRECTORY
                        Define path for the output files [default = root://cms
                        eos.fnal.gov//store/user/kpadeken/REPLACEBYTAG/]
  -l, --local           run localy over the files [default = False]
  -f, --force           Force the output folder to be overwritten. [default =
                        False]
  --debug=LEVEL         Set the debug level. Allowed values: ERROR, WARNING,
                        INFO, DEBUG. [default = INFO]
  -t DIRECTORY, --Tag=DIRECTORY
                        Define a Tag for the output directory. [default =
                        output2017_9_11]
```

and:

```bash
./add_root_files.py -h
Usage: add_root_files.py [options]

Options:
  -h, --help            show this help message and exit
  -i FOLDER, --inputFolder=FOLDER
                        Merge all subfolders in these folders, which can be a
                        comma-separated list.[default: none]
  --debug=LEVEL         Set the debug level. Allowed values: ERROR, WARNING,
                        INFO, DEBUG. [default = INFO]
  -o OUTFOLDER, --output=OUTFOLDER
                        Set the output dir [default = output2017_9_11_14_0]
  -f, --force           If this option is specifed, all root files will be
                        remerged. [default = False]
  -c, --clean           If this option is specifed, the folders will be cleand
                        up. [default = False]
```

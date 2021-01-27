# cluster-scripts
Example scripts to run jobs on the UIUC campus cluster

### Resources with detailed information about the campus cluster:
1. [Campus cluster website](https://campuscluster.illinois.edu/)
1. [Getting started guide](https://campuscluster.illinois.edu/resources/docs/start/)
1. [User guide](https://campuscluster.illinois.edu/resources/docs/user-guide/)

### General outline for getting acquainted with the cluster and running the first simulation:
* Ensure that you can log into the cluster before setting anything up. The cluster uses a secure shell (SSH) connection to the host `cc-login.campuscluster.illinois.edu` to communicate with any local machine that can be initiated using:
    * The terminal for any operating system, or
    * A dedicated client such as [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/), there are many more out there
* If necessary, modify the files on your local machine to efficiently run on the cluster:
    * Files not configured for parallel programming might need to be modified for the same
    * Files programmed for parallel computing on a local machine might need a slight modification to be parallelized on a larger scale
    * Minor modifications might be necessary as well:
        * If the script runs a Windows system command, it might need to be modified for Linux. 
        * If the scripts specifies full paths to files, they may need to be changed to relative paths that are consistent on the local and remote machines.
* Find the directory where you'd like to transfer the necessary data. Every user on the cluster has access to two directories:
    * Home directory: 2 GB soft limit, 4 GB hard limit, 7-day grace period to get under soft limit
    * Scratch directory: 10 TB limit, intended for short-term use (files older than 30 days are deleted)
* Transfer the necessary files (data files, analysis scripts) from local machine to cluster. This can be done using the command line or a client using different methods:
    * Secure copy protocol (SCP), base command: `scp source-directory user@host:destination-directory` for a push or the other way around for a pull. Detailed information [here](https://linux.die.net/man/1/scp)
    * Secure file tranfer protocol (SFTP) interface, base command: `sftp user@host`. `put` and `get` are commands for pushing and pulling respectively. Detailed information [here](https://linux.die.net/man/1/sftp)
    * Remote sync (rsync), base command: `rsync source-directory user@host:destination-directory` for a push or the other way around for a pull. Detailed information [here](https://linux.die.net/man/1/rsync)
    * Additionally, curl, wget, rclone, or bbcp can all be used. I (Rahil) haven't tried to use these yet so I didn't include detailed information
    
    **Note 1: The cluster recommends using the host `cc-xfer.campuscluster.illinois.edu` instead of the login host for file transfers**
    
    **Note 2: I (Rahil) personally recommend rsync since it only pushes/pulls modified files and is especially useful if the directory contains large data files**
* Prepare a shell script (examples in this repo) and execute `sbatch job_script.sbatch` to run the job

### General structure for a job script
* Define sbatch command parameters first. Standard ones I use:
    * time: maximum time the cluster should allow the job to run
    * nodes: number of nodes the cluster should allocate
    * ntasks-per-node: number of cores on a single node for cluster to allocate
    * job-name: identifier for the job
    * partition: what cluster queue to run the job on (secondary, eng-research will probably be the most common ones)
    * output: name for output file
    * error: name for error file
    * mail-user: email address of user for notifications
    * mail-type: type of email notifications to be sent to user
* Setup the environment the script needs before it can run:
    * This ususally involves loading the module using the `module load X` command, corresponding to the language you are trying to run (python, MATLAB, etc.)
    * It can be as simple as just loading the correct python or MATLAB version or as complicated as loading a compiler and compiling Fortran/C/C++ code before execution
* Finally, specify the command to run specific files with or without options. For example:
    * `python3 main.py >& logs/${SLURM_JOB_NAME}_${SLURM_JOB_ID}.oe`
    * `matlab -nodisplay -r main.m >& logs/${SLURM_JOB_NAME}_${SLURM_JOB_ID}.oe` (the `>&` writes the outputs/errors from that specific script to a dedicated log file)
    
    **Note: If you have access to the cluster, the directory `/projects/consult/slurm` has a bunch of example job scripts**

###### Please feel free to make any changes/additions to these instructions or contact Rahil (makadia2@illinois.edu) if something here is wrong so I don't further propagate false information

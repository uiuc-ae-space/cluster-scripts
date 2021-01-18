#!/usr/bin/bash
#####################################################################################################################
##                                                                                                                 ##
##                                                    Campus Cluster                                               ##
##                                              python example batch script                                        ##
##                                                                                                                 ##
## SLURM Options (To view, run the following command below)                                                        ##
##     man sbatch                                                                                                  ##
##                                                                                                                 ##
#####################################################################################################################

#SBATCH --time=0-00:35:00                                # Job run time (d-hh:mm:ss)
#SBATCH --nodes=1                                        # Number of nodes
#SBATCH --ntasks-per-node=40                             # Number of task (cores/ppn) per node (16/20/24/28/40)
#SBATCH --job-name=python-example                        # Name of batch job
#SBATCH --partition=eng-research                         # Partition (queue)
#SBATCH --output=logs/%x_%j.out                          # Name of batch job output file (%x = job name, %j = job ID)
#SBATCH --error=logs/%x_%j.err                           # Name of batch job error file (%x = job name, %j = job ID)
#SBATCH --mail-user=netID@illinois.edu                   # Send email notifications
#SBATCH --mail-type=BEGIN,FAIL,END                       # Type of email notifications to send

#####################################################################################################################

# Change to the scratch storage to prepare for job start (root directory where files exist in reality)
cd /scratch/users/netID/python-file-directory/

# Load python3 module
module load python/3

# Run python code and redirect output into a file whose name includes the Jobname and JobID
python3 main.py >& logs/${SLURM_JOB_NAME}_${SLURM_JOB_ID}.oe

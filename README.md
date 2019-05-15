# docker-compose-ops

This repository aims to gather all different docker-compose configurations to be used in operations. This is an on going project. 

File setup.env has all the environment variables that each docker-compose in this repo may need, specific setup.env can be created in each directory to add more specific details for a given implementation.

File setup.env needs to be sourced from the root directory of this repo.

Current directory tree:

	.
	├── AT_CSC
	│   ├── ATDome
	│   │   └── docker-compose.yaml
	│   ├── ATHexapod
	│   │   ├── docker-compose.yaml
	│   │   ├── startCSC.sh
	│   │   ├── startGUI.sh
	│   │   └── tcpConfiguration.yaml
	│   └── Electrometer
	│       ├── docker-compose.yaml
	│       ├── mainSetup.yaml
	│       ├── ospl.xml
	│       ├── startCSC.sh
	│       └── startGUI.sh
	├── AT_EFD
	│   ├── docker-compose.yaml
	│   ├── efd_population.sh
	│   └── efd_writers.sh
	├── AT_Simulators
	│   ├── docker-compose.yaml
	│   └── ospl.xml
	├── README.md
	└── setup.env


This aims to gather all the containers that may run in different nodes.

The file **setup.env** has several variables defined that are used by pretty much all the docker-compose definitions, such that if you modify those variables once, all the other definitions will act accordingly. 

To configure your environment to properly use these docker compose, just source setup.env. 

    $ source setup.env

However if you happen to need different values of the same variable, you can always create other files within child directories and source those. You can also just export a varaible in the bash and will also work.

Below some of the definitions in setup.env file:

    # The path in where the ospl.xml you want to use into the container is
    export OSPL_CONFIG_PATH=$PWD/ospl.xml
    # Path in where the custom ospl.xml will land
    export OSPL_MOUNT_POINT=/home/saluser/ospl.xml
    # Updating the ospl.uri to use the customized ospl.xml
    export OSPL_URI=file://$OSPL_MOUNT_POINT
    # The DDS domain the containers will be using
    export LSST_DDS_DOMAIN=atsimulatorcsc
    # The host in where the EFD Writers will find its DB. This is mostly for MySQL
    export LSST_EFD_HOST=139.229.162.118

# AT_CSC

AT_CSC aims to gather all the CSCs related with the Auxiliary Telescope, within that directory we have listed initially **ATDome** and **Hexapod**

## ATDome
It is using the following image: lsstts/at_dome_sim:3.9-0.5, using the default entrypoint.

## ATHexapod
It is using image: lsstts/ts_athexapod, it has to definitions, one for the CSC and the other to lunch a GUI. The display variable defined in the GUI container must be pointed to the host that will receive the image, if that will be your computer, then write your IP in that variable. Entrypoints has been modified, the CSC is starting with a custom scripts called startCSC.sh whereas the GUI container is starting with a custom script called startGUI.sh. Those scripts has all the required configuration plus starting the software we need from the container.

## Electrometer
It is using image: lsstts/electrometer, it has two definitions, one for the CSC and the other to lunch a GUI. The display variable defined in the GUI container must be pointed to the host that will receive the image, if that will be your computer, then write your IP in that variable. Entrypoints has been modified, the CSC is starting with a custom scripts called startCSC.sh whereas the GUI container is starting with a custom script called startGUI.sh. Those scripts has all the required configuration plus starting the software we need from the container.
The port for the electrometer had to be added following the instructions in: https://confluence.lsstcorp.org/display/LTS/Setting+up+a+serial+port

# AT_EFD

Here you will find several scripts that allows you to start containerized version of an EFD, currently is only configured to have MySQL onine. Below a briew description of the services created and how are meant to be used.

 * EFD_Updater: Used to populate the EFD with SQL queries.
 * EFD_MariaDB: This container starts a MariaDB instance that is configured from the EFD_Updater to have the EFD DB created plus all the necessary configurations/table creation.
 * EFD_ATDome: This service is starting all the writers related with the ATDome.
 * EFD_ATHexapod: This service is starting all the writers related with the ATHexapod.
 * EFD_ATMCS: This service is starting all the writers related with ATMCS
 * EFD_ATptg: This service is starting all the writers related with the pointing kernel
 * EFD_ATDomeTrajectory: This service is starting all the writers related with the Dome Trajectory
 * EFD_ATPneumatics: This service is starting all the writers related with the AT Pneumatics
 * EFD_ATAOS: This service is starting all the writers related with the AT AOS.

 All the efdwriters are being started by a shell script called efd_writers.sh, which launches the 3 writers in the background with the exception of the last one to keep the container alive.

 # AT_Simulators
This compose has several definitions for CSC/Simulators that can be used to test communication back and forth. Below a list of available containers and their respective images:

 * atmcs-sim:
   * image: lsstts/at_mcs_sim:3.9-0.4
 * atdome-sim:
   * image: lsstts/at_dome_sim:3.9-0.5
 * atdometrajectory-sim:
   * image: lsstts/at_dome_trajectory_sim:3.9-0.6a
 * atpneumatics-sim:
   * image: lsstts/at_pneumatics_sim:3.9-0.2
 * ataos-sim:
   * image: lsstts/ataos:v0.2.1
 * atptg-sim:
   * image: tiagorib/ptkernel:new_xml
 * simulation-tests:
   * image: lsstts/simulation_tests:latest

#!/bin/bash
# GaoMingjie - Aug 2018


# check psql installed?

# https://blog.csdn.net/wncnke/article/details/54847140

# check psqlrc already include pp?


numargs=$#
i=1

WORKSPACE=`pwd`
EXTENSION=psqlplus
MAIN_FILE=$EXTENSION.psql
MAIN_FOLDER=sql

HELP=false
INSTALL=false
UPDATE=false
PSQLRC_FILE=


log() {
  echo -e "[LOG]$*"
}

logred() {
  echo -e "\033[32m[LOG]$*\033[0m"
}

logyellow() {
  echo -e "\033[33m[LOG]$*\033[0m"
}

logblue() {
  echo -e "\033[34m[LOG]$*\033[0m"
}


while [ $i -le $numargs ]; do
  j=$1
  if [ $j = "-help" ] || [ $j = "-h" ]; then
    HELP=true
  fi

  if [ $j = "install" ]; then
    INSTALL=true
  fi

  if [ $j = "update" ]; then
    UPDATE=true
  fi

  if [ $j = "-psqlrc" ]; then
     PSQLRC_FILE=$2
     shift 1
     i=`expr $i + 1`  
  fi

  i=`expr $i + 1`
  shift 1
done

if [ $numargs -eq 0 ]; then
  HELP=true
fi

if [ $HELP = "true" ]; then
  echo  "help me... todo"
  echo
  echo  "help me... todo"
  exit
fi

if [ $UPDATE = "true" ]; then
  echo  "start update"
  # remove everything and 
  exit
fi



if [ $INSTALL = "true" ]; then
  logblue  "start installation"
  if [ -f $MAIN_FILE ] && [ -d $MAIN_FOLDER ]; then
  	logyellow "$MAIN_FILE file exists, start local installation"
  	VERSION=`head -1 $MAIN_FILE`
  	log "local version is ${VERSION##*-}"
  else
  	logyellow "$MAIN_FILE file dose not exist, start remote installation"
  	logyellow "please confirm that you can access github.com"
  fi

  if [ -z $PSQLRC_FILE ]; then
    logyellow ".psqlrc is not specified, automatically set to \$HOME/.psqlrc"
    PSQLRC_FILE=$HOME/.psqlrc
  fi

  if [ ! -f $PSQLRC_FILE ]; then
  	logyellow ".psqlrc file does not exist, create one now"
  	touch $PSQLRC_FILE
  fi

  # check foler
  # wget src
  # log version and release date


  grep -q '^\\set pp.*psqlplus.psql' $PSQLRC_FILE
  if [ $? -eq 0 ]; then
    log "psqlplus has been installed, now clean up and reinstall"
    sed -ni '/^\\set pp.*psqlplus.psql/d' $PSQLRC_FILE
    echo "\\set pp '\\\\i `pwd`/$EXTENSION.psql'" >> $PSQLRC_FILE
  else
    echo "\\set pp '\\\\i `pwd`/$EXTENSION.psql'" >> $PSQLRC_FILE
  fi
fi

# \set dba '\\i /home/jackgo/projects/postgres_dba/start.psql'

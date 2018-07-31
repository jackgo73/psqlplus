#!/bin/bash
# GaoMingjie - Aug 2018


numargs=$#
i=1

WORKSPACE=`pwd`
EXTENSION=psqlplus
MAIN_FILE=$EXTENSION.psql
MAIN_FOLDER=src

HELP=false
INSTALL=false
UPDATE=false
PSQLRC_FILE=
VERSION_URL='https://raw.githubusercontent.com/mutex73/psqlplus/master/VERSION'
RELEASE_URL='https://github.com/mutex73/psqlplus/archive/'

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

unameout="$(uname -s)"
case "${unameout}" in
  Linux*)     machine=Linux;;
  Darwin*)    machine=Mac;;
  CYGWIN*)    machine=Cygwin;;
  MINGW*)     machine=MinGw;;
  *)          machine="UNKNOWN:${unameout}"
esac

if [ ${machine} != "Linux" ] && [ ${machine} != "Mac" ]; then
  echo "System is not supported"
  exit
fi


while [ $i -le $numargs ]; do
  j=$1
  if [ $j = "--help" ] || [ $j = "-h" ]; then
    HELP=true
  fi

  if [ $j = "install" ]; then
    INSTALL=true
  fi

  if [ $j = "update" ]; then
    UPDATE=true
  fi

  if [ $j = "--psqlrc" ] || [ $j = "-r" ]; then
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
  echo  "Usage:"
  echo  "./setup.sh [OPTION] COMMAND"
  echo  
  echo  "Command:"
  echo  "  install       start installation"
  echo  "  update        start upgrading"
  echo
  echo  "Options:"
  echo  "  -r, --psqlrc  location of .psqlrc"
  echo  "  -h, -help     show this help, then exit"  
  echo 
  echo  "Example:"
  echo  "  ./setup install"
  echo  "  ./setup -r ~/.psqlrc"
  echo  "  ./setup update"
  exit
fi

if [ $UPDATE = "true" ]; then
  logblue  "Start upgrading"
  rm $MAIN_FILE 1>/dev/null 2>&1
  rm -rf $MAIN_FOLDER 1>/dev/null 2>&1
  rm VERSION 1>/dev/null 2>&1
  version=`curl $VERSION_URL 2>/dev/null`
  log "remote version: ${version}, start downloading package"
  filename=$version".tar.gz"
  wget -q $RELEASE_URL$filename 
  tar xzvf $filename 2>&1 1>/dev/null
  mv psqlplus-${version:1}/* ./    # psqlplus-0.1-alpha
  rm -rf psqlplus-$version 1>/dev/null 2>&1
  rm $filename 1>/dev/null 2>&1
  if [ ! -f $MAIN_FILE ] || [ ! -d $MAIN_FOLDER ]; then
      logyellow "update failed, please visit https://github.com/mutex73/psqlplus"
      exit
    fi
    logblue "update successful, exit"
  exit
fi


if [ $INSTALL = "true" ]; then
  logblue  "start installation"
  if [ -f $MAIN_FILE ] && [ -d $MAIN_FOLDER ]; then
    logyellow "$MAIN_FILE and $MAIN_FOLDER folder exists, start [local installation]"
    version=`head -1 $MAIN_FILE`
    log "system: $machine, local version: ${version##*-}"
  else
    logyellow "$MAIN_FILE or $MAIN_FOLDER folder dose not exist, start [remote installation]"
    # check tools
    command -v wget 1>/dev/null 2>&1 || { logyellow "wget is not installed, exit installation"; exit 1; }
    command -v tar 1>/dev/null 2>&1 || { logyellow "wget is not installed, exit installation"; exit 1; }

    log "please confirm that you can access github.com"
    log "fetching the latest version"
    version=`curl $VERSION_URL 2>/dev/null`
    log "system: $machine, remote version: ${version}, start downloading package"
    
    filename=$version".tar.gz"       # v0.1-alpha.tar.gz
    wget -q $RELEASE_URL$filename 
    tar xzvf $filename 2>&1 1>/dev/null
    mv psqlplus-${version:1}/* ./    # psqlplus-0.1-alpha

    rm -rf psqlplus-$version 1>/dev/null 2>&1
    rm $filename 1>/dev/null 2>&1

    if [ ! -f $MAIN_FILE ] || [ ! -d $MAIN_FOLDER ]; then
      logyellow "download failed, please visit https://github.com/mutex73/psqlplus/releases and install manually"
      exit
    fi
    log "download successful, installation begins..."
  fi


  if [ ! -f $MAIN_FILE ] || [ ! -d $MAIN_FOLDER ]; then
    logyellow "$MAIN_FILE or $MAIN_FOLDER folder does not exist, exit installation"
    exit
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
    if [ ${machine} == "Linux" ]; then
      sed -ni '/^\\set pp.*psqlplus.psql/d' $PSQLRC_FILE
    elif [ ${machine} == "Mac" ]; then
      sed -ni "" '/^\\set pp.*psqlplus.psql/d' $PSQLRC_FILE
    fi
    echo "\\set pp '\\\\i `pwd`/$EXTENSION.psql'" >> $PSQLRC_FILE
    logblue "installation is complete, start psql and input :pp"
  else
    echo "\\set pp '\\\\i `pwd`/$EXTENSION.psql'" >> $PSQLRC_FILE
    logblue "installation is complete, start psql and input :pp"
  fi
fi

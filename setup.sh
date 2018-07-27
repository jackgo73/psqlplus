#!/bin/bash
# GaoMingjie - Aug 2018


# check psql installed?

# https://blog.csdn.net/wncnke/article/details/54847140

# check psqlrc already include pp?


numargs=$#
i=1

HELP=false
INSTALL=false


echored() {
	echo -e "\033[5;31m$*\033[0m"
}


while [ $i -le $numargs ]; do
  j=$1
  if [ $j = "-help" ] || [ $j = "-h" ]; then
    HELP=true
  fi
  i=`expr $i + 1`
  shift 1
  if [ $j = "install" ]; then
    INSTALL=true
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

if [ $INSTALL = "true" ]; then
  echored  "installing"
  
fi



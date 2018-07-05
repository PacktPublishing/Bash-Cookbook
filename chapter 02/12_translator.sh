#!/bin/bash
./hellobonjour.sh

export TEXTDOMAIN="hellobonjour"
export TEXTDOMAINDIR=`pwd`/locale

export LANGUAGE=fr
./hellobonjour.sh

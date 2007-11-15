#!/bin/bash

# addwget.sh - Copyright (C) 2007 prizident <prizident@gmail.com>

SERVER_ROOT="~/public_html/"
TMPDIR="/tmp/"
#SERVERADDR=""
FILE=$1
FILEDIR=`dirname "${FILE}"`
FILENAME=`basename "${FILE}"`
TMPFILE="/tmp/addwget_tmp"

source ~/.addwget

#replace ~ with home dir
SERVER_ROOT=${SERVER_ROOT//"~"/${HOME}}
FILEDIR=${FILEDIR//"~"/${HOME}}

if [ ! -d ${SERVER_ROOT}/${TMPDIR} ];
then
    echo "TMPDIR not exist, creating"
    mkdir -p ${SERVER_ROOT}/${TMPDIR}
fi

if [ ${FILEDIR} == "." ];
then
    FILEDIR=${PWD}
fi
FILEFULL=${FILEDIR}/${FILENAME}

if [ ! -f "${FILEFULL}" ];
then
    echo "File not exist"
    exit 1
fi

echo "Full path is" ${FILEFULL}

    echo "Creating symlink for file in TMPDIR"
    ln -sf "${FILEFULL}" "${SERVER_ROOT}/${TMPDIR}/${FILENAME}"

    ENC_FILENAME=$(echo -n "${FILENAME}"|php -r '$information = fread(STDIN, 1024); echo rawurlencode($information);')
    LINK=${SERVERADDR}/${TMPDIR}/${ENC_FILENAME}
    ENC_LINK=$(echo -n "${LINK}"|php -r '$information = fread(STDIN, 1024); echo urlencode($information);')
    echo "Weblink is "${ENC_LINK}


if [ -z "$2" ];
then
    DESC="//by non7top"
else
    DESC=$2
fi

ENC_DESC=$(echo -n "${DESC}"|enconv -x cp1251|php -r '$information = fread(STDIN, 1024); echo urlencode($information);')

POSTDATA="downfileweb=${ENC_LINK}&"
POSTDATA=${POSTDATA}"taskid=1&"
POSTDATA=${POSTDATA}"srch=1&"
POSTDATA=${POSTDATA}"searchc=53&"
POSTDATA=${POSTDATA}"description="${ENC_DESC}

echo ${POSTDATA}

wget -q --load-cookies ~/.mozilla/firefox/y6gu93xi.default/cookies.txt \
--post-data "${POSTDATA}" \
http://file.aaanet.ru/?webget=1 \
-O "${TMPFILE}"

cat "${TMPFILE}"|enconv|grep "Нед"

exit 0

downfileweb=http%3A%2F%2Fmysite.domain.org%2Fmyfile.zip&
taskid=1&
Add=%C4%EE%E1%E0%E2%E8%F2%FC%21&
searchc=53&
srch=1&
description=jjsahbdfsfnb+savs

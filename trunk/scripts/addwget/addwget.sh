#!/bin/bash
# addwget.sh - Copyright (C) 2007 prizident <prizident@gmail.com>
# The script is licensed under GPLv3 and above

SERVER_ROOT="~/public_html/"
TMPDIR="/tmp/"
CONFFILE=~/.addwget
FILE=$1
FILEDIR=`dirname "${FILE}"`
FILENAME=`basename "${FILE}"`
TMPFILE="/tmp/addwget_tmp.html"



#check if config exists
if [ ! -f "${CONFFILE}" ];
then
	echo "Config file ${CONFFILE} doesn't exist"
	exit 1
else
	source ${CONFFILE}	
fi

#check config variable

if [ -z ${SERVERADDR} ];
then
	echo "You should set SERVERADDR variable in your config ${CONFFILE}"
	echo "eg SERVERADDR=http://213.27.*.*:80/"
	exit 1
fi
	

#replace ~ with home dir
SERVER_ROOT=${SERVER_ROOT//"~"/${HOME}}
FILEDIR=${FILEDIR//"~"/${HOME}}

if [ ! -d ${SERVER_ROOT}/${TMPDIR} ];
then
    echo "TMPDIR not exist, creating"
    mkdir -p ${SERVER_ROOT}/${TMPDIR}
fi

# Если файл в текущей папке, то путь к нему получаем из переменной PWD
if [ ${FILEDIR} == "." ];
then
    FILEDIR=${PWD}
fi

FILEFULL=${FILEDIR}/${FILENAME}

# проверяем существует ли файл
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

#echo ${POSTDATA}

wget -q --load-cookies ~/.mozilla/firefox/*.default/cookies.txt \
--post-data "${POSTDATA}" \
http://file.aaanet.ru/?webget=1 \
-O "${TMPFILE}"

cat "${TMPFILE}"|enconv|grep "<!--"

exit 0

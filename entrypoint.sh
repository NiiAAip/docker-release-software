#!/bin/sh -l

VERSION=`echo $GITHUB_WORKSPACE/$@ | grep -E '[0-9]+\.[0-9]+\.[0-9]+' -o`
JOB_ID=`stat -c %Y $GITHUB_WORKSPACE/$@`
MD5=`md5sum $GITHUB_WORKSPACE/$@ | cut -d ' ' -f 1`
PATH_=$INPUT_ALIYUN_OSS_URL

ossutil64 config -e $INPUT_ALIYUN_OSS_ENDPOINT -i $INPUT_ALIYUN_ACCESS_ID -k $INPUT_ALIYUN_ACCESS_SECRET -L CH
ossutil64 cp -rf $GITHUB_WORKSPACE/$@ $INPUT_ALIYUN_OSS_URL

RESULT=$(echo "{ \"Version\": \"${VERSION}\", \"Job-ID\": ${JOB_ID}, \"MD5\": \"${MD5}\", \"Release-Note\": \"\", \"Path\": \"${PATH_}\", \"Path2\": \"\", \"Path3\": \"\"}")
echo $RESULT

res=`curl -d "username=$INPUT_OTA_SERVER_USER" -d "password=$INPUT_OTA_SERVER_PWD" -X POST -c cookie.txt $INPUT_OTA_SERVER_URL/login`
if [[ $res != 'login!' ]]; then
    echo $res
    exit 1
fi

res=`curl -b cookie.txt -H "Content-Type:application/json" -H "Secret-Token:$INPUT_OTA_SOFTWARE_TOKEN" -X POST -d "$RESULT" $INPUT_OTA_SERVER_URL/gitlab-webhook/release/`
curl -b cookie.txt $INPUT_OTA_SERVER_URL/logout
rm -rf cookie.txt
if [[ $res != 'Done!' ]]; then
    echo $res
    exit 1
fi

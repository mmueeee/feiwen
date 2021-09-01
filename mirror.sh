#!/bin/bash
#
# 镜像静态网站
#

WK_DIR=$(
  cd $(dirname $0)
  pwd
)

TEMP_DIR=${WK_DIR}/temp

TARGET="newshasha3.com"
BASE_SITE="http://${TARGET}"
TIME=$(date "+%Y-%m-%d %H:%M:%S")

if [[ -d "${TEMP_DIR}" ]]; then
  rm -rf "${TEMP_DIR}"
fi
mkdir -p "${TEMP_DIR}"

pushd ${TEMP_DIR}

wget -c -m -k -np -p -E -U Mozilla --no-check-certificate $BASE_SITE
RET=$?

if [[ "$RET" == "0" ]]; then
  echo "镜像成功:${TIME}"
else
  echo "镜像失败:$RET"
  exit -1
fi

popd

NEW_MD5=$(
  cd ${TEMP_DIR}/${TARGET}
  md5 -q *
)
OLD_MD5=$(
  cd ${WK_DIR}/${TARGET}
  md5 -q *
)

OLD_MD5=$(md5 -q -s "${OLD_MD5}")
NEW_MD5=$(md5 -q -s "${NEW_MD5}")

echo "OLD_MD5 ${OLD_MD5}"
echo "NEW_MD5 ${NEW_MD5}"

if [[ "${OLD_MD5}" == "${NEW_MD5}" ]]; then
  echo "无变化"
else
  echo "有更新"
fi

cp -r ${TEMP_DIR}/${TARGET}/* ${WK_DIR}/${TARGET}

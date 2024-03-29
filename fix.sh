#!/bin/bash
#
# 适配移动端
#

WK_DIR=$(
  cd $(dirname $0)
  pwd
)

TARGET_DIR=${WK_DIR}/newshasha3.com
cp ${WK_DIR}/plumber.js ${TARGET_DIR}
cp ${WK_DIR}/style.css ${TARGET_DIR}

# 修改 viewport 适配移动端
sed -i "" "s/<meta/<meta name=\"viewport\" content=\"width=device-width,initial-scale=1,maximum-scale=1,minimum-scale=1,user-scalable=no\"><meta/g" ${TARGET_DIR}/*.htm*

# 取消固定宽
sed -i "" "s/<table width=\"1000\"/<table/g" ${TARGET_DIR}/*.htm*

# 图片适配
sed -i "" "s/<img/<img style=\"width: 100%;\"/g" ${TARGET_DIR}/*.htm*

# 注入js
sed -i "" "s/<\/html>/<script src="plumber.js"><\/script><\/html>/g" ${TARGET_DIR}/*.htm*

# 注入样式
sed -i "" "s/<\/html>/<link rel=\"stylesheet\" type=\"text\/css\" href=\"style\.css\"><\/html>/g" ${TARGET_DIR}/*.htm*

# 评论
# sed -i "" "s/<\/html>/<div\ id=\"lv-container\"\ data-id=\"city\"\ data-uid=\"MTAyMC81Njg5Ni8zMzM2MA==\">	<script\ type=\"text\/javascript\">\ (function(d,\ s)\ {\ var\ j,\ e\ =\ d.getElementsByTagName(s)[0];\ if\ (typeof\ LivereTower\ ===\ \'function\')\ {\ return;\ }\ j\ =\ d.createElement(s);\ j.src\ =\ \'https:\/\/cdn-city.livere.com\/js\/embed.dist.js\';\ j.async\ =\ true;\ e.parentNode.insertBefore(j,\ e);\ })(document,\ \'script\');	<\/script><noscript>^_^<\/noscript><\/div><\/html>/g" ${TARGET_DIR}/*.htm*

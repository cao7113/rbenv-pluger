#!/usr/bin/env bash
set -e
cd ~
echo rm useless dir when initially on ubuntu
files=(公共的 模板 视频 图片 文档 音乐 examples.desktop)
for f in ${files[*]};do
 [ -e $f ] && rm -fr ~/$f && echo rm $f ...
done

[ -e 下载 ] && mv 下载 down && echo move 下载 to down
ln -sb 桌面 top && echo link top to 桌面

echo end.

#!/bin/bash
#日志
log_file="/storage/emulated/0/Android/bilibili/bilibili.log"
#视频输出目录
output_dir="/storage/emulated/0/Android/bilibili/"
#回收站目录
recycle_dir="/storage/emulated/0/1/Recycle/"
#遍历各app缓存目录
for i in tv.danmaku.bili com.bilibili.app.in com.bilibili.app.bule
do
#缓存目录
dir="/storage/emulated/0/Android/data/$i/download/"
echo "$(date '+%Y-%m-%d %H:%M:%S'):开始转换$dir目录下的视频。" >> $log_file
#获取缓存目录列表
files=$(ls $dir)
#遍历视频缓存
for filename in $files
do
#bilibili av号
id=$filename
#视频目录
dir2=$dir$id
#获取视频数目
count=$(ls -l $dir2|grep "-"|wc -l)
	#遍历视频
	for((j=1;j<=$count;j++));
	do
	#视频目录
	dir3=$dir2/$j
	title=$(awk -F \" '{print $14}' $dir3/entry.json)
	#全部特殊字符替换为划线
	title=${title// /_}
	title=${title//'/'/_}
	title=${title//'\'/_}
	output_dir2=$output_dir$title
	part=$(awk -F \" '{print $54}' $dir3/entry.json)
	part=${part// /_}
	part=${part//'/'/_}
	part=${part//'\'/_}
	echo -e "$part"
	#创建视频目录
	if [ ! -d "$output_dir$title" ];then
	mkdir $output_dir$title
	echo "$(date '+%Y-%m-%d %H:%M:%S'):创建目录$output_dir$title成功！" >> $log_file
	fi
	#开始缓存视频转换
	ffmpeg -i $dir3/*/video.m4s -i $dir3/*/audio.m4s -codec copy $output_dir2/$part.mp4
	#如果转换成功，则将缓存文件放置到回收站文件夹中
	if [ ! -f "$output_dir2/$part.mp4" ];then
	echo "$(date '+%Y-%m-%d %H:%M:%S'):视频$dir3已成功转换到目录$output_dir2" >> $log_file
	mv $dir3 $recycle_dir$dir2
	echo "$(date '+%Y-%m-%d %H:%M:%S'):$dir3已放入回收站" >> $log_file
	fi
	done
done
done

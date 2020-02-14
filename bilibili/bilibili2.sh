#!/bin/bash
#当前时间戳
datetime=$(date '+%Y-%m-%d %H:%M:%S')
#日志文件
log_file="/storage/emulated/0/Android/bilibili/bilibili.log"
#遍历各app缓存目录
for i in tv.danmaku.bili com.bilibili.app.in 
#com.bilibili.app.bule
	do
	#视频输出目录
	output_dir="/storage/emulated/0/Android/bilibili/$i/"
	#回收站目录
	recycle_dir="/storage/emulated/0/1/Recycle/$i/"
	if [ ! -d "$recycle_dir" ];then
		mkdir -p $recycle_dir
		echo "$datetime:创建目录$output_dir$title成功！" >> $log_file
	fi
	#缓存目录
	dir="/storage/emulated/0/Android/data/$i/download/"
	echo "$datetime:开始转换$dir目录下的视频。" >> $log_file
	#获取缓存目录列表
	files=$(ls $dir)
	#遍历视频缓存
	for filename in $files
		do
		#bilibili av号
		id=$filename
		#视频目录
		dir2=$dir$id
		#遍历多视频,按文件名排序，为解决下载多P视频的非首P和全量视频合并报错的问题
		files2=$(ls -l $dir2 |awk '/^d/ {print $NF}') 
		for j in $files2
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
			echo "$datetime:开始转换app:$i缓存的视频$title(av:$id)中的第$j个视频:$part" >> $log_file
			#创建视频目录
			if [ ! -d "$output_dir$title" ];then
				mkdir -p $output_dir$title
				echo "$datetime:创建目录$output_dir$title成功！" >> $log_file
			fi
			开始缓存视频转换
			ffmpeg -i $dir3/*/video.m4s -i $dir3/*/audio.m4s -codec copy $output_dir2/$j.$part.mp4
			#如果转换成功，则将缓存文件放置到回收站文件夹中
			if [ -s $output_dir2/$j.$part.mp4 ];then
				mv -i $dir3 $recycle_dir$id
				if [ -d $recycle_dir$id/$j ];then
					echo "$datetime:$id已成功放入回收站" >> $log_file
				fi
			fi
			done
		done
	done
echo "------------------------------------------------------------end-----------------------------------------------------------------------">> $log_file

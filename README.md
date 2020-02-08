# shell
此脚本需要安卓手机安装Termux客户端实现
#允许Termux访问SD卡
termux-setup-storage
#更新清华源（可以不用改）
apt edit-sources 
## 国内用户建议使用的源列表内容
# The main termux repository
# deb [arch=all,你的平台架构] http://termux.net stable main
deb [arch=all,你的平台架构] http://mirrors.tuna.tsinghua.edu.cn/termux stable main
#安装ffmpeg包及基本工具
pkg update
pkg install vim curl wget git unzip unrar ffmpeg
#哔哩哔哩有海外版，国内版以及概念版，分别对应不同的缓存目录
#国内版本
/storage/emulated/0/Android/data/tv.danmaku.bili/download/
#国际版本
/storage/emulated/0/Android/data/com.bilibili.app.in/download/
#概念版本
/storage/emulated/0/Android/data/com.bilibili.app.bule/download/

以前使用过安卓版本的缓存视频合并和python脚本，但是总感觉不是很方便，偶然之前在知乎看到有人发了一个shell脚本，遂想练习下shell脚本，于是拿来练习了一下

出处：https://zhuanlan.zhihu.com/p/1044963

我根据使用习惯，在APP缓存完视频以后，通过本地Termux或者ssh远程连接执行脚本，一键转换视频到指定目录，可以通过安卓版本的FolderSync同步到家里的PC、路由器、NAS、树莓派、Onedriver等存储介质，方便离线查看

并在成功合并视频后转移缓存视频到指定目录，去定时删除他，规避了rm使用，避免删除失误

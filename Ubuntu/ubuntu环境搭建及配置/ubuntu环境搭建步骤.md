## ubuntu基本环境配置
1. 安装fctix输入法,系统设置下载语言包及参考[谷歌输入法](https://zhuanlan.zhihu.com/p/508797663)  
   - 添加自定义词库[参考链接](https://bbs.deepin.org/post/253191)
``` bash
git clone https://github.com/CHN-beta/sougou-dict
cd sougou-dict
cat dict/*.txt > dict.txt
libime_pinyindict dict.txt sougou.dict
cp *.dict $HOME/.local/share/fcitx5/pinyin/dictionaries/
```
2. 安装谷歌浏览器  
3. ubuntu换源   
```bash
sudo bash -c 'echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy main restricted universe multiverse" > /etc/apt/sources.list'
```
4. 安装nvim: sudo apt install neovim  
5. 导入~/.bashrc文件
6. 安装ranger: 参考github上的官方网站  
  - 安装ueberzug[ueberzug包下载网站](https://mirrors.aliyun.com/ubuntu-ports/pool/universe/u/ueberzug/?spm=a2c6h.25603864.0.0.108b237brwk1YX)
    - 下载`ueberzug_18.1.9.orig.tar.gz`  
    - tar -xvf ueberzug_18.1.9.orig.tar.gz
    - 进入解压后的文件夹
    - sudo python3 setup.py build
    - sudo python3 setup.py install
7. 安装llvm(官网下载)
8. 安装node[官网下载Linux Binaries (x64)](https://nodejs.org/en/download)
9. 安装yarn，npm: `sudo apt-get install yarn npm`  
10. 安装tmux[官网下载](https://github.com/tmux/tmux)
11. 安装git  
  - github添加ssh密钥[参考](https://www.runoob.com/git/git-remote-repo.html)
12. 安装tmux插件管理器[tpm](https://github.com/tmux-plugins/tpm)  
  - 进入tmux后
    - 按`prefix + I`来安装插件  

13. 搭建stm32环境
  - 安装arm-none-eabi工具: `sudo apt-get install gcc-arm-none-eabi`  
  - 安装openocd[参考](https://mp.weixin.qq.com/s?__biz=MzUyMTE0NTA2Ng==&amp;mid=2247483716&amp;idx=1&amp;sn=73059c48b72da90d16771c66cd59554e&amp;chksm=f9dedec1cea957d714f65d17522ddb707b89b63c5aeef1040358ec7f45bd077c53297b8c7642&amp;scene=21#wechat_redirect)

```bash
# aopenocd依赖项
 sudo apt-get install libtool-bin
 sudo apt-get install libhidapi-dev
 sudo apt-get install libusb++-dev
 sudo apt-get install libusb-1.0-0-dev
```

14. 安装bear，用于生成compile_commands.json文件，给clang提供...  

15. 安装clangd到./config/coc/extensions/coc-clangd-data/install  

16. 修改截图快捷键:
  - setting -> keyboard -> shortcuts -> ...  

17. vim编写markdown后，预览效果时，将成品导出为pdf时，遇到需要`princexml`时的解决方法:  
  - `sudo apt-get install libavif13`或`sudo aptitude install libavif13`
    - 如果还不行，就去prince官网下载prince  

18. 安装gparted,用于磁盘扩容  
  - `sudo apt-get install gparted`  

19. ubuntu 滚轮调速  
   - [参考链接](https://blog.csdn.net/weiguang102/article/details/121357192)  
   - 安装:`sudo apt-get install imwhell`
   - 配置文件:~/.imwheelrc  
   - 配置内容:`见链接`  



## 配置verilog环境
1. 安装verilator[参考网址](https://verilator.org/guide/latest/install.html)  
  > 更新bashrc:`export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/home/awjl/software/verilator/include`
  >> 变量值应该为verilator安装路径  

2. 安装波形显示软件:`apt-get install gtkwave`  

3. nvboard环境配置:`sudo apt-get install libsdl2-dev libsdl2-image-dev`  

4. 安装vivado  
  > `sudo apt-get install libncurses5`  

---


## 安装QT5.15
1. 去官网下载需要版本  
2. `sudo chmod +x qt-unifited....`  
3. 运行`./qt...`即可  

---

## 安装docsify,用于搭建基于markdown,git的书籍
1. 安装docsify:`npm i docsify-cli -g`



---

## Python环境配置
1. 官网下载anaconda  
2. 在终端运行安装  
3. 根据需要建立环境(我建了一个awjl的环境)安装包  
### 已经安装的包(图像处理)
1. conda install pillow  
2. pip install opencv-python  
3. conda install opencv  




## 安装logisim-数字逻辑电路绘画及仿真工具
1. 安装java环境:`sudo apt-get install default-jdk`  
2. 安装logisim.jar文件.[参考链接](https://vlab.ustc.edu.cn/downloads/logisim-generic-2.7.1.jar)  
   - 需要中文版的话另找资源  
3. 赋予`.jar`文件可执行权限.`chmod +x`  
4. 在`.bashrc`文件中添加`alias logisim='java -jar ~/Software/logisim-generic-2.7.1.jar'`  
4. 运行logisim. `logisim`  


























# ccache
能够加速c的编译速度，具体通过man查看手册。  
第二次编译后，ccache跳过来完全重复的编译过程，发挥来加速的作用。  

# 已建立的软链接
ln -s /usr/bin/ccache /usr/local/bin/gcc  
ln -s /usr/bin/ccache /usr/local/bin/g++  

参考链接： https://askubuntu.com/questions/1398344/apt-key-deprecation-warning-when-updating-system
# 问题简述：sudo apt-get update 报错
  W: https://packagecloud.io/**AtomEditor**/atom/any/dists/any/InRelease: Key is stored in legacy trusted.gpg keyring (/etc/apt/trusted.gpg), see the DEPRECATION section in apt-key(8) for details.
# 解决步骤
1. sudo apt-key list
2. 找到报错的相关key
3. 选取PUB的那一串16进制数字的后八位
4. 执行命令 sudo apt-key export 八个数字 | sudo gpg -dearmour -o /etc/apt/trusted.gpg.d/相关名字（如上就是AtomEditor）

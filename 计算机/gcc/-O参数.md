# -O1,-O2…参数
1. -O0： 表示关闭所有优化选项，也就是默认的参数
2. -O1,-O2,-O3,……:随着数字的增大，代码的优化程度也越高
    - 不过这是以牺牲程序的可调试性为代价的
3. Os： 是在-O2的基础上去掉了那些会导致最终可执行程序增大的优化
    - 要得到最小的可执行程序，可以用这个选项

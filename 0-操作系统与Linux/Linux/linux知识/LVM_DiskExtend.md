# LVM (Logical Volume Manager)
> :bulb: LVM是存在于物理磁盘(虚拟磁盘)与linux文件系统之间的抽象框架。  

**LVM功能**: 用来将独立的块设备9(分区)合成卷组(VGs), 然后将VGs分割成多个逻辑块设备或者逻辑卷(LVs).  

**PVs**: PVs是物理卷，是由硬盘分区或整个硬盘通过 pvcreate 工具初始化后创建的  

**VGs**: 卷组  

**LVs**: LVs是抽象的块设备，useable文件系统就驻留在这些设备上  


![LVM工作原理可视化实例](img/LVM工作原理可视化实例.png)

> 上图介绍: 我们有五个不同的磁盘，每个磁盘都有一个映射到物理卷 (PV) 的分区，所有分区都被归入一个卷组 (VG)。卷组被分割成两个不同的逻辑卷（LV），每个逻辑卷用于一个文件系统

# Disk Extend
> :bulb: 重要命令如下:  
```bash
lsblk #查看当前设备的分区信息

sudo fdisk -l # 查看当前设备的信息，可以看到未分区的设备

sudo rsync -av /XX/ /path/to/backup/  #将指定文件夹备份到指定路径

sudo fdisk /dev/nvme0n1 # 对设备进行分区相关操作  

sudo mkfs.ext4 /dev/nvme0n1p1 #对分区进行格式化

mount #挂载命令
umount #卸载挂载
```

## 实例: 将新硬盘挂载到/home/下
1. 通过`sudo fdisk -l`查看设备名`dev/nvme0n1`  

2. **分区和格式化新的硬盘**:  
   ```bash
   sudo fdisk /dev/nvme0n1
   # 根据需要创建分区，完成后格式化
   sudo mkfs.ext4 /dev/nvme0n1p1
   ```

3. 挂载硬盘到临时目录: `sudo mount /dev/nvme0n1p1 /mnt`  

4. 迁移/home/数据到/mnt: `sudo rsync -av /home/ /mnt/`   

5. 卸载临时挂载点，然后挂载到/home下  
   ```bash
   sudo umount /mnt
   sudo mount /dev/nvme0n1p1 /home
   ```  

6. 更新`/etc/fstab`,使得开机时，自动挂载到/home目录，添加如下内容:  
   - > `/dev/nvme0n1p1  /home  ext4  defaults  0  2`  

7. 完成  

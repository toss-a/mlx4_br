# mlx4_br
"Driver" to allow adding mlx4 vf into linux bridge

作用：解决 CX341 CX4421 X520 X710 在开启 SR-IOV 之后，把 VF/PF 加到 Linux Bridge 之后无法通讯的问题

使用：
- 打开openwrt源码将本项目克隆到packages下，运行make menuconfig > Network > mlx4_br(勾选)然后构建

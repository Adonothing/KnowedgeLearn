# 动量

&emsp;&emsp;动量高中物理是选修，这个没有学。当物体的质量 $m$ 乘以加速度 $a$ 等于外力 $F$。而动量 $P$ 是物体质量乘以速度 $v$。为何要引入动量呢？动量是什么呢？动量的定义：

$$
P = m \cdot v \\
\vec{P} = m \cdot \vec{v} \\
$$

那么动量引入的最大意义是什么呢？是动量守恒定律：一个系统不受外力或所受外力之和为零，这个系统的总动量保持不变，这个结论叫做动量守恒定律。把动量掌握了，角动量可以全方位类比动量。

## 角动量

### 基础关系

&emsp;&emsp;首先我们看的就是速度和角度两边的一个直接关系，可以看都都差了一个半径。

$$
v = \omega \cdot r \\
\vec{v} = \vec{\omega} \times \vec{r} \\ 
\Delta x = \Delta \theta \cdot r \\
\Delta \vec{x} = \Delta \vec{\theta} \times \vec{r} \\
a = \alpha \cdot r \\
\vec{a} = \vec{\alpha} \times \vec{r}
$$

接下来我们看速度和角度表达式对应的关系：

$$
\Delta x, \Delta \theta \\
\Delta \vec{x} , \Delta \vec{\theta} \\ 
v = \frac{\Delta x}{\Delta t}, \omega = \frac{\Delta \theta}{\Delta t}  \\
\vec{v} = \frac{\Delta \vec{x}}{\Delta t}, \vec{\omega} = \frac{\Delta \vec{\theta}}{\Delta t}  \\
a = \frac{\Delta v}{\Delta t}, \alpha = \frac{\Delta \omega}{\Delta t}  \\
\vec{a} = \frac{\Delta \vec{v}}{\Delta t}, \vec{\alpha} = \frac{\Delta \vec{\omega}}{\Delta t}
$$

## 动量关系

接下来我们看动量并类比角动量：

$$
P = m \cdot v, L = I \cdot \omega \\
\vec{P} = m \cdot \vec{v}, \vec{L} = I \cdot \vec{\omega} \\
$$

其中 $I$ 为角惯量和质量相对，$L$ 为角动量和动量相对。他们都表现了物体的惯性。接下来我们看力和力矩 $\tau$，注意力矩作为对圆的一种研究，自然是从中心点出发，所以叉乘时，半径在前：

$$
r \cdot F = \tau \\
\vec{r} \times \vec{F} = \vec{\tau} 
$$

注意这里就和上面有区别了，不再是角速度这边乘以半径，而是半径乘以速度这边，所以会导致部分速度和角度两边的关系不再是 $r$，而是 $r^2$。我们再来看看力和速度这边的关系，并直接写对应的力矩和加速度这边的的关系：

$$
F = m \cdot a = m \cdot \frac{\Delta v}{\Delta t} = \frac{\Delta P}{\Delta t} \\
\tau = I \cdot \alpha = I \cdot \frac{\Delta \omega}{\Delta t} = \frac{\Delta L}{\Delta t} \\
$$

上面两式表明对于旋转的惯性，即旋转惯量为：

$$
I = m \cdot r^2
$$

可以看出，物体的质量越大，半径越大，旋转惯量越大，越难改变选装方向和速度。最后强调角动量守恒定律：当系统不受外力作用或所受诸外力对某定点（或定轴）的合力矩始终等于零时，系统的角动量保持不变。对于一个多质点的系统，所有旋转都计算进来，动量和不变。角动量守恒定律指出，当合外力矩为零时，角动量守恒，物体与中心点的连线单位时间扫过的面积不变，在天体运动中表现为开普勒第二定律，神奇！

## 右手螺旋定则

&emsp;&emsp;右手螺旋定则是分为两类的。一类是通过两个矢量得到叉乘的矢量方向：例如矢量 $\vec{A}$ 叉乘矢量 $\vec{B}$：用右手螺旋规律，便是：先把手掌除大拇指以外的4个指头打开，指向矢量 $\vec{A}$ 的方向。然后把4个指头弯起来，弯的方向由矢量 $\vec{A}$ 转向矢量 $\vec{B}$ （转的视点须小于180度）。此刻大拇指立起的方向，便是矢量 $\vec{A}$ 叉乘矢量 $\vec{B}$ 的方向。

&emsp;&emsp;第二种是相当于已知叉乘的矢量方向，问其旋转方向。同样地，先把手掌除大拇指以外的4个指头打开，大拇指沿着这个矢量立起，4个指头弯曲起来（转的视点须小于180度）。此时弯的方向就是旋转方向。

&emsp;&emsp;当然还有第三种，高中学的安培定则，研究电流和磁场的方向，这个本质是一样的，但是由于普适性窄，所以不讨论了。

&emsp;&emsp;所以可以看到，叉乘的顺序是不能改变的，如果改变了，那么方向就反了：

$$
\vec{A} \times \vec{B} = - \vec{B} \times \vec{A}
$$
---
#文章封面
title: "This is the title: it contains a colon"
titleDelim: s
abstract: |
  This is the abstract.

  It consists of two paragraphs.
author:
- Author One
- Author Two
keywords:
- nothing
- nothingness

#添加章编号
chapters: true
linkReferences: true
nameInLink: true

#图编号
figureTitle: 图  #图标题名称
figPrefix: 图  #交叉引用名称
#titleDelim: s  #默认为冒号：:
figureTemplate: $$figureTitle$$$$i$$ $$t$$  #去除titleDelim
#figLabels: arabic #默认为阿拉伯数字
figPrefixTemplate: $$p$$$$i$$ #去除引用名字,default $$p$$&nbsp;$$i$$

#表编号
tableTitle: 表
tblPrefix: 表
tableTemplate: $$tableTitle$$$$i$$ $$t$$
tblPrefixTemplate: $$p$$$$i$$ #去除引用名字

#方程编号
autoEqnLabels: true #公式自动编号
tableEqns: true #使用表格形式对公式进行排版，转word效果更好
eqnBlockTemplate: |
   `<w:pPr><w:tabs><w:tab w:val="center" w:leader="none" w:pos="4325" /><w:tab w:val="right" w:leader="none" w:pos="8681" /></w:tabs></w:pPr><w:r><w:tab /></w:r>`{=openxml} $$t$$ `<w:r><w:tab /></w:r>`{=openxml} $$i$$
#1英寸相当于2.54厘米 1440 twips = one inch A4纸宽度21cm 信纸21.59
#居中pos的计算方式：(页面宽度/2-左边距)*1440/2.54 
#右边pos的计算方式：页面宽度-左边距-右边距
eqnBlockInlineMath: true
equationNumberTeX: \\tag
eqnIndexTemplate: ($$i$$) #这个是给编号加上括号
eqnPrefixTemplate: 式&nbsp;($$i$$) #给引用的公式编号加上括号
#我的word里是A4的，页边距为3.17cm，但是计算得到的数据是偏的
#所以结合手都调整，有两种参数：
#word自带公式的：4322     8637
#mathtype公式的：4325     8681

#参考文献
bibliography: [我的文库.bib]
link-citations: true
reference-section-title: "参考文献"
---

# 卡尔曼滤波

&emsp;&emsp;卡尔曼滤波参考教程：[【从放弃到精通！卡尔曼滤波从理论到实践~】](https://www.bilibili.com/video/BV1Rh41117MT/?p=3&share_source=copy_web&vd_source=6b55cb6788b1952e04c06b095d772810)。从该教程中提取公式并理解。

## 文件说明

1. [KalmanFiltering](./卡尔曼滤波Clang.pdf)：上文中提到的卡尔曼滤波视频教程的pdf文件。
2. []()：。

## P3 进阶（基本滤波知识储备）

### 状态空间表达式

#### 状态方程

::: {custom-style="Figure"}
$$
\begin{equation}
    x_{t} = F \cdot x_{t-1} + B \cdot u_{t-1} + w_{t}
\end{equation}
$${#eq:状态方程}
:::

解释：当前时刻的状态$x_{t}$等于上一时刻的状态$x_{t-1}$乘以系数$F$，加上输入值$u_{t}$乘以系数$B$，最后加上`过程噪声`$w_{t}$。

&emsp;&emsp;$F$又称为`状态转移矩阵`，因为$F$的大小决定了状态变化的快慢。$B$又称为`控制矩阵`，因为$B$的大小决定了输入对系统影响的程度。

&emsp;&emsp;如何理解`过程噪声`$w_{t}$？状态方程的含义是我们对系统的数学建模，构建了一个数学表达式，但是实际的系统往往是复杂的，在随时间变化的时候，会受到各种各样的因素的干扰，可以认为是一个总干扰，这种干扰是随机的，符合正太分布（高斯分布）。

#### 观测方程

::: {custom-style="Figure"}
$$
\begin{equation}
    z_{t} = H \cdot x_{t} + v_{t}
\end{equation}
$${#eq:观测方程}
:::

$z_{t}$是观测量，$x_{t}$是状态量，$H$是状态量的系数，又称`观测矩阵`因为我们假定观测量和状态量之间的关系是线性的，可以由这个线性矩阵$H$表示。$v_{t}$是`观测噪声`。

&emsp;&emsp;可以这样理解：测量值$z_{t}$和状态量$x_{t}$存在一种线性关系，但是测量总是有误差的，所以要加上观测噪声$v_{t}$，观测噪声同样符合正太分布。

&emsp;&emsp;我们可以用一个方框图表示这个系统，但是没有找到一个合适的绘制方框图的绘图软件。

### 参数分析

&emsp;&emsp;噪音服从均值为零的正态分布，可以记为：

::: {custom-style="Figure"}
$$
\begin{equation}
\begin{aligned}
    {{w_{t} \in N(0,Q)}} \\ 
    {{v_{t} \in N(0,R)}}
\end{aligned}
\end{equation}
$${#eq:噪音服从正态分布}
:::

他们的均值均为零，方差分别为$Q$和$R$，方差为常数，与时间无关。$w_{t}$和$v_{t}$就是其中的一个取值，只是取得这个结果的概率服从正态分布。

### 超参数

&emsp;&emsp;噪音的方差，具体是多少，我们是不知道的，是需要不断调节的参数，从而使系统达到稳定。和调节PID一样。

::: {custom-style="Figure"}
$$
\begin{equation}
    Q,R \sim PID
\end{equation}
$${#eq:卡尔曼滤波和PID调参}
:::

### 卡尔曼滤波直观图解

&emsp;&emsp;通过卡尔曼滤波也不会得到真实值，而是每个时刻状态的`最优估计值`$\widehat{x}_{t}$，是修正值，也叫`后验估计值`。总结来说是，上一时刻的`最优估计值`$\widehat{x}_{t-1}$，根据物理理论再加上过程噪声（状态方程）得到的`先验估计值`$\hat{x}_k^{-}$，然后利用有噪音的观测值（观测方程）$z_{t}$，进行加权得到最优估计值$\widehat{x}_{t}$。这样从先验到后验，也就实现了`预测到更新`，而最优估计值的不断变化，也就是`迭代`。因为观测值也是有噪声的，通过得到最优估计值，也就是实现了`滤波`，去除了部分噪音。

## P4 放弃（通俗公式理解）

### 预测模型

&emsp;&emsp;考虑一个情景，一辆匀加速（加速度为$a$）直线运动的小车行驶在公路上，我们研究小车的状态有位置$p$和速度$v$，根据物理规律构建状态方程：

::: {custom-style="Figure"}
$$
\begin{equation}
\begin{aligned}
    &p_t = p_{t-1} + v_{t-1}\cdot\Delta t + \frac {a}2\cdot\Delta t^2 + r_t(p) \\
    &v_t = v_{t-1} + a\cdot\Delta t + r_t(v)
\end{aligned}
\end{equation}
$${#eq:带噪音的匀加速直线运动1}
:::

其中$i$表示当前时刻，$i-1$表示上一时刻。$p_r$是位置噪音，$v_r$是速度噪音，均服从正太分布，噪音是随机的，与时间有关，每个时刻产生随机的噪音。去掉噪音就是高中物理学习的标准的位置和速度公式。写成矩阵形式：

::: {custom-style="Figure"}
$$
\begin{equation}
\begin{bmatrix}
    p_t \\
    v_t
\end{bmatrix}
=\begin{bmatrix}
    1 & \Delta t \\
    0 & 1
\end{bmatrix}
\cdot\begin{bmatrix}
    p_{t-1} \\
    v_{t-1}
\end{bmatrix}
+\begin{bmatrix}
    \frac{\Delta t^2}2 \\
    \Delta t
\end{bmatrix}\cdot a
+\begin{bmatrix}
    r_t(p) \\
    r_t(v)
\end{bmatrix}
\end{equation}
$${#eq:带噪音的匀加速直线运动2}
:::
可以看到该[@eq:带噪音的匀加速直线运动2]，满足状态方程[@eq:状态方程]。

### 预测方程

#### 状态预测

&emsp;&emsp;去除噪音项，就能求出先验估计值：

::: {custom-style="Figure"}
$$
\begin{equation}
    \hat{x}_{t}^{-} = F \cdot \hat{x}_{t-1} + B \cdot u_{t-1}
\end{equation} 
$${#eq:先验估计}
:::

符号$\hat{x}_{t}^{-}$和$\hat{x}_{t-1}$的含义在前文[卡尔曼滤波直观图解](#卡尔曼滤波直观图解)中已经提到，引入符号 $\hat{}$ 和$^{-}$是为了表示估计和先验。

#### 状态误差预测

&emsp;&emsp;上[@eq:先验估计]对比状态方程[@eq:状态方程]，可以求出`先验误差`${e}_{t}^{-}$：

::: {custom-style="Figure"}
$$
\begin{equation}
    {e}_{t}^{-} = x_{t} - \hat{x}_{t}^{-} = F \cdot (x_{t-1} - \hat{x}_{t-1}) + w_{t}
\end{equation}
$${#eq:先验误差}
:::

先验误差表示真实值和预测值的差值。其中$x_{t} - \hat{x}_{t}$为`后验误差`${e}_t$，即：

::: {custom-style="Figure"}
$$
\begin{equation}
    {e}_t = x_{t} - \hat{x}_{t}
\end{equation}
$${#eq:后验误差}
:::

后验误差表示真实值和估计值的差值。所以上[@eq:先验误差]先验误差可以进一步表示为：

::: {custom-style="Figure"}
$$
\begin{equation}
    {e}_{t}^{-} = F \cdot e_{t-1} + w_{t}
\end{equation}
$${#eq:先验误差和后验误差的关系}
:::

&emsp;&emsp;接下来求先验误差的协方差矩阵：

::: {custom-style="Figure"}
$$
\begin{equation}
\begin{aligned}
    Cov({e}_{t}^{-},{e}_{t}^{-}) &= Cov({e}_{t}^{-}) \\
    &= Cov(F \cdot e_{t-1} + w_{t}) \\
    &= F \cdot Cov(e_{t-1}) \cdot F^{T} + Cov(w_{t}) \\
\end{aligned}
\end{equation}
$${#eq:先验误差的协方差矩阵1}
:::

记`先验误差的协方差矩阵`$Cov({e}_{t}^{-}) = P_{t}^{-}$，则上[#eq:先验误差的协方差矩阵1]可以写作：

::: {custom-style="Figure"}
$$
\begin{equation}
    P_{t}^{-} = F \cdot P_{t-1} \cdot F^{T} + Q
\end{equation}
$${#eq:先验误差的协方差矩阵2}
:::

其中$P_{t-1}$是上一时刻的后验误差的协方差矩阵。不同状态之间的噪音很可能不是独立的，他们具有一定的相关性。

### 更新模型

&emsp;&emsp;对于这个小车，我们有卫星测量，卫星只能测量小车的位置$z_t$，测量值$z_t$和实际值$p_t$之间存在观测噪音$\Delta p_t$。卫星无法测量速度，所以观测方程为：

::: {custom-style="Figure"}
$$
\begin{aligned}
    z_p &= p_t + \Delta p_t \\ 
    z_v &= 0
\end{aligned}
$${#eq:位置和速度观测方程}
:::

写成矩阵的形式：

::: {custom-style="Figure"}
$$
\begin{equation}
\begin{bmatrix}
    z_p \\
    z_v
\end{bmatrix}
=\begin{bmatrix}
    1 & 0
\end{bmatrix}
\cdot\begin{bmatrix}
    p_t \\
    v_t
\end{bmatrix}
+\begin{bmatrix}
    1 & 0
\end{bmatrix}\cdot
\begin{bmatrix}
    \Delta p_t \\
    \Delta v_t
\end{bmatrix}
\end{equation}
$${#eq:位置和速度观测方程的矩阵形式}
:::

其中引入了速度观测噪音$v_t$，但是速度是没有测量的，可以去掉这个测量量。同样的有其他传感器的话可以增加测量量。所以观测方程的维度可以和状态方程的维度不同。可以看到该[@eq:位置和速度观测方程的矩阵形式]，满足观测方程[@eq:观测方程]。

### 更新方程

#### 修正估计

&emsp;&emsp;先验估计值是理想状态下，没有噪音，是根据物理理论规律推导出来的当前时刻的预测的状态值$\hat{x}_t^-$。如果我们把状态方程也去除噪音值，当作一个理想的公式，并把这个先验估计值$\hat{x}_t^-$带入去除噪音的观测方程中，那么实际的观测值和理论上理想的观测值之间存在一个差值，这个值就叫`测量残差`，也叫`残差`。

::: {custom-style="Figure"}
$$
\begin{equation}
    残差 = z_t - H \cdot \hat{x}_t^-
\end{equation}
$${#eq:残差}
:::

&emsp;&emsp;我们永远无法得到状态的真实值$x_t$，只能尽量得到一个最优的估计值$\hat{x}_t$，但是这个值无法直接用先验估计值$\hat{x}_t^-$和残差直接表示，因为残差是理想状态计算的观测值和实际的观测值之间的差值，但是这个值并不能直接表示后验估计值$\hat{x}_t$和先验估计值$\hat{x}_t^-$之间的差值，但是可以用一个系数$K_t$使他们相等：

::: {custom-style="Figure"}
$$
\begin{equation}
    \hat{x}_t - \hat{x}_t^- = K_t \cdot (z_t - H \cdot \hat{x}_t^-)
\end{equation}
$${#eq:最优估计偏差和残差的关系}
:::

其中$K_t$又称为`卡尔曼滤波系数`，上[@eq:最优估计偏差和残差的关系]我们习惯写成：

::: {custom-style="Figure"}
$$
\begin{equation}
    \hat{x}_t = \hat{x}_t^- + K_t \cdot (z_t-H \cdot \hat{x}_t^-)
\end{equation}
$${#eq:最优估计值计算公式}
:::

这样，最优估计值$\hat{x}_t$等于当前时刻的预测值$\hat{x}_t^-$，加上权重$K_t$乘以观测误差$z_t-H \cdot \hat{x}_t^-$。

#### 更新卡尔曼增益

&emsp;&emsp;那么这个权重$K_t$给多少呢？怎么给呢？是随便给吗？有什么依据吗？

&emsp;&emsp;答：当然是有依据的。依据当然是真实值和最优估计值之间的差值${e}_t$最小，即后验误差最小，后验误差见上[@eq:后验误差]。将上[@eq:最优估计值计算公式]最优估计值带入上[@eq:后验误差]中：

::: {custom-style="Figure"}
$$
\begin{equation}
\begin{aligned}
    {e}_t = x_{t} - [\hat{x}_t^- + K_t \cdot (z_t - H \cdot \hat{x}_t^-)]
\end{aligned}
\end{equation}
$${#eq:后验误差变换1}
:::

继续化简，将观测方程[@eq:观测方程]带入上[@eq:后验误差变换1]中：

::: {custom-style="Figure"}
$$
\begin{equation}
\begin{aligned}
    {e}_t &= x_{t} - [\hat{x}_t^- + K_t \cdot (H \cdot x_{t} + v_{t} - H \cdot \hat{x}_t^-)] \\
    &= (x_{t} - \hat{x}_t^-) - K_t \cdot H \cdot (x_{t} - \hat{x}_t^-) - K_t \cdot v_{t}
\end{aligned}
\end{equation}
$${#eq:后验误差变换2}
:::

继续化简，将上[@eq:先验误差]的先验误差${e}_{t}^{-}$带入上[@eq:后验误差变换2]中：

::: {custom-style="Figure"}
$$
\begin{equation}
\begin{aligned}
    {e}_t &= (x_{t} - \hat{x}_t^-) - K_t \cdot H \cdot (x_{t} - \hat{x}_t^-) - K_t \cdot v_{t} \\
    &= {e}_{t}^{-} - K_t \cdot H \cdot {e}_{t}^{-} - K_t \cdot v_{t} \\
    &= (I - K_t \cdot H) \cdot {e}_{t}^{-} - K_t \cdot v_{t}
\end{aligned}
\end{equation}
$${#eq:后验误差变换3}
:::

&emsp;&emsp;接下来求后验误差的协方差矩阵：

::: {custom-style="Figure"}
$$
\begin{equation}
\begin{aligned}
    Cov({e}_{t},{e}_{t}) &= Cov({e}_{t}) \\
    &= Cov[(I - K_t \cdot H) \cdot {e}_{t}^{-} - K_t \cdot v_{t}] \\
    &= (I - K_t \cdot H) \cdot Cov({e}_{t}^{-}) \cdot (I - K_t \cdot H)^T +  K_t \cdot Cov(v_{t}) \cdot K_t^T
\end{aligned}
\end{equation}
$${#eq:后验误差的协方差矩阵1}
:::

记`后验误差的协方差矩阵`$Cov({e}_{t}) = P_{t}$，则上[#eq:后验误差的协方差矩阵1]可以写作：

::: {custom-style="Figure"}
$$
\begin{equation}
\begin{aligned}
    P_{t} &= (I - K_t \cdot H) 
        \cdot P_{t}^{-} 
        \cdot (I - K_t \cdot H)^T 
        +  K_t \cdot R \cdot K_t^T \\
    &= (P_{t}^{-} - K_t \cdot H \cdot P_{t}^{-}) 
        \cdot (I - H^T \cdot K_t^T) 
        + K_t \cdot R \cdot K_t^T \\
    &= P_{t}^{-} 
        - K_t \cdot H \cdot P_{t}^{-}
        - P_{t}^{-} \cdot H^T \cdot K_t^T \\
        &+ K_t \cdot H \cdot P_{t}^{-} \cdot H^T \cdot K_t^T
        + K_t \cdot R \cdot K_t^T \\
    &= P_{t}^{-} 
        - K_t \cdot H \cdot P_{t}^{-}
        - (K_t \cdot H \cdot P_{t}^{-})^T
        + K_t \cdot (H \cdot P_{t}^{-} \cdot H^T + R) \cdot K_t^T
\end{aligned}
\end{equation}
$${#eq:后验误差的协方差矩阵2}
:::

其中之所以能化简，是由于误差的协方差矩阵$P_{t}$和$P_{t}^-$均是自相关矩阵，即以对角线为分界线，矩阵是对称的，这是协方差矩阵的性质。我们想要后验误差的协方差矩阵$P_{t}$最小，只要让该矩阵对角线上的和最小就行了，即矩阵$P_{t}$的迹最小。为什么呢？因为对角线上是每个误差本身的协方差，也就是方差，他们的和最小，协方差矩阵$P_{t}$就最小；矩阵的其他位置是两两误差的相关性，与整体误差无关，对整体误差大小没有影响。因此：

::: {custom-style="Figure"}
$$
\begin{equation}
\begin{aligned}
    T(P_{t}) = T(P_{t}^{-}) 
        - 2 \cdot T(K_t \cdot H \cdot P_{t}^{-})
        + T[K_t \cdot (H \cdot P_{t}^{-} \cdot H^T + R) \cdot K_t^T]
\end{aligned}
\end{equation}
$${#eq:后验误差的协方差矩阵的迹}
:::

其中$T()$代表矩阵的迹。把上[@eq:后验误差的协方差矩阵的迹]看作是关于$K_t$的函数：

::: {custom-style="Figure"}
$$
\begin{equation}
\begin{aligned}
    f(x) = a \cdot x^2 - 2 \cdot b \cdot x + c,
    \quad(a,b\text{是正的常数})
\end{aligned}
\end{equation}
$${#eq:关于卡尔曼滤波系数的函数}
:::

显然，这个函数是一个开口向上的一元二次函数，有极小值。它是一个凸函数，导数为0的点就是最小值。上[@eq:后验误差的协方差矩阵的迹]求导为：

::: {custom-style="Figure"}
$$
\begin{equation}
\begin{aligned}
    {\frac {dT(P_{t})} {dK_{t}}}
    &= -2 \cdot (H \cdot P_{t}^{-})^{T} 
        + K_{t} \cdot (H \cdot P_{t}^{-} \cdot H^{T} + R)
        + K_{t} \cdot (H \cdot P_{t}^{-} \cdot H^{T} + R) \\
    &= -2 \cdot (H \cdot P_{t}^{-})^{T} 
        + 2 \cdot K_{t} \cdot (H \cdot P_{t}^{-} \cdot H^{T} + R)
\end{aligned}
\end{equation}
$${#eq:后验误差的协方差矩阵的迹的转置}
:::

这里是对矩阵的迹的求导，求导公式从函数求导理解，想弄清楚，那么具体矩阵迹的求导需要单独学习。使得上式为零，则可计算出卡尔曼滤波系数$K_{t}$：

::: {custom-style="Figure"}
$$
\begin{equation}
    K_t = \frac {P_t^- \cdot H^T} {H \cdot P_t^- \cdot H^T + R}
\end{equation}
$${#eq:卡尔曼滤波系数}
:::

#### 更新后验误差的协方差

&emsp;&emsp;将计算得到的卡尔曼滤波系数$K_t$带入上[@eq:后验误差的协方差矩阵2]，计算得到后验误差协方差矩阵：

::: {custom-style="Figure"}
$$
\begin{equation}
\begin{aligned}
    P_{t} &= P_{t}^{-} - K_t \cdot H \cdot P_{t}^{-} \\
        &= (I - K_t \cdot H) \cdot P_{t}^{-} \\
\end{aligned}
\end{equation}
$${#eq:后验误差的协方差矩阵3}
:::

至此，卡尔曼滤波的五个重要的公式已经全部推导完成。分别是：[@eq:先验估计]、[@eq:先验误差的协方差矩阵2]、[@eq:卡尔曼滤波系数]、[@eq:最优估计值计算公式]、[@eq:后验误差的协方差矩阵3]。综上，我们把这五个重要的公式写在一起：

预测公式：

::: {custom-style="Figure"}
$$
\begin{equation}
\begin{aligned}
    \hat{x}_{t}^{-} &= F \cdot \hat{x}_{t-1} + B \cdot u_{t-1} \\
    P_{t}^{-} &= F \cdot P_{t-1} \cdot F^{T} + Q 
\end{aligned}
\end{equation}
$${#eq:预测}
:::

更新公式：

::: {custom-style="Figure"}
$$
\begin{equation}
\begin{aligned}
    K_t &= \frac {P_t^- \cdot H^T} {H \cdot P_t^- \cdot H^T + R} \\
    \hat{x}_t &= \hat{x}_t^- + K_t \cdot (z_t-H \cdot \hat{x}_t^-) \\
    P_{t} &= (I - K_t \cdot H) \cdot P_{t}^{-}
\end{aligned}
\end{equation}
$${#eq:更新}
:::
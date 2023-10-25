# 卡尔曼滤波

&emsp;&emsp;卡尔曼滤波参考教程：[【从放弃到精通！卡尔曼滤波从理论到实践~】](https://www.bilibili.com/video/BV1Rh41117MT/?p=3&share_source=copy_web&vd_source=6b55cb6788b1952e04c06b095d772810)。从该教程中提取公式并理解。

## 文件说明

1. [KalmanFiltering](./卡尔曼滤波Clang.pdf)：上文中提到的卡尔曼滤波视频教程的pdf文件。
2. []()：。

## P3 进阶（基本滤波知识储备）

### 状态空间表达式

&emsp;&emsp;`状态方程`：

::: {custom-style="Figure"}
$$
\begin{equation}
    x_{t} = F \cdot x_{t-1} + B \cdot u_{t-1} + W_{t}
\end{equation}
$${#eq:状态方程}
:::

解释：当前时刻的状态$x_{t}$等于上一时刻的状态$x_{t-1}$乘以系数$A$，加上输入值$u_{t}$乘以系数$B$，最后加上`过程噪声`$W_{t}$。

&emsp;&emsp;$A$又称为`状态转移矩阵`，因为$A$的大小决定了状态变化的快慢。$B$又称为`控制矩阵`，因为$B$的大小决定了输入对系统影响的程度。

&emsp;&emsp;如何理解`过程噪声`$W_{t}$？状态方程的含义是我们对系统的数学建模，构建了一个数学表达式，但是实际的系统往往是复杂的，在随时间变化的时候，会受到各种各样的因素的干扰，可以认为是一个总干扰，这种干扰是随机的，符合正太分布（高斯分布）。

&emsp;&emsp;`观测方程`：

::: {custom-style="Figure"}
$$
\begin{equation}
    y_{t} = C \cdot x_{t} + v_{t}
\end{equation}
$${#eq:观测方程}
:::

$y_{t}$是观测量，$x_{t}$是状态量，$C$是状态量的系数，$v_{t}$是`观测噪声`。

&emsp;&emsp;可以这样理解：测量值$y_{t}$和状态量$x_{t}$存在一种线性关系，但是测量总是有误差的，所以要加上观测噪声$v_{t}$，观测噪声同样符合正太分布。

&emsp;&emsp;我们可以用一个方框图表示这个系统，但是没有找到一个合适的绘制方框图的绘图软件。

### 参数分析

&emsp;&emsp;噪音服从均值为零的正态分布，可以记为：

::: {custom-style="Figure"}
$$
\begin{equation}
\begin{aligned}
    {{W_{t} \in N(0,Q_{t})}} \\ 
    {{V_{t} \in N(0,R_{t})}}
\end{aligned}
\end{equation}
$${#eq:噪音服从正态分布}
:::

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

&emsp;&emsp;通过卡尔曼滤波也不会得到真实值，而是每个时刻状态的`最优估计值`$\widehat{x}_{t}$,是修正值，也叫`后验估计值`。总结来说是，上一时刻的`最优估计值`$\widehat{x}_{t-1}$，根据物理理论再加上过程噪声（状态方程）得到的`先验估计值`$\hat{x}_k^{-}$,然后利用有噪音的观测值（观测方程）$y_{t}$,进行加权得到最优估计值$\widehat{x}_{t}$。这样从先验到后验，也就实现了`预测到更新`，而最优估计值的不断变化，也就是`迭代`。因为观测值也是有噪声的，通过得到最优估计值，也就是实现了`滤波`，去除了部分噪音。

## P4 放弃（通俗公式理解）

### 方程暂存

$$
\begin{aligned}\hat{x}_{t}^{-} & =F\hat{x}_{t-1}+Bu_{t-1}\\  & \\ P_{t}^{-} & =FP_{t-1}F^{T}+Q\end{aligned}
$$

$$
\begin{aligned}K_t&=P_t^-H^T\left(HP_t^-H^T+R\right)^{-1}\\\\\hat x_t&=\hat x_t^-+K_t(z_t-H\hat x_t^-)\\\\P_t&=(I-K_tH)P_t^-\end{aligned}
$$

$$
\begin{aligned}&p_t=p_{t-1}+v_{t-1}\cdot\Delta t+\frac a2\Delta t^2\\&v_t=v_{t-1}+a\cdot\Delta t\end{aligned}
$$

## 引子

&emsp;&emsp;考虑一个情景，一辆匀加速（加速度为$a$）直线运动的小车行驶在公路上，我们研究小车的状态有位置$p$和速度$v$，根据物理规律构建观测方程：

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

其中$i$表示当前时刻，$i-1$表示上一时刻。$p_r$是位置噪音，$v_r$是速度噪音，均服从正太分布。去掉噪音就是高中物理学习的标准的位置和速度公式。写成矩阵形式：

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
可以看到该[@eq:带噪音的匀加速直线运动2],满足状态方程[@eq:状态方程]。

### 预测

去除噪音项，就能求出先验估计值：

::: {custom-style="Figure"}
$$
\begin{equation}
    \hat{x}_{t}^{-} = F \cdot \hat{x}_{t-1} + B \cdot u_{t-1}
\end{equation} 
$${#eq:先验估计}
:::

符号$\hat{x}_{t}^{-}$和$\hat{x}_{t-1}$的含义在前文[卡尔曼滤波直观图解](#卡尔曼滤波直观图解)中已经提到，引入符号 $\hat{}$ 和$^{-}$是为了表示估计和先验。

&emsp;&emsp;接下来求先验估计的协方差：

$$
\begin{equation}
\begin{aligned}
    Cov(x_{t},x_{t}) &= Var(x_{t}) \\
    &= Var(F \cdot x_{t-1} + B \cdot u_{t-1} + W_{t}) \\
    &= F \cdot Var(x_{t-1}) \cdot F^{T} + Var(W_{t}) \\
\end{aligned}
\end{equation}
$$

记$Cov(x_t) = P_{t}$,则上式可以写作：

$$
\begin{equation}
    P_{t}^{-} = FP_{t-1}F^{T}+Q
\end{equation}
$$

其中符号$^{-}$是为了表示先验值。

### 更新
# 知识学习

## 正态分布

&emsp;&emsp;表达式如下：

::: {custom-style="Figure"}
$$
\begin{equation}
\begin{aligned}
    f(x) 
    = \frac {1} 
        {\sqrt{2 \cdot \pi} \cdot \sigma}
        \cdot e^{ 
            - \frac {(x - \mu)^2}
            {2 \cdot \sigma^2}
        }
\end{aligned}
\end{equation}
$${#eq:正态分布表达式1}
:::

服从正态分布记为：

$$
\begin{equation}
    X \sim N( \mu , \sigma^2)
\end{equation}
$$

## matlab

&emsp;&emsp;在matlab中，可以直接调用正态分布的函数`normpdf`。下面是代码：

```matlab
mu = 50; 
sigma = 5;
x = 0:.1:100;
y = normpdf(x,mu,sigma);
plot(x,y)
grid on # 网格
```

做一个[实时脚本](./NormalDistribution.mlx)，添加$\mu$、$\sigma$的取值滑块，观察参数对正态分布函数的影响。

## 额外的

&emsp;&emsp;考虑一个这样的情况，变量$Y$的大小是变量$X$的三倍：

::: {custom-style="Figure"}
$$
\begin{equation}
    y = 3 \cdot x
\end{equation}
$${#eq:变量线性关系}
:::

这是什么表达式呢？均值和方差如何变化呢？由于$X$服从正态分布，换成变量$Y$后：

::: {custom-style="Figure"}
$$
\begin{equation}
\begin{aligned}
    g(y) = f(\frac {1} {3} \cdot y) 
    &= \frac {1} 
        {\sqrt{2 \cdot \pi} \cdot \sigma}
        \cdot e^{ 
            - \frac {(\frac {1} {3} \cdot y - \mu)^2}
            {2 \cdot \sigma^2}
        } \\
    &= \frac {1} 
        {\sqrt{2 \cdot \pi} \cdot \sigma}
        \cdot e^{ 
            - \frac {(y - 3 \cdot \mu)^2}
            {2 \cdot (3 \cdot \sigma)^2}
        } \\
    &= 3 \cdot \frac {1} 
        {\sqrt{2 \cdot \pi} \cdot (3 \cdot\sigma)}
        \cdot e^{ 
            - \frac {(y - 3 \cdot \mu)^2}
            {2 \cdot (3 \cdot \sigma)^2}
        }
\end{aligned}
\end{equation}
$${#eq:正态分布表达式2}
:::

::: {custom-style="Figure"}
$$
\begin{equation}
\begin{aligned}
    g(y) =  \frac {1} {3} \cdot f(\frac {1} {3} \cdot y) &= \frac {1} 
        {\sqrt{2 \cdot \pi} \cdot (3 \cdot\sigma)}
        \cdot e^{ 
            - \frac {(y - 3 \cdot \mu)^2}
            {2 \cdot (3 \cdot \sigma)^2}
        }
\end{aligned}
\end{equation}
$${#eq:正态分布表达式3}
:::

$Y$服从均值为 $3 \cdot \mu$，方差为 $9 \cdot \sigma^2$ 的正态分布，记为：

$$
\begin{equation}
    Y \sim N(3 \cdot \mu , (3 \cdot \sigma)^2)
\end{equation}
$$

函数`randn`是函数`normrnd`的简化版，生成服从均值为0，方差为1的正态分布的随机数，matlab代码如下：

```matlab
clear;
T = (1 : 100).'; % 离散的时间序列，单位是s
X = randn(100, 1);
Y = 3 * X;
figure(1);
plot(T, X(:, 1), 'r');
hold on
plot(T, Y(:, 1), 'g');
title('正态分布的伪随机数');
xlabel('时间'); ylabel('大小');
```
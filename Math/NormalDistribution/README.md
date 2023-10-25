# 知识学习

## 正态分布

&emsp;&emsp;表达式如下：

$$
f \left(x\right) = \frac {1} {\sqrt{2\pi} \sigma} e^{ - \frac { \left( x - \mu \right)^2 } { 2 \sigma^2 } }
$$

服从正态分布记为：

$$
X \sim N\left( \mu , \sigma^{2} \right)
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
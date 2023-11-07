# 方差

&emsp;&emsp;表达式如下：

$$
D \left( X \right)
    =\frac 
        { \left( x_1 - \overline{x} \right)^2 + \left( x_2 - \overline{x} \right)^2 + \cdots + \left( x_n - \overline{x} \right)^2 }
        {n}
    =\frac
        {\sum_{i=1}^n \left( x_i - \overline{x} \right)^2}
        {n}
$$

## matlab

&emsp;&emsp;在matlab中，可以直接调用函数`normrnd`生成服从正态分布的随机数。下面是代码：

```matlab
mu = 50;
sigma = 5;
x=normrnd(mu,sigma,100000,1);
figure
histogram(x,50);% 直方图50族
i = 1:1:size(x);
scatter(i,x,.3,"filled")% 散点图
```

做一个[实时脚本](./variance.mlx)，添加方差$\sigma$的取值滑块，观察方差对数据离散程度的影响。

# 方差的性质

&emsp;&emsp;如果变量乘以矩阵的话，矩阵可以放在方差的外面：

$$
Var(A \cdot X) = A \cdot Var(X,Y) \cdot A^T
$$
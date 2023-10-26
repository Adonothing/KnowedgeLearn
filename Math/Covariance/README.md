# 协方差

&emsp;&emsp;释义教程看这个：[【协方差和相关系数｜说人话的统计学】](https://www.bilibili.com/video/BV1gX4y117aM/?share_source=copy_web&vd_source=6b55cb6788b1952e04c06b095d772810)。协方差和方差所表达的物理特性是不同的。协方差的大小并不能表示变量的离散程度，而表示的是两个变量的相关程度，协方差为正是正相关，协方差为负是负相关，协方差为零是无关。协方差为正表示整体上，变量2随着变量1的增大而增大，减小而减小，呈正相关；协方差为负表示整体上，变量2随着变量1的增大而减小，减小而增大，呈负相关；协方差为零表示，变量2随着变量1变化是没有规律的，有的增，有的减小，有的不变，综合下来协方差为零，即无关。表达式如下：

$$
\begin{aligned}
    Cov \left( X,Y \right)
    &= \frac
        {\sum_{i=1}^n \left( x_i - \overline{x} \right)\left( y_i - \overline{y} \right)}
        {n} \\
    &= E \left[ \left( X - E \left[ X \right] \right) \left( Y - E \left[ Y \right] \right) \right] \\
    &= E \left[ XY \right] - 2E \left[ Y \right] E \left[ X \right] + E \left[ X \right] E \left[ Y \right] \\
    &= E \left[ XY \right] - E \left[ X \right] E \left[ Y \right]
\end{aligned}
$$

&emsp;&emsp;但是这并不准确。考虑一种情况，有两组，每组都有两个变量，组内的两个变量都是强相关，但是由于其中一组波动很小，所以协方差比另外一组小得多，这样就不是很科学。如果我们在协方差公式中引入标准差，将其标准化，就可以得到新的东西，叫`相关系数`：

$$
\begin{aligned}
    \rho_{XY}
    &= \frac{\sum_{i=1}^n \left[
            \frac{\left( x_i - \overline{x} \right)}
            {\overline{x}} \cdot
            \frac{\left(y_i - \overline{y} \right)}
            {\overline{y}} \right]
        }
        {n} \\
    &= \frac{Cov \left( X,Y \right)}
        {\overline{x} \cdot \overline{y}} \\
\end{aligned}
$$

标准化以后，相关系数的取值范围为$[-1,1]$。当$\rho=-1$时，两个变量完全负相关；当$\rho=0$时，两个变量完全不相关；当$\rho=1$时，两个变量完全正相关，此时两个变量可以看作同一个变量，协方差完全变为方差。

# 协方差矩阵

&emsp;&emsp;协方差矩阵的每个元素是各个向量元素之间的协方差。设$X = ( X_{1}, X_{2}, \ldots, X_{n})^{T}$为$n$维随机变量，称矩阵

$$
C =(c_{ij})_{n \times n}
    =\begin{pmatrix}
        c_{11} & c_{12} & \ldots & c_{1n} \\
        c_{21} & c_{22} & \ldots & c_{2n} \\
        \cdot & \cdot & & \cdot \\
        \cdot & \cdot & & \cdot \\
        \cdot & \cdot & & \cdot \\
        \cdot & \cdot & & \cdot \\
        c_{n1} & c_{n2} & \ldots & c_{nn}
    \end{pmatrix}
$$

为$n$维随机变量$X$的协方差矩阵（covariance matrix），也记为$D(x)$，其中

$$
c_{ij} = Cov(X_i,X_j),i,j=1,2,\ldots,n
$$

为$X$的分量$X_{i}$和$X_{j}$的协方差（设它们都存在）。

&emsp;&emsp;显然协方差矩阵是一个对角阵，因为：

$$
c_{ij} = c_{ji}
$$

同时，在对角线上，自己的协方差就是方差：

$$
c_{ii} = Var(X_i),i=1,2,\ldots,n
$$

我们在表示协方差矩阵的时候，还可以这样写：

$$
C =(c_{ij})_{n \times n} = Cov ( X,X ) = Cov ( X )
$$

这里的$X$一定要和[协方差](#协方差)里的$X$区分出来。这里的$X$是多个元素的矩阵，而[协方差](#协方差)里的$X$是单个元素的矩阵。当$X$是多个元素组成的矩阵，求$Cov$不再是求协方差，而是求协方差矩阵。

# matlab

&emsp;&emsp;在matlab中，创建实时脚本，分四节，求协方差矩阵并绘制散点图。

正相关：

```matlab
A = [1 2 3 4];
B = [3 5 9 15];
cov(A,B)
scatter(A,B,10,"filled")% 散点图
```

负相关：

```matlab
A = [1 2 3 4];
B = [-3 -5 -9 -15];
cov(A,B)
scatter(A,B,10,"filled")% 散点图
```

无关：

```matlab
A = [1 2 3 4];
B = [3 -15 9 -5];
cov(A,B)
scatter(A,B,10,"filled")% 散点图
```

注意：这并不是无关：

```matlab
A = [1 2 3 4];
B = [3 -5 9 -15];
cov(A,B)
scatter(A,B,10,"filled")% 散点图
```

做一个[实时脚本](./Covariance.mlx)，观察四组方差和散点图。

# 协方差的性质

1. 变量自己的协方差为方差：

$$
Cov(X,X) = Var(X);
$$
   
2. 变量谁在前，谁在后，无所谓：

$$
Cov(X,Y) = \mathrm{Cov}(Y,X);
$$

3. 变量的系数可以直接提到外面来，和前面求相关系数的道理一样：

$$
\mathrm{Cov}(a \cdot X,b \cdot Y) = a \cdot b \cdot \mathrm{Cov}(X,Y),\quad(a,b\text{是常数});
$$

4. 变量和的协方差等于协方差的和

$$
\mathrm{Cov}(X_{1}+X_{2},\quad Y) = \mathrm{Cov}(X_{1},\quad Y) + \mathrm{Cov}(X_{2},\quad Y);
$$

5. 变量增加一个常系数，对协方差没有影响：

$$
Cov(X+a,Y+b)=Cov(X,Y)
$$

6. 系数矩阵$A$、$B$能直接提到$Cov$外面来：

$$
\begin{aligned}
    Cov (A \cdot X,B \cdot Y ) = A \cdot Cov (X,Y) \cdot B^{T}
\end{aligned}
$$
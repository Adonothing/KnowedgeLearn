# 矩阵的转置

## 定义

&emsp;&emsp;我们把$m$行$n$列矩阵$A$的行换成同序数的列得到一个$n$行$m$列矩阵，此矩阵叫做$A$的转置矩阵，记做$A^T$或$A'$ 。

## 基本性质

1. 矩阵转置的转置就是其本身：

::: {custom-style="Figure"}
$$
\begin{equation}
    (A^T)^T = A 
\end{equation}
$${#eq:先验估计的协方差2}
:::

2. 和的转置等于转置的和

::: {custom-style="Figure"}
$$
\begin{equation}
    (A + B)^T = A^T + B^T
\end{equation}
$${#eq:先验估计的协方差2}
:::

3. 常数和矩阵积的转置等于常数和矩阵转置的积

::: {custom-style="Figure"}
$$
\begin{equation}
    (a \cdot A)^T = a \cdot A^T
\end{equation}
$${#eq:先验估计的协方差2}
:::

4. 矩阵积的转置等于矩阵转置的积，但是矩阵得调换位置

::: {custom-style="Figure"}
$$
\begin{equation}
    (A \cdot B)^T = B^T \cdot A^T
\end{equation}
$${#eq:先验估计的协方差2}
:::
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

# 一阶微分方程

## 一阶微分方程的解

&emsp;&emsp;很多生活实际上、工程上的问题数学表达式就是一阶微分方程。一阶微分方程是可以直接求解的。连续性状态方程就是一阶微分方程，一阶微分方程的求解是状态方程离散化的一个重要步骤。所以单开一阶微分方程来讨论。一阶微分方程的表达式为：

::: {custom-style="Figure"}
$$
\begin{equation} \begin{aligned}
    \dot{x}(t) = A \cdot x(t) + B \cdot u_t \\
    \frac{dx_t}{dt}= A \cdot x_t + B \cdot u_t
\end{aligned} \end{equation}
$$ {#eq:一阶微分方程1}
:::

上式我们用第二行的微分形式，因为设法求解，就要把 $x$ 和 $t$ 分离到等式左右两边。但是我们看到 $dt$ 无法直接移到右边来，因为 $x$ 和 $t$ 并没有分离，这是因为还有一项控制量 $B \cdot u_t $ 导致无法分离。所以我们将 $x_t$ 分解：

::: {custom-style="Figure"}
$$
\begin{equation}
    x_t = a_t \cdot b_t
\end{equation}
$$ {#eq:变量分解}
:::

将变量分解[@eq:变量分解]带入一阶微分方程1[@eq:一阶微分方程1]中：

::: {custom-style="Figure"}
$$
\begin{equation} \begin{aligned}
    a_t \cdot \frac{db_t}{dt} + \frac{da_t}{dt} \cdot b_t = A \cdot a_t \cdot b_t + B \cdot u_t \\
    a_t \cdot \frac{db_t}{dt} + \frac{da_t}{dt} \cdot b_t - A \cdot a_t \cdot b_t = B \cdot u_t \\
    a_t \cdot \left( \frac{db_t}{dt} - A \cdot b_t \right) + \frac{da_t}{dt} \cdot b_t = B \cdot u_t \\
    a_t \cdot \frac{db_t}{dt} + \left( \frac{da_t}{dt} - A \cdot a_t \right) \cdot b_t = B \cdot u_t \\
\end{aligned} \end{equation}
$$ {#eq:一阶微分方程2}
:::

由于变量分解[@eq:变量分解]中的 $a_t$ 和 $b_t$ 可以交换位置，所以一阶微分方程2[@eq:一阶微分方程2]的第三行和第四行无所谓，是一样的。我们就用第三行，既然用了变量分解，$a_t$ 和 $b_t$ 就可以任取，满足等式就行，我们不妨设：

::: {custom-style="Figure"}
$$
\begin{equation} \begin{aligned}
    \frac{db_t}{dt} - A \cdot b_t = 0
\end{aligned} \end{equation}
$$ {#eq:变量2求解}
:::

这就可以直接求解 $b_t$：

::: {custom-style="Figure"}
$$
\begin{equation} \begin{aligned}
    \frac{db_t}{b_t} = A \cdot dt \\
    \int_{b_0}^{b_t}\left(\frac{1}{b_t}\right)db_t = \int_{0}^{t}\left(A \right)dt \\
    \ln(b_t) - \ln(b_0) = A \cdot t \\
    \ln{\left(\frac{b_t}{b_0}\right)} = A \cdot t \\
    b_0 \cdot e^{A \cdot t} = b_t \\
    b_t = C_2 \cdot e^{A \cdot t} \\
\end{aligned} \end{equation}
$$ {#eq:子变量2通解1}
:::

一般的，当 $A$ 为非常系数时：

::: {custom-style="Figure"}
$$
\begin{equation} \begin{aligned}
    b_t = C_2 \cdot e^{ \int_{0}^{t}\left(A(t) \right)dt} \\
\end{aligned} \end{equation}
$$ {#eq:子变量2通解2}
:::

其中：

::: {custom-style="Figure"}
$$
\begin{equation} \begin{aligned}
    C_2 = b_0
\end{aligned} \end{equation}
$$ {#eq:常量2定义}
:::

将 $b_t$ 子变量2通解1[@eq:子变量2通解1]带入一阶微分方程2[@eq:一阶微分方程2]可以解出 $a_t$：

::: {custom-style="Figure"}
$$
\begin{equation} \begin{aligned}
    \frac{da_t}{dt} \cdot b_t &= B \cdot u_t \\
    \frac{da_t}{dt} &= B \cdot u_t \cdot \frac{1}{b_t} \\
    a_t - a_0 &= \int_{0}^{t} (B \cdot u_t \cdot \frac{1}{b_t}) dt \\
    a_t &= \frac{1}{C_2} \cdot 
      \int_{0}^{t} \left(
        B \cdot u_t
        \cdot e^{- A \cdot t}
      \right) dt + C_1
\end{aligned} \end{equation}
$${#eq:子变量1通解1}
:::

同理：

::: {custom-style="Figure"}
$$
\begin{equation} \begin{aligned}
    C_1 = a_0
\end{aligned} \end{equation}
$$ {#eq:常量1定义}
:::

将两个子变量通解[@eq:子变量2通解2]和[@eq:子变量1通解1]带入一阶微分方程表达式[@eq:一阶微分方程1]中得到一阶微分方程的通解：

::: {custom-style="Figure"}
$$
\begin{equation} \begin{aligned}
    x(t) = e^{A \cdot t} 
      \cdot (\int_{0}^{t} \left(
          B \cdot u_t
          \cdot e^{- A \cdot t}
        \right) dt + C )
\end{aligned} \end{equation}
$$ {#eq:一阶微分方程的通解1}
:::

其中：

::: {custom-style="Figure"}
$$
\begin{equation} \begin{aligned}
    C = C_1 \cdot C_2 = x_0
\end{aligned} \end{equation}
$$ {#eq:常量1定义}
:::
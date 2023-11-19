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
\begin{equation}
    Q,R \sim PID
\end{equation}
$$ {#eq:一阶微分方程}
:::
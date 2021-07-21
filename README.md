# Stata 新命令：fn——返回特定文件格式的文件名与所在路径

> 作者：王美庭  
> Email: wangmeiting92@gmail.com

## 一、引言

我们知道，`dir`也可以返回特定文件格式的文件名，那为何我还要写`fn`（filenames）命令呢？原因有两点：

- `dir`没有返回值：我们可能在后续需要用到前面所展示的文件名，但由于没有返回值而使得我们无法实现这个想法。
- 我们还可能需要更多的信息，如文件所在的路径、所匹配到的文件的数量。

新写的命令会直接在 Stata 界面上展示文件所在的路径以及匹配到的所有文件名。除此之外，我们还在返回值中存放了以下内容：（1）文件所在的路径；（2）匹配到的所有文件名；（3）匹配文件时所设定的格式；（4）匹配到的文件的数量。

因此，该命令不仅方便用户直接在 Stata 界面上查看匹配信息，而且其返回值的多样性也方便用户将匹配过程中的信息用到后续的命令中。

## 二、命令的安装

`fn`及本人其他命令的代码都托管于 GitHub 上，读者可随时下载安装这些命令。

你可以通过系统自带的`net`命令进行安装：

```stata
net install fn, from("https://raw.githubusercontent.com/Meiting-Wang/fn/main")
```

也可以通过`github`外部命令进行安装（`github`命令本身可以通过`net install github, from("https://haghish.github.io/github/")`进行安装）：

```stata
github install Meiting-Wang/fn
```

## 三、语法与选项

**命令语法**：

```stata
fn varlist [if] [in] [weight] [using filename] [, options]
```

> - `varlist`: 可输入一个或多个数值型变量
> - `weight`: 可以选择 aweight 或 fweight，默认为空。
> - `using`: 可以将结果输出至 Word（ .rtf 文件）和 LaTeX（ .tex 文件）

**选项（options）**：

- 一般选项
  - `by(varname)`: 可输入一个类别变量
  - `statistics(string)`：设定要报告的统计量，所以可以输入的统计量有：`count mean sd min max range variance sum p1 p5 p10 p25 p50 p75 p90 p95 p99 iqr cv semean skewness kurtosis`。当然，我们还可以设置统计量的数值格式和标签，如`mean(fmt(%9.3f) label(mean_label))`。
  - `listwise`：在计算统计量之前会先剔除所涉及变量中包含缺漏值的观测值
  - `nototal`：不报告总计部分
  - `title(string)`：设置表格标题
  - `replace`: 替换已存在的文件
  - `append`: 将输出内容附加在已存在的文件中
  - `eqlabels(strings)`: 自定义行方程名
  - `varlabels(matchlist)`: 自定义行变量名
  - `collabels(strings)`: 自定义列名
  - `varwidth(number)`: 自定义表格第一列的宽度
  - `modelwidth(numlist)`: 自定义表格第二列及之后列的宽度
  - `compress`: 压缩表格的行空白空间，以使表格更紧凑
- LaTeX 专有选项
  - `alignment(string)`：设置 LaTeX 表格的列对齐格式，可输入`math`或`dot`，`math`设置列格式为居中对齐的数学格式（自动添加宏包`booktabs`和`array`），`dot`表示小数点对齐的数学格式（自动添加宏包`booktabs`、`array`和`dcolumn`）。默认为`math`
  - `page(string)`：可添加用户额外需要的宏包
  - `width(string)`：设置 LaTeX 中表格的宽度，如`width(\textwidth)`表示设置表格宽度为版心宽度

> - 以上其中的一些选项可以缩写，详情可以在安装完命令后`help fn`

## 四、实例

```stata
sysuse auto.dta, clear
*--共同部分
fn price weight mpg rep78 //默认报告count mean sd min max
fn price weight mpg rep78, listwise //在计算统计量时会先提出所涉及变量包含缺漏值的观测值
fn price weight mpg rep78, s(count mean min max) //设定特定的统计量
fn price weight mpg rep78, s(count(label(n)) mean(fmt(2)) min(fmt(2)) max(fmt(2))) //为统计量设置标签以及数值格式

fn price weight mpg rep78, by(foreign) //分组报告描述性统计
fn price weight mpg rep78, by(foreign) nototal //不报告Total部分
fn price weight mpg rep78, by(foreign) eql(domestic foreign Total) //设置行方程名
fn price weight mpg rep78, by(foreign) varl(price price_plus mpg mpg_plus) //为变量设置标签
fn price weight mpg rep78, by(foreign) coll(col1 col2 col3 col4 col5) //为表格自定义列名
fn price weight mpg rep78, by(foreign) compress //压缩表格横向空格以使得表格更紧凑
fn price weight mpg rep78, by(foreign) compress varw(20) //自定义表格第一列的宽度
fn price weight mpg rep78, by(foreign) compress modelw(12) //自定义表格第二列及之后列的宽度
fn price weight mpg rep78, by(foreign) ti(This is a title) //设置表格标题

*--Word部分
fn price weight mpg rep78 using Myfile.rtf, replace by(foreign) //将结果导出至Word

*--LaTeX部分
fn price weight mpg rep78 using Myfile.tex, replace by(foreign) ti(This is a title) //将结果导出至LaTeX
fn price weight mpg rep78 using Myfile.tex, replace by(foreign) ti(This is a title) a(dot) //设置LaTeX表格列为小数点对齐(默认为数学模式居中对齐)
fn price weight mpg rep78 using Myfile.tex, replace by(foreign) ti(This is a title) page(amsmath) //为LaTeX添加额外的宏包
fn price weight mpg rep78 using Myfile.tex, replace by(foreign) ti(This is a title) width(\textwidth) //将LaTeX的表格宽度设为版心宽度


*-该命令结果可以用系统自带的tabstat命令进行验证
tabstat price weight mpg rep78, c(s) s(count mean sd min max)
tabstat price weight mpg rep78, by(foreign) c(s) s(count mean sd min max) long
```

> 以上所有与`fn`相关的实例都可以在`help fn`中直接运行。  
> ![](https://img-blog.csdnimg.cn/20200818102100924.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dhbmdtZWl0aW5nYWE=,size_16,color_FFFFFF,t_70#pic_center)

## 五、输出效果展示

- **Stata**

```stata
fn price weight mpg rep78, compress
```

```stata
------------------------------------------------------------
               count      mean        sd       min       max
------------------------------------------------------------
price             74  6165.257  2949.496      3291     15906
weight            74  3019.459  777.1936      1760      4840
mpg               74   21.2973  5.785503        12        41
rep78             69  3.405797  .9899323         1         5
------------------------------------------------------------
```

```stata
fn price weight mpg rep78, compress s(count(label(n)) mean(fmt(2)) min(fmt(2)) max(fmt(2)))
```

```stata
--------------------------------------------------
                   n      mean       min       max
--------------------------------------------------
price             74   6165.26   3291.00  15906.00
weight            74   3019.46   1760.00   4840.00
mpg               74     21.30     12.00     41.00
rep78             69      3.41      1.00      5.00
--------------------------------------------------
```

```stata
fn price weight mpg rep78, compress by(foreign) s(count(label(n)) mean(fmt(2)) min(fmt(2)) max(fmt(2)))
```

```stata
--------------------------------------------------
                   n      mean       min       max
--------------------------------------------------
0                                                 
price             52   6072.42   3291.00  15906.00
weight            52   3317.12   1800.00   4840.00
mpg               52     19.83     12.00     34.00
rep78             48      3.02      1.00      5.00
--------------------------------------------------
1                                                 
price             22   6384.68   3748.00  12990.00
weight            22   2315.91   1760.00   3420.00
mpg               22     24.77     14.00     41.00
rep78             21      4.29      3.00      5.00
--------------------------------------------------
Total                                             
price             74   6165.26   3291.00  15906.00
weight            74   3019.46   1760.00   4840.00
mpg               74     21.30     12.00     41.00
rep78             69      3.41      1.00      5.00
--------------------------------------------------
```

- **Word**

```stata
fn price weight mpg rep78 using Myfile.rtf, replace compress by(foreign) ti(This is a title)
```

![fn-Word](https://img-blog.csdnimg.cn/20200818102614125.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dhbmdtZWl0aW5nYWE=,size_16,color_FFFFFF,t_70#pic_center)

- **LaTeX**

```stata
fn price weight mpg rep78 using Myfile.tex, replace by(foreign) compress ti(This is a title) a(math)
```

```tex
% 18 Aug 2020 10:27:33
\documentclass{article}
\usepackage{array}
\usepackage{booktabs}
\begin{document}

\begin{table}[htbp]\centering
\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}
\caption{This is a title}
\begin{tabular}{l*{1}{*{5}{>{$}c<{$}}}}
\toprule
          &\multicolumn{1}{c}{count}&\multicolumn{1}{c}{mean}&\multicolumn{1}{c}{sd}&\multicolumn{1}{c}{min}&\multicolumn{1}{c}{max}\\
\midrule
0         &         &         &         &         &         \\
price     &       52& 6072.423& 3097.104&     3291&    15906\\
weight    &       52& 3317.115& 695.3637&     1800&     4840\\
mpg       &       52& 19.82692& 4.743297&       12&       34\\
rep78     &       48& 3.020833&  .837666&        1&        5\\
\midrule
1         &         &         &         &         &         \\
price     &       22& 6384.682& 2621.915&     3748&    12990\\
weight    &       22& 2315.909& 433.0035&     1760&     3420\\
mpg       &       22& 24.77273& 6.611187&       14&       41\\
rep78     &       21& 4.285714& .7171372&        3&        5\\
\midrule
Total     &         &         &         &         &         \\
price     &       74& 6165.257& 2949.496&     3291&    15906\\
weight    &       74& 3019.459& 777.1936&     1760&     4840\\
mpg       &       74&  21.2973& 5.785503&       12&       41\\
rep78     &       69& 3.405797& .9899323&        1&        5\\
\bottomrule
\end{tabular}
\end{table}

\end{document}
```

![fn-LaTeX](https://img-blog.csdnimg.cn/2020081810294579.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dhbmdtZWl0aW5nYWE=,size_16,color_FFFFFF,t_70#pic_center)

> 在将结果输出至 Word 或 LaTeX 时，Stata 界面上也会呈现对应的结果，以方便查看。

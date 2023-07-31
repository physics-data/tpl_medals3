# medals3

## 问题描述

喵喵对你之前帮他统计的奖牌榜很满意，但是相比于现代的高级语言，SQL 真是不好写。所以，今天你需要用 dbplyr 再次完成这一任务。

## 题目要求

使用 dbplyr 库编写 R 程序，从标准输入读入 `begin` 和 `end` 两个年份（含义与 `medals` 作业中相同）。统计 `begin` 到 `end` 年份中，获得金牌数量前二十的国家和每一届有比赛的年份获得的金牌数量（如果总金牌数相同，则按照国家代码的**字典序升序**排列；国家内部按照年份升序排列），并以 CSV 格式输出到文件。该 CSV 有四列，第一列名称为 `country` 代表国家，第二列名称为 `year` 代表获得金牌的年份，第三列名称为 `count` 代表当年金牌数，第四列名称为 `total_count` 代表金牌总数。只需要输出最多的前二十个国家，不足二十个有金牌的国家则输出所有国家和对应的金牌数即可。不要输出多余的空格，具体的格式见 `data` 目录下的数据。

你应当使用 dbplyr 以及 dplyr 提供的函数来完成作业。题面中已经给出数据库的连接。
特别地，本题中**不得出现以下内容**，否则记为零分：

* `if`, `for`, `while` 等控制流或控制流函数
* 显式调用 `data.frame` 系列函数
* `collect` 等即时求值函数
* R 内置以及第三方包提供的数据操作函数，例如 `paste`, `laply`
* SQL 查询语句

为了完成题目，你需要在 [dplyr 文档](https://dplyr.tidyverse.org/index.html) 中寻找合适的操作函数，并仔细理解不同参数的作用。以下是助教认为可能有用的一些函数：

* `filter`：筛选数据
* `inner_join`：合并两个表格
* `group_by`, `count`, `mutate`, `summarise`：按分组操作数据
* `arrange`, `slice_max`：排序数据

命令行参数格式为 `./medals3.R db_path csv_file`，数据库文件路径为 `db_path`，输出 CSV 文件的路径为 `csv_file`。

## 多余的话
dplyr 在不同版本的表现也有一定的差异，主要体现在 `group_by` 和 `summarise` 的配合上。因此，如果你遇到下列错误
```
Column name `foo` must not be duplicated.
```
这可能是因为你的 group key 和 summarise 出来的 key 重名了，例如
``` R
table %>% group(foo) %>% summarise(foo, n = n())
```
如果遇到这样的情况，不要在 summarise 里面写出 group key，而是在 summarise 之后 ungroup：
``` R
table %>% group(foo) %>% summarise(n = n()) %>% ungroup()
```

## 样例和评分

我们在 `data` 目录下提供了八组数据。和之前的题目一样，你可以通过 `python3 grade.py` 来进行一次的本地测评。

数据范围：`begin` <= `end` ，保证结果不空。

每个数据点都有 1.5s 的时间限制，如果超过了这个时间，评测程序会提示你超时。最终评分以在助教机器上运行的时间为准。

最终分数构成为：

* 黑盒 80 分：共 8 个测例，每个 10 分。
* 白盒 20 分：参照[白盒标准](https://physics-data.meow.plus/faq/whitebox/)，并务必据实填写 honor code。

助教以 deadline 前 <https://git.tsinghua.edu.cn/> 上最后一次提交为准进行评测。

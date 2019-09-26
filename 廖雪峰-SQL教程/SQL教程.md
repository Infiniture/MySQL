## SQL教程

[TOC]

- 关系数据库概述：

  > 什么是SQL? 简单地说，SQL就是访问和处理关系数据库的计算机标准语言。

  - 数据模型

    > 数据库按照数据数据结构来组织、存储和管理数据，实际上，数据库一共有三种模型：

    - 层次模型：以“上下级”的层次关系来组织数据的一种方式，层次模型的数据结构看起来就像一棵树。
    - 网状模型：把每个数据节点和其它很多节点都连接起来，它的数据结构看起来就像很多城市之间的路网。
    - 关系模型：把数据看作是一个二维表格，任何数据都可以通过行号 + 列号来唯一确定，它的数据模型看起来就是一个Excel表。

    > 随着时间的推移和市场竞争，最终，基于关系模型的关系数据库获得了绝对市场份额。

  - 数据类型

    > 对一个关系表，除了定义每一列的名称外，还需要定义每一列的数据类型。关系数据库支持的标准数据类型包括数值、字符串、时间等：

    |     名称     |      类型      |                             说明                             |
    | :----------: | :------------: | :----------------------------------------------------------: |
    |     INT      |      整型      |                 4字节整数类型，范围约+/-21亿                 |
    |    BIGINT    |     长整型     |               8字节整数类型，范围约+/-922亿亿                |
    |     REAL     |     浮点型     |                 4字节浮点数，范围约+/-10^38^                 |
    |    DOUBLE    |     浮点型     |                8字节浮点数，范围约+/-10^308^                 |
    | DECIMAL(M,N) |   高精度小数   | 由用户指定精度的小数，例如，DECIMAL(20,10)表示一共20位，其中小数10位，通常用于财务计算 |
    |   CHAR(N)    |   定长字符串   | 存储指定长度的字符串，例如，CHAR(100)总是存储100字符的字符串 |
    |  VARCHAR(N)  |   变长字符串   |                     存储可变长度的字符串                     |
    |   BOOLEAN    |    布尔类型    |                      存储True或者False                       |
    |     DATE     |    日期类型    |                  存储日期，例如，2018-06-22                  |
    |     TIME     |    时间类型    |                   存储时间，例如，12:20:59                   |
    |   DATETIME   | 日期和时间类型 |           存储日期+时间，例如，2018-06-22 12:20:59           |

    > 上面的表中列举了最常用的数据类型。很多数据类型还有别名，例如，`REAL`又可以写成`FLOAT(24)`。还有一些不常用的数据类型，例如，`TINYINT`(范围在0~255)。各数据库厂商还会支持特定的数据类型，例如`JSON`。

    > 通常来说，`BIGINT`能满足整数存储的需求，`VARCHAR(N)`能满足字符串存储的需求，这两种类型是使用最广泛的。

- SQL（Structed Query Language）

  > 什么是SQL？SQL是结构化查询语言的缩写，用来访问和操作数据库系统。SQL语句既可以查询数据库中的数据，也可以添加、更新和删除数据库中的数据，还可以对数据库进行管理和维护操作。

  - SQL语言定义了这么几种操作数据库的能力：

    - DDL: Data Definition Language

      DDL允许用户定义数据，也就是创建表、删除表、修改表结构这些操作。通常，DDL由数据库管理员执行。

    - DML: Data Manipulation Language

      DML为用户提供添加、删除、更新数据的能力，这些是应用程序对数据库的日常操作。

    - DQL: Data Query Language

      DQL允许用户查询数据，这也是通常最频繁的数据库日常操作。

- NoSQL

  > NoSQL也就是非SQL的数据库，包括MongoDB、Cassandra、Dynamo等等，它们都不是关系数据库。

  > 回顾一下NoSQL的发展历程：

  - 1970: NoSQL = We have no SQL
  - 1980: NoSQL = Know SQL
  - 2000: NoSQL = No SQL!
  - 2005: NoSQL = Not only SQL
  - 2013: NoSQL = No, SQL!

- 安装MySQL

  > MySQL本身实际上只是一个SQL接口，它的内部还包含了多种数据引擎，常用的包括：
  >
  > - InnoDB：由Innobase Oy公司开发的一款支持事务的数据库引擎，2006年被Oracle收购；
  > - MyISAM：MySQL早期继承的默认数据库引擎，不支持事务。

  > 使用MySQL时，不同的表还可以使用不同的数据库引擎。如果你不知道应该采用哪种引擎，记住总是选择**InnoDB**就好了。

- 运行MySQL

  > 在命令提示符下输入`mysql -u root -p`，然后输入口令，如果一切正常，就会连接到MySQL服务器，同时提示符变为`mysql>`，输入`exit`退出MySQL命令行。注意，MySQL服务器仍在后台运行。



## 关系模型

> 关系数据库是建立在关系模型上的，而关系模型本质上就是若干个存储数据库的二维表。
>
> 表的每一行称为记录（Record），记录是一个逻辑意义上的数据。
>
> 表的每一列称为字段（Column），同一个表的每一行记录都拥有相同的若干字段。
>
> 字段定义了数据类型（整型、浮点型、字符串、日期等），以及是否允许为`NULL`。注意`NULL`表示字段数据不存在。一个整型字段如果为`NULL`不表示它的值为`0`，同样的，一个字符串型字段为`NULL`也不表示它的值为空串`''`。

**通常情况下，字段应该避免允许为NULL。不允许为NULL可以简化查询条件，加快查询速度，也利于应用程序读取数据后无需判断是否为NULL**。

### 主键

#### 主键

> 对于关系表，有个很重要的约束，就是任意两条记录不能重复。不能重复不是指两条记录不完全相同，而是指能够通过某个字段唯一区分出不同的记录，这个字段被称为**主键**。

> 选取主键的一个基本原则是：不使用任何业务相关的字段作为主键。

> 作为主键最好是完全业务无关的字段，我们一般把这个字段命名为`id`。常见的可作为`id`字段的类型有：
>
> - 自增整数类型：数据库会在插入数据时自动为每一条记录分配一个自增整数，这样我们就不用担心主键重复，也不用自己预先生成主键。
> - 全局唯一GUID类型：使用一种全局唯一的字符串作为主键，类似`8f55d96b-8acc-4636-8cb8-76bf8abc2f57`。GUID算法通过网卡MAC地址、时间戳和随机数保证任意计算机在任意时间生成的字符串都是不同的，大部分编程语言都内置了GUID算法，可以自己预算出主键。

**如果使用INT自增类型，那么当一张表的记录数超过2147183647（约21亿）时，会达到上限而出错。使用BIGINT自增类型则可以最多约922亿亿条记录。**

#### 联合主键

> 关系数据库实际上还允许通过多个字段唯一标识记录，即两个或更多的字段都设置为主键，这种主键被称为联合主键。
>
> 对于联合主键，允许有一列有重复，只要不是所有主键列都重复即可。

**没有必要的情况下，我们尽量不使用联合主键，因为它给关系表带来了复杂度的上升。**

### 外键

> 关系数据库通过外键可以实现一对多、多对多和一对一的关系。外键既可以通过数据库来约束，也可以不设置约束，仅依靠应用程序的逻辑来保证。

```sql
ALTER TABLE students
ADD CONSTRAINT fk_class_id
FOREIGN KEY (class_id)
REFERENCES class (id);
```

- 其中，外键约束的名称`fk_class_id`可以随意，`FOREIGN KEY (class_id)`指定了`class_id`作为外键，`REFERENCES classes (id)`指定了这个外键将关联到`classes`表的`id`列（即`classes`表的主键）。
- 通过定义外键约束，关系数据库可以保证无法插入无效的数据。
- **由于外键约束会降低数据库的性能，大部分互联网应用程序为了追求速度，并不设置外键约束，而是仅靠应用程序自身来保证逻辑的正确性。**

### 索引

> 在关系数据库中，如果有上万甚至上亿条记录，在查找记录的时候，想要获得非常快的速度，就需要使用索引。

> 对于主键，关系数据库会自动对其创建主键索引。使用主键索引的效率是最高的，因为主键会保证绝对唯一。

- 索引的效率取决于索引列的值是否散列，即该列的值如果越互不相同，那么索引效率越高。
- 索引的有点是提高了查询效率，缺点是在插入、更新和删除记录时，需要同时修改索引，因此，索引越多，插入、更新和删除记录的速度就越慢。
- 通过创建唯一索引，可以保证某一列的值具有唯一性。

## 查询数据

- 运行SQL脚本

  ```sql
  mysql -u root -p < init-test-data.sql
  ```

  就可以自动创建`test`数据库，并且在`test`数据库下创建`students`表和`classes`表，以及必要的初始化数据。

- 运行SQL脚本完整指令

  ```sql
  mysql -u用户名 -p密码 -D数据库 < [sql脚本文件路径全名]
  ```

  - 用户名`root`与`-u`之间空格可有可无；
  - `-p`后可直接跟密码，不能有空格；
  - `-D`后面接上数据库名称，如果在SQL脚本文件中使用了`use 数据库`，则`-D`选项可以忽略；

### 基本查询

- 要查询数据库表的数据，使用如下SQL语句：

  ```sql
  SELECT * FROM <表名>
  ```

  其中，`SELECT`是关键字，表示将要执行一个查询，`*`表示“所有列”，`FROM`表示将要从哪个表查询。

- `SELECT`语句其实并不要求一定要有`FROM`子句。

  ```sql
  SELECT 100+200;
  ```

  上述查询会直接计算出表达式的结果。不带`FROM`子句的`SELECT`语句有一个有用的用途，就是用来判断当前数据库的连接是否有效。许多检测工具会执行一条`SELECT 1;`来测试数据库连接。

### 条件查询

- 条件查询的语法是：

  ```&lt;&gt;
  SELECT * FROM <表名> WHERE <条件表达式>
  ```

  - `<条件表达式>`可以用`<条件1> AND <条件2>`表达满足条件1并且满足条件2；

  - `<条件表达式>`可以用`<条件1> OR <条件2>`表达满足条件1或者满足条件2；

  - `<条件表达式>`可以用`NOT <条件>`表示不符合该条件的记录。

    - 举例：“不是2班的学生”

      ```sql
      NOT class_id = 2 等价于 class_id <> 2
      ```

  - 要组合三个或者更多的条件，就需要使用小括号`()`表示如何进行条件运算。如果不加括号，条件运算按照`NOT`、`AND`、`OR`的优先级进行。

    - 举例：“查询分数在60分(含)~90分(含)之间的学生可以使用的WHERE语句是”

      ```sql
      WHERE score >= 60 AND score <= 90
      ```

      ```sql
      WHERE score BETWEEN 60 AND 90
      ```

### 投影查询

- 如果我们只希望返回某些列的数据，而不是所有列的数据，可以用`SELECT 列1, 列2, 列3 FROM...`，让结果集仅包含制定列。这种操作称为投影查询。
- 可以给每一列起一个别名，语法是`SELECT 列1 别名1, 列2 别名2, 列3 别名3 FROM...`

- 投影查询同样可以接WHERE条件，实现复杂的查询。

### 排序

- 当我们使用SELECT查询时，查询结果集通常是按照`id`排序的，也就是根据主键排序。当我们需要根据其它条件排序时，可以加上`ORDER BY`子句。 

- 默认是采用**升序(ASC)**，可以加上`DESC`表示**倒序**。

  ```sql
  -- 按score从高到低
  SELECT id, name, gender, score FROM students ORDER BY score DESC;
  ```

  

- **如果有`WHERE`子句，那么`ORDER BY`子句要放到`WHERE`子句后面。**

### 分页查询

- 分页实际上就是从结果集中“截取”出第M~N条记录。这个查询可以通过`LIMIT <M> OFFSET <N>`子句实现。
- 首先需要确定每页需要显示的结果数量`pageSize`，然后根据当前页的索引`pageIndex`(从1开始)，确定`LIMIT`和`OFFSET`应该设定的值。
  - `LIMIT`总是设定为`pageSize`;
  - `OFFSET`计算公式为`pageSize * (pageIndex - 1)`。
  - `OFFSET`超过了查询的最大数量并不会报错，而是得到一个空的结果集。

- 注意：
  - `OFFSET`是可选的，如果只写`LIMIT 15`，那么相当于`LIMIT 15 OFFSET 0`;
  - 在MySQL中，`LIMIT 15 OFFSET 30`还可以简写成`LIMIT 30, 15`。
  - 使用`LIMIT <M> OFFSET <N>`分页时，随着`N`的越来越大，查询效率也会越来越低。

### 聚合查询

- 查询`students`表一共有多少条记录为例，可以使用SQL内置的`COUNT()`函数查询

  ```sql
  SELECT COUNT(*) FROM students;
  ```

  - count(*) 表示查询所有列的行数； 

  - 通常，使用聚合查询时，我们应该给列设置一个别名，便于处理结果

    ```sql
    SELECT COUNT(*) NUM FROM students;
    ```

  - 聚合查询同样可以使用`WHERE`条件；

- SQL还提供了如下聚合函数：

  | 函数 |                  说明                  |
  | :--: | :------------------------------------: |
  | SUM  | 计算某一列的合计值，该列必须为数值类型 |
  | AVG  | 计算某一列的平均值，该列必须为数值类型 |
  | MAX  |           计算某一列的最大值           |
  | MIN  |           计算某一列的最小值           |

  **注意：`MAX()`和`MIN()`函数并不限于数值类型。如果是字符类型，`MAX()`和`MIN()`会返回排序最后和排序最前的字符。**

- 如果聚合查询的`WHERE`条件没有匹配到任何行，`COUNT()`会返回0，而`SUM()`、`AVG()`、`MAX()`和`MIN()`会返回`NULL`;

- 每页3条记录，如何通过聚合查询获得总页数？

  ```sql
  SELECT CEILING(COUNT(*)/3) FROM students;
  ```

#### 分组聚合

- 执行这个查询，`COUNT()`的结果不再是一个，而是三个，因为`GROUP BY`子句指定了按`class_id`分组，因此，执行该`SELECT`语句时，会把`class_id`相同的列先分组，再分别计算，因此，得到了3行结果。

  ```sql
  -- 按class_id分组：
  SELECT class_id, COUNT(*) num FROM students GROUP BY class_id;
  ```

- 也可以使用多个列进行分组。例如，我们想统计各班的男生和女生人数

  ```sql
  SELECT class_id, gender, COUNT(*) num FROM students GROUP BY class_id, gender; 
  ```

### 多表查询

- `SELECT`查询不但可以从一张表擦汗寻数据，还可以从多张表同时查询数据。查询多张表的语法是：`SELECT * FROM <表1> <表2>`。
- 多表查询时，要使用`表明.列名`这样的方式来印用列和设置别名，这样就避免了结果集的列名重复问题。
- 使用多表查询可以获取M x N行记录，多表查询的结果集可能非常巨大，要小心使用。

### 连接查询

- 先确定一个主表作为结果集，然后，把其它表的行有选择性地“连接”在主表结果集上。

- 举例`INNER JOIN`的写法：

  ```sql
  SELECT S.id, s.name, s.class_id, c.name class_name, s.gender, s.score
  FROM students s
  INNER JOIN classes c
  ON s.class_id = c.id;
  ```

  1. 先确定主表，仍然使用`FROM <表1>`的语法；
  2. 再确定需要连接的表，使用`INNER JOIN <表2>的语法`；
  3. 然后确定连接条件，使用`ON <条件...>`，这里的条件是`s.class_id = c.id`，表示`students`表的`class_id`列与`classes`表的`id`列相同的行需要连接；
  4. 可选：加上`WHERE`子句，`ORDER BY` 等子句。

- 多种**JOIN**查询

  ```sql
  SELECT...FROM tableA ??? JOIN tableB ON tableA.column1 = tableB.column2;
  ```

  - 我们把tableA看作左表，把tableB看成右表，那么INNER JOIN是选出两张表都存在的记录：

  ![pic](./pic/innerJoin.png)

  - LEFT OUTER JOIN是选出左表存在的记录：

    ![pic](./pic/leftOuterJoin.png)

  - RIGHT OUTER JOIN是选出右表存在的记录：

    ![pic](./pic/rightOuterJoin.png)

  - FULL OUTER JOIN则是选出左右表都存在的记录：

    ![pic](./pic/fullOuterJoin.png)

- JOIN查询仍然可以使用`WHERE`条件和`ORDER BY`排序；

## 修改数据

> 关系数据库的基本操作就是增删改查，即CRUD：Create、Retrieve、Update、Delete。

### INSERT

- `INSERT`语句的基本语法是：

  ```sql
  INSERT INTO <表名> (字段1, 字段2, ...) VALUES (值1, 值2, ...);
  ```

- 无需列出`id`字段，因为`id`字段是一个自增主键，它的值可以由数据库自己推算出来。

- 字段顺序不必和数据库表的顺序一致，但值的顺序必须和字段顺序一致。

- 可以一次性添加多条记录，只需要再`VALUES`子句中指定多个记录值，每个记录是由`(...)`包含的一组值：

  ```sql
  -- 一次性添加多条新记录
  INSERT INTO students (class_id, name, gender, score) VALUES
  	(1, '大宝', 'M', 87),
  	(2, '二宝', 'M', 81);
  ```

### UPDATE

- `UPDATE`语句的基本语法是：

  ```sql
  UPDATE <表名> SET 字段1 = 值1, 字段2 = 值2, ... WHERE ...;
  ```

- `UPDATE`语句的`WHERE`条件和`SELECT`语句的`WHERE`条件其实是一样的，可以一次更新多条记录；

- 在`UPDATE`语句中，更新字段时可以使用表达式：

  ```sql
  -- 更新score<80的记录
  UPDATE students SET score = score + 10 WHERE score < 80;
  -- 查询并观察结果
  SELECT * FROM students;
  ```

- 如果`WHERE`条件没有匹配到任何记录，`UPDATE`语句不会报错，也不会有任何记录被更新。

- `UPDATE`语句可以没有`WHERE`条件：

  ```sql
  UPDATE students SET score = 60;
  ```

  这时，整个表的所有记录都会被更新。所以，在执行`UPDATE`语句时要非常小心，最好先用`SELECT`语句来测试`WHERE`条件是否筛选出了期望的记录集，然后再用`UPDATE`更新。

### DELETE

- `DELETE`语句的基本语法是：

  ```sql
  DELETE FROM <表名> WHERE ...;
  ```

- `DELETE`语句可以一次删除多条记录；
- 如果`WHERE`条件没有匹配到任何记录，`DELETE`语句不会报错，也不会有任何记录被删除。
- **和`UPDATE`类似，不带`WHERE`条件的`DELETE`语句会删除整个表的数据。**

## MySQL

> 安装完MySQL后，除了MySQL Server，即真正的MySQL服务器外，还附赠一个MySQL Client程序。MySQL Client是一个命令行客户端，可以通过MySQL Client登录MySQL，然后输入SQL语句并执行。

- 打开命令提示符，输入命令`mysql -u root -p`，提示输入口令。填入MySQL的root口令，如果正确，就连上了MySQL Server，同时提示符变为`mysql`:

- 输入`exit`断开与MySQL Server的连接并返回到命令提示符。

- MySQL Client的可执行程序是mysql, MySQL Server的可执行程序是mysqld。

- MySQL Client和MySQL Server的关系如下：
	
	![pic](./pic/mysql.jpg)
  
	- 在MySQL Client中输入的SQL语句通过TCP连接发送到MySQL Server。默认端口号是3306，即如果发送到本机MySQL Server，地址就是`127.0.0.1：3306`。
  
  - 也可以只安装MySQL Client，然后连接到远程MySQL Server。假设远程MySQL Server的IP地址是`10.0.1.99`，那么就使用`-h`指定IP或域名：
  
    ```sql
    mysql -h 10.0.1.99 -u root -p
    ```

- 命令行程序`mysql`实际上是MySQL客户端，真正的MySQL服务器程序是`mysqld`，在后台运行。

### 管理MySQL

- MySQL Workbench可以用可视化的方式查询、创建和修改数据库表。
- 本质上，MySQL Workbench和MySQL Client命令行都是客户端，和MySQL交互，唯一的接口就是SQL。

#### 数据库

- 在一个运行MySQL的服务器上，实际上可以创建多个数据库（Datebase）。要列出所有数据库，使用命令：

  ```sql
  SHOW DATABASES;
  ```

  其中，`information_schema`、`mysql`、`performance_schema`和`sys`是系统库，不要去改动它们。其它的是用户创建的数据库。

- 创建一个新数据库，使用命令：

  ```sql
  CREATE DATABASE test;
  ```

- 删除一个数据库，使用命令：

  ```sql
  DROP DATEBASE test;
  ```

  **注意：删除一个数据库将导致该数据库的所有表全部被删除。**

- 对一个数据库进行操作时，要首先将其切换为当前数据库：

  ```sql
  USE test;
  ```

#### 表

- 列出当前数据库的所有表，使用命令：

  ```sql
  SHOW TABLES;
  ```

- 要查看一个表的结构，使用命令：

  ```sql
  DESC students;
  ```

- 还可以使用以下命令查看创建表的SQL语句：

  ```sql
  SHOW CREATE TABLE students;
  ```

- 创建表使用`CREATE TABLE`语句，而删除表使用`DROP TABLE`语句：

  ```sql
  DROP TABLE students;
  ```

- 如果要给`students`表新增一列`birth`，使用：

  ```sql
  ALTER TABLE students ADD COLUMN birth VARCHAR(10) NOT NULL;
  ```

- 要修改`birth`列，例如把列名改为`birthday`，类型改为`VARCHAR(20)`;

  ```sql
  ALTER TABLE students CHANGE COLUMN birth birthday VARCHAR(20) NOT NULL;
  ```

- 要删除列，使用：

  ```sql
  ALTER TABLE students DROP COLUMN birthday;
  ```

#### 退出MySQL

- 使用`Exit`命令退出MySQL

  ```sql
  EXIT
  ```

  **注意`EXIT`仅仅断开了客户端和服务器的连接，MySQL服务器仍然继续运行。**

## 事务

> 在执行SQL语句的时候，某些业务要求，一系列操作必须全部执行，而不能仅执行一部分。
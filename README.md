[![GitHub license](https://img.shields.io/badge/license-PostgreSQL-blue.svg)](https://raw.githubusercontent.com/postgrespro/pg_pathman/master/LICENSE)
# PsqlPlus

`PsqlPlus` provides common operation and maintenance sql for the postgresql and supports user-defined options.

`PsqlPlus` does **not** change any server files, and is implemented as an extension of the psql. It's easy to install and use.

The extension is compatible with:

 * PostgreSQL 10+;



## Installation guide

### Local installation

To install `psqlplus`, execute this in any directory:

```shell
git clone git@github.com:mutex73/psqlplus.git
cd psqlplus
chmod u+x setup.sh 
./setup.sh install
```

if your  PSQLRC 

### Remote installation

```

```

## Usage

### Connect to the postgresql using psql

>  Do not passed an `-X` option to psql

```shell
psql [option...] [dbname [username]]
```

### Enter **:pp** to start psqlplus

```sql
postgres=# :pp
```

### Enter your option

```
postgres=# :pp
PSQL+ MENU             

Table
  [1]     Table bloat estimation
...
...
Enter the options in menu[1,2,3...], press q if you want quit
```

**for example, press 1 to check out table bloat now **

```
Enter the options in menu[1,2,3...], press q if you want quit
1
    db    | schemaname | tablename |   tups    |  pages  |  otta   | tbloat | wastedpages | wastedbytes |   wastedsize    |      iname      |   itups   | ipages | iotta  | ibloat | wastedipages | wastedibytes |
 wastedisize | totalwastedbytes 
----------+------------+-----------+-----------+---------+---------+--------+-------------+-------------+-----------------+-----------------+-----------+--------+--------+--------+--------------+--------------+
-------------+------------------
 postgres | public     | t_likeall |     99812 |   36953 |    5130 |    7.2 |       31823 |   260694016 | 260694016 bytes | idx_t_likeall_1 |     99812 |    600 |   4935 |    0.1 |            0 |            0 |
 0 bytes     |        260694016
 postgres | public     | test      | 100000008 | 1234568 | 1223691 |    1.0 |       10877 |    89104384 | 89104384 bytes  | test_pkey       | 100000008 | 274188 | 991190 |    0.3 |            0 |            0 |
 0 bytes     |         89104384
 postgres | public     | t9        |   9999947 |  123457 |  122369 |    1.0 |        1088 |     8912896 | 8912896 bytes   | t9_pkey         |   9999947 |  27421 |  94224 |    0.3 |            0 |            0 |
 0 bytes     |          8912896
 postgres | public     | t10       |   9999947 |  123457 |  122369 |    1.0 |        1088 |     8912896 | 8912896 bytes   | t10_pkey        |   9999947 |  27421 |  94224 |    0.3 |            0 |            0 |
 0 bytes     |          8912896
 postgres | public     | t3        |  10000017 |  123457 |  122370 |    1.0 |        1087 |     8904704 | 8904704 bytes   | t3_pkey         |  10000017 |  27421 |  94225 |    0.3 |            0 |            0 |
 0 bytes     |          8904704
(5 rows)
```

press q if you want quit

## How to update





## Feedback

Do not hesitate to post your issues, questions and new ideas at the [issues](https://github.com/mutex73/psqlplus/issues) page.

## Authors

Gaomingjie <jackgo73(at)outlook.com> ?., China
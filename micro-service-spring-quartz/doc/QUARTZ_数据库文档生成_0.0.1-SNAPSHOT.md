# 数据库文档

**数据库名：** QUARTZ

**文档版本：** 0.0.1-SNAPSHOT

**文档描述：** 数据库文档生成
| 表名                  | 说明       |
| :-------------------- | :--------- |
| [ELE_CATALOG](#ELE_CATALOG) | 基础代码目录表 |
| [ELE_CATALOG_TYPE](#ELE_CATALOG_TYPE) |  |
| [ELE_DICTABLE](#ELE_DICTABLE) |  |
| [ELE_DICCOLUMN](#ELE_DICCOLUMN) |  |
| [ELE_COLS_STRUCTURE](#ELE_COLS_STRUCTURE) |  |
| [ELE_DATATYPE_ENUM](#ELE_DATATYPE_ENUM) |  |
| [ELE_ELEMENT](#ELE_ELEMENT) |  |
| [ELE_ELEMENT_TYPE](#ELE_ELEMENT_TYPE) |  |
**表名：** <a id="ELE_CATALOG">ELE_CATALOG</a>

**说明：** 基础代码目录表

**数据列：**

| 序号 | 名称 | 数据类型 |  长度  | 小数位 | 允许空值 | 主键 | 默认值 | 说明 |
| :--: | :--- | :------: | :----: | :----: | :------: | :--: | :----: | :--: |
|  1   | ELE_CATALOG_CODE |   varchar2   | 42 |   0    |    N     |  N   |       | 基础代码目录代码  |
|  2   | UPDATE_TIME |   date   | 7 |   0    |    N     |  N   |       | 更新时间  |
|  3   | ELE_CATALOG_ID |   varchar2   | 38 |   0    |    N     |  N   |       | 目录主键  |
|  4   | ELE_CATALOG_NAME |   varchar2   | 60 |   0    |    N     |  N   |       | 基础代码中文名称  |
|  5   | MOF_DIV_CODE |   varchar2   | 9 |   0    |    N     |  N   |       | 财政区划代码  |
|  6   | ELE_SOURCE |   varchar2   | 30 |   0    |    N     |  N   |       | 库表名称  |
|  7   | START_DATE |   date   | 7 |   0    |    N     |  N   |       | 启用日期  |
|  8   | END_DATE |   date   | 7 |   0    |    N     |  N   |       | 停用日期  |
|  9   | CREATE_TIME |   date   | 7 |   0    |    N     |  N   |       | 创建时间  |
|  10   | ELEMENTCODE |   varchar2   | 100 |   0    |    Y     |  N   |       | 英文编码  |
|  11   | CODEMODE |   varchar2   | 32 |   0    |    Y     |  N   |       | 层码结构  |
|  12   | YEAR |   char   | 4 |   0    |    Y     |  N   |       | 财年  |
|  13   | TYPEGUID |   varchar2   | 32 |   0    |    Y     |  N   |       | 代码集类别guid  |
|  14   | REMARK |   varchar2   | 200 |   0    |    Y     |  N   |       | 备注说明字段  |
|  15   | ELE_EXTEND_TYPE |   char   | 1 |   0    |    Y     |  N   |       | 扩展类型  |
|  16   | IS_STANDARD |   char   | 1 |   0    |    Y     |  N   |       | 是否标准  |
|  17   | ELE_MANAGE_TYPE |   char   | 1 |   0    |    Y     |  N   |       | 管理方式  |
|  18   | IS_ENABLED |   char   | 1 |   0    |    Y     |  N   |       | 是否启用  |
|  19   | IS_DELETED |   char   | 1 |   0    |    Y     |  N   |       | 是否删除  |
|  20   | APPLY |   char   | 1 |   0    |    Y     |  N   |       | 使用方式  |
|  21   | ELE_TYPE_ID |   char   | 1 |   0    |    Y     |  N   |       | 目录分类  |
|  22   | IS_VINDICATE |   char   | 1 |   0    |    Y     |  N   |       | 是否可维护  |
|  23   | IS_MASTERDATA |   char   | 1 |   0    |    Y     |  N   |       | 数据类别  |
**表名：** <a id="ELE_CATALOG_TYPE">ELE_CATALOG_TYPE</a>

**说明：** 

**数据列：**

| 序号 | 名称 | 数据类型 |  长度  | 小数位 | 允许空值 | 主键 | 默认值 | 说明 |
| :--: | :--- | :------: | :----: | :----: | :------: | :--: | :----: | :--: |
|  1   | ELE_TYPE_ID |   varchar2   | 32 |   0    |    N     |  N   |       | 类型主键  |
|  2   | ELE_TYPE_NAME |   varchar2   | 50 |   0    |    N     |  N   |       | 类型中文名称  |
|  3   | PARENT_ID |   varchar2   | 32 |   0    |    N     |  N   |       | 上级所属id  |
|  4   | CREATEUSER |   varchar2   | 50 |   0    |    Y     |  N   |       | 创建目录用户  |
|  5   | CREATE_TIME |   date   | 7 |   0    |    Y     |  N   |       | 创建时间  |
|  6   | YEAR |   char   | 4 |   0    |    N     |  N   |       | 财年  |
|  7   | PROVINCE |   varchar2   | 9 |   0    |    N     |  N   |       | 财政区划  |
|  8   | APPID |   varchar2   | 50 |   0    |    Y     |  N   |       | 所属应用  |
|  9   | TABNAME_RULE |   varchar2   | 20 |   0    |    Y     |  N   |       | 定义表名规则  |
|  10   | LEVELNO |   char   | 1 |   0    |    N     |  N   |       | 级次  |
|  11   | IS_TYPE |   char   | 1 |   0    |    N     |  N   |       | 是否是目录  |
|  12   | CATALOG_TYPE |   char   | 1 |   0    |    Y     |  N   |       | 目录分类  |
|  13   | CATALOG_SORT |   char   | 5 |   0    |    Y     |  N   |       | 排序  |
**表名：** <a id="ELE_DICTABLE">ELE_DICTABLE</a>

**说明：** 

**数据列：**

| 序号 | 名称 | 数据类型 |  长度  | 小数位 | 允许空值 | 主键 | 默认值 | 说明 |
| :--: | :--- | :------: | :----: | :----: | :------: | :--: | :----: | :--: |
|  1   | TAB_ID |   varchar2   | 32 |   0    |    N     |  Y   |       | 主键  |
|  2   | ELE_SOURCE |   varchar2   | 30 |   0    |    N     |  N   |       | 库表名称  |
|  3   | TAB_NAME |   varchar2   | 50 |   0    |    N     |  N   |       | 定义表中文名称  |
|  4   | TAB_VIEWNAME |   varchar2   | 30 |   0    |    N     |  N   |       | 定义表视图名称  |
|  5   | REMARK |   varchar2   | 100 |   0    |    Y     |  N   |       | 备注说明  |
|  6   | ISSHOW |   char   | 1 |   0    |    N     |  N   |       | 是否显示  |
|  7   | ISUSES |   char   | 1 |   0    |    N     |  N   |       | 是否使用  |
|  8   | CREATE_TIME |   date   | 7 |   0    |    N     |  N   |       | 创建时间  |
|  9   | UPDATE_TIME |   date   | 7 |   0    |    N     |  N   |       | 更新时间  |
|  10   | END_DATE |   date   | 7 |   0    |    Y     |  N   |       | 停用日期  |
|  11   | YEAR |   char   | 4 |   0    |    N     |  N   |       | 财年  |
|  12   | PROVINCE |   varchar2   | 9 |   0    |    N     |  N   |       | 财政区划  |
|  13   | APPID |   varchar2   | 50 |   0    |    N     |  N   |       | 所属应用  |
|  14   | CATALOG_TYPE_ID |   varchar2   | 32 |   0    |    Y     |  N   |       | 父级目录id  |
|  15   | CODEMODE |   varchar2   | 32 |   0    |    Y     |  N   |       | 编码方式  |
|  16   | APPLY |   char   | 1 |   0    |    N     |  N   |       | 所属应用  |
|  17   | ELEMENT_EL_CODE |   varchar2   | 32 |   0    |    N     |  N   |       | 英文标识  |
|  18   | COL_VIEW |   varchar2   | 2000 |   0    |    Y     |  N   |       | 视图sql  |
|  19   | ENTITY_NUMBER |   varchar2   | 50 |   0    |    Y     |  N   |       | 数据实体编号  |
|  20   | ELE_TYPE_ID |   char   | 1 |   0    |    N     |  N   |       | 目录分类  |
**表名：** <a id="ELE_DICCOLUMN">ELE_DICCOLUMN</a>

**说明：** 

**数据列：**

| 序号 | 名称 | 数据类型 |  长度  | 小数位 | 允许空值 | 主键 | 默认值 | 说明 |
| :--: | :--- | :------: | :----: | :----: | :------: | :--: | :----: | :--: |
|  1   | COL_ID |   varchar2   | 32 |   0    |    N     |  Y   |       | 主键  |
|  2   | ELE_SOURCE |   varchar2   | 30 |   0    |    N     |  N   |       | 库表名称  |
|  3   | ELEMENT_CODE |   varchar2   | 50 |   0    |    N     |  N   |       | 库表要素编号  |
|  4   | ELEMENT_NAME |   varchar2   | 100 |   0    |    N     |  N   |       | 中文名称  |
|  5   | ELEMENT_EL_CODE |   varchar2   | 50 |   0    |    N     |  N   |       | 英文短名  |
|  6   | ELEMENT_DATATYPE |   varchar2   | 10 |   0    |    N     |  N   |       | 数据类型  |
|  7   | ELEMENT_DATALENGTH |   varchar2   | 20 |   0    |    Y     |  N   |       | 数据长度  |
|  8   | ELEMENT_DATATYPE_FORMAT |   varchar2   | 10 |   0    |    N     |  N   |       | 数据库类型  |
|  9   | ELE_CATALOG_ID |   varchar2   | 38 |   0    |    Y     |  N   |       | 引用代码集要素guid  |
|  10   | REMARK |   varchar2   | 200 |   0    |    Y     |  N   |       | 字段说明  |
|  11   | SOURCETEXT |   varchar2   | 200 |   0    |    Y     |  N   |       | 参考来源  |
|  12   | ISSHOW |   char   | 1 |   0    |    N     |  N   |       | 页面是否显示  |
|  13   | ISUSES |   char   | 1 |   0    |    N     |  N   |       | 是否使用  |
|  14   | CREATE_TIME |   date   | 7 |   0    |    N     |  N   |       | 创建时间  |
|  15   | UPDATE_TIME |   date   | 7 |   0    |    N     |  N   |       | 更新时间  |
|  16   | END_DATE |   date   | 7 |   0    |    Y     |  N   |       | 停用日期  |
|  17   | YEAR |   char   | 4 |   0    |    N     |  N   |       | 财年  |
|  18   | PROVINCE |   varchar2   | 9 |   0    |    N     |  N   |       | 财政区划  |
|  19   | DEFAULTVALUE |   varchar2   | 32 |   0    |    Y     |  N   |       | 默认值  |
|  20   | COMPEL_OR_CHOICE |   char   | 1 |   0    |    Y     |  N   |       | 强制可选  |
|  21   | ELEMENT_ID |   varchar2   | 38 |   0    |    Y     |  N   |       | 对应逻辑库表要素id  |
|  22   | ACTUAL_DATATYPE |   varchar2   | 10 |   0    |    N     |  N   |       | 真实数据类型  |
|  23   | IS_VIEW |   char   | 1 |   0    |    Y     |  N   |       | 创建视图是否引用当前列  |
|  24   | IS_EDIT |   char   | 1 |   0    |    Y     |  N   |       | 是否可编辑  |
|  25   | IS_KEY |   char   | 1 |   0    |    Y     |  N   |       | 是否主键  |
**表名：** <a id="ELE_COLS_STRUCTURE">ELE_COLS_STRUCTURE</a>

**说明：** 

**数据列：**

| 序号 | 名称 | 数据类型 |  长度  | 小数位 | 允许空值 | 主键 | 默认值 | 说明 |
| :--: | :--- | :------: | :----: | :----: | :------: | :--: | :----: | :--: |
|  1   | STRUCT_ID |   varchar2   | 32 |   0    |    N     |  Y   |       | 主键  |
|  2   | ELEMENT_NAME |   varchar2   | 100 |   0    |    N     |  N   |       | 逻辑库表要素中文名称  |
|  3   | ELEMENTCODE |   varchar2   | 50 |   0    |    N     |  N   |       | 英文短名  |
|  4   | ELEMENT_ID |   varchar2   | 38 |   0    |    N     |  N   |       | 逻辑库表要素id  |
|  5   | ELEMENT_DATATYPE |   varchar2   | 10 |   0    |    N     |  N   |       | 数据类型  |
|  6   | ELEMENT_DATALENGTH |   varchar2   | 20 |   0    |    Y     |  N   |       | 数据长度  |
|  7   | ELEMENT_DATATYPE_FORMAT |   varchar2   | 10 |   0    |    N     |  N   |       | 数据库类型  |
|  8   | ELE_CATALOG_ID |   varchar2   | 38 |   0    |    Y     |  N   |       | 引用代码集要素guid  |
|  9   | REMARK |   varchar2   | 100 |   0    |    Y     |  N   |       | 备注说明  |
|  10   | YEAR |   char   | 4 |   0    |    N     |  N   |       | 财年  |
|  11   | PROVINCE |   varchar2   | 9 |   0    |    N     |  N   |       | 财政区划  |
|  12   | APPID |   varchar2   | 50 |   0    |    Y     |  N   |       | 所属应用  |
|  13   | ELE_TYPE_ID |   varchar2   | 32 |   0    |    Y     |  N   |       | 类型主键  |
|  14   | ACTUAL_DATATYPE |   varchar2   | 10 |   0    |    Y     |  N   |       | 真实字段类型  |
**表名：** <a id="ELE_DATATYPE_ENUM">ELE_DATATYPE_ENUM</a>

**说明：** 

**数据列：**

| 序号 | 名称 | 数据类型 |  长度  | 小数位 | 允许空值 | 主键 | 默认值 | 说明 |
| :--: | :--- | :------: | :----: | :----: | :------: | :--: | :----: | :--: |
|  1   | GUID |   varchar2   | 32 |   0    |    N     |  Y   |       | 主键  |
|  2   | RULE_CODE |   varchar2   | 50 |   0    |    Y     |  N   |       | 规范编码  |
|  3   | RULE_NAME |   varchar2   | 50 |   0    |    Y     |  N   |       | 规范名称  |
|  4   | ACTUAL_CODE |   varchar2   | 50 |   0    |    Y     |  N   |       | 实际编码  |
|  5   | CREATE_TIME |   date   | 7 |   0    |    Y     |  N   |       | 创建时间  |
|  6   | REMARK |   varchar2   | 200 |   0    |    Y     |  N   |       | 备注  |
|  7   | YEAR |   char   | 4 |   0    |    Y     |  N   |       | 年份  |
|  8   | PROVINCE |   varchar2   | 9 |   0    |    Y     |  N   |       | 区划  |
|  9   | DATABASE_TYPE |   varchar2   | 10 |   0    |    Y     |  N   |   'oracle'    | 数据库类型  |
**表名：** <a id="ELE_ELEMENT">ELE_ELEMENT</a>

**说明：** 

**数据列：**

| 序号 | 名称 | 数据类型 |  长度  | 小数位 | 允许空值 | 主键 | 默认值 | 说明 |
| :--: | :--- | :------: | :----: | :----: | :------: | :--: | :----: | :--: |
|  1   | ELEMENT_ID |   varchar2   | 38 |   0    |    N     |  Y   |       | 主键  |
|  2   | ELEMENT_CODE |   varchar2   | 50 |   0    |    N     |  N   |       | 库表要素编号  |
|  3   | ELEMENT_NAME |   varchar2   | 100 |   0    |    N     |  N   |       | 中文名称  |
|  4   | ELEMENT_EL_CODE |   varchar2   | 50 |   0    |    N     |  N   |       | 英文短名  |
|  5   | ELEMENT_DATATYPE |   varchar2   | 10 |   0    |    N     |  N   |       | 数据类型  |
|  6   | ELEMENT_DATALENGTH |   varchar2   | 20 |   0    |    Y     |  N   |       | 数据长度  |
|  7   | ELEMENT_DATATYPE_FORMAT |   varchar2   | 10 |   0    |    N     |  N   |       | 数据库类型  |
|  8   | ELE_CATALOG_ID |   varchar2   | 38 |   0    |    Y     |  N   |       | 引用代码集要素guid  |
|  9   | REMARK |   varchar2   | 200 |   0    |    Y     |  N   |       | 字段说明  |
|  10   | SOURCETEXT |   varchar2   | 200 |   0    |    Y     |  N   |       | 参考来源  |
|  11   | START_DATE |   date   | 7 |   0    |    Y     |  N   |       | 启用日期  |
|  12   | END_DATE |   date   | 7 |   0    |    Y     |  N   |       | 停用日期  |
|  13   | IS_ENABLED |   char   | 1 |   0    |    N     |  N   |       | 是否启用  |
|  14   | UPDATE_TIME |   date   | 7 |   0    |    N     |  N   |       | 更新时间  |
|  15   | IS_DELETED |   char   | 1 |   0    |    N     |  N   |       | 是否删除  |
|  16   | CREATE_TIME |   date   | 7 |   0    |    N     |  N   |       | 创建时间  |
|  17   | MOF_DIV_CODE |   varchar2   | 9 |   0    |    N     |  N   |       | 财政区划  |
|  18   | YEAR |   char   | 4 |   0    |    N     |  N   |       | 财政年度  |
|  19   | TYPEGUID |   varchar2   | 32 |   0    |    N     |  N   |       | 逻辑库表类型guid  |
|  20   | ACTUAL_DATATYPE |   varchar2   | 10 |   0    |    N     |  N   |       | 实际数据类型  |
**表名：** <a id="ELE_ELEMENT_TYPE">ELE_ELEMENT_TYPE</a>

**说明：** 

**数据列：**

| 序号 | 名称 | 数据类型 |  长度  | 小数位 | 允许空值 | 主键 | 默认值 | 说明 |
| :--: | :--- | :------: | :----: | :----: | :------: | :--: | :----: | :--: |
|  1   | ELE_TYPE_ID |   varchar2   | 32 |   0    |    N     |  Y   |       | 类型主键  |
|  2   | ELE_TYPE_NAME |   varchar2   | 50 |   0    |    N     |  N   |       | 类型中文名称  |
|  3   | PARENT_ID |   varchar2   | 32 |   0    |    N     |  N   |       | 上级所属id  |
|  4   | CREATEUSER |   varchar2   | 50 |   0    |    Y     |  N   |       | 创建目录用户  |
|  5   | YEAR |   char   | 4 |   0    |    N     |  N   |       | 财年  |
|  6   | PROVINCE |   varchar2   | 9 |   0    |    N     |  N   |       | 财政区划  |
|  7   | APPID |   varchar2   | 50 |   0    |    N     |  N   |       | 所属应用  |
|  8   | LEVELNO |   char   | 1 |   0    |    N     |  N   |       | 级次  |
|  9   | IS_TYPE |   char   | 1 |   0    |    N     |  N   |       | 是否目录  |
|  10   | ELEMENT_SORT |   char   | 5 |   0    |    Y     |  N   |       | 排序  |
|  11   | CREATETIME |   date   | 7 |   0    |    Y     |  N   |       | 创建时间  |

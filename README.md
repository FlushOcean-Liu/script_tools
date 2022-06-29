# script_tools
记录工作学习中常用的脚本小工具。


## 1.查看每个文件每一行，指定分隔符，打印分割后指定索引位置的字符串

```bash
cat test.txt | awk -F" " '{print $2}'
```

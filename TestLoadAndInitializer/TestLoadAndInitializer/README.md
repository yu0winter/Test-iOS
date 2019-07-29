# 测试Load和Initialize方法


## 测试结果

- 分类的load方法，不会被覆盖。
- 原类的initialize的方法，==会==被覆盖

## 结论

- 在优化代码启动速度时，会设法减少+load方法，其中一个方案就是使用initialize替换。但一定要注意的就是，initialize方法间会被覆盖。

```
+[TestClass load]
DuplicateMethod : +[TestClass(DuplicateMethod) load]
DuplicateMethod : +[TestClass(DuplicateMethod) initialize]
+[TestClass test]
Hello, World!
Program ended with exit code: 0
```

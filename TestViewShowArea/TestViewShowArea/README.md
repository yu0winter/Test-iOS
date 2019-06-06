#  TestViewShowArea

## 经验

```
- (CGRect)convertRect:(CGRect)rect fromView:(UIView *)view;
- (CGRect)convertRect:(CGRect)rect toView:(UIView *)view;
```

以上两个方法的用法和区别：

```
- (CGRect)convertRect:(CGRect)rect fromView:(UIView *)view;

// 转换viewB坐标系内区域area，在viewA坐标系中的位置。
CGRect area = viewB.bounds;
CGRect rect = [viewA convertRect:area fromView:viewB];

viewB坐标系内区域area，在viewA坐标系中的位置。
上述方法area取的是viewB.bounds的值，因此又可以描述为：
viewB在viewA内部坐标系中的位置。
```
```
- (CGRect)convertRect:(CGRect)rect toView:(UIView *)view;

// 转换viewA坐标系内区域area，在viewB坐标系中的位置。
CGRect area = viewA.bounds;
CGRect rect = [viewA convertRect:area toView:viewB];
上述方法area取的是viewA.bounds的值，因此又可以描述为：
viewA在viewB内部坐标系中的位置。
```


## 疑问：两个视图是否加载一个UIWindow上

主要内容加载在主UIWindow上，每一个UIWindow对应有且只有一个screen。至于其他UIWindow的使用时机，如键盘界面。因此，忽略键盘界面。默认所有视图都加在主UIWindow上。


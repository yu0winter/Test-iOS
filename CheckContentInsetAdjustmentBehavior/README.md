

iOS11.0以下。

-[UIViewController automaticallyAdjustsScrollViewInsets] (iOS7.0引入，11.0废除）
作用：UINavigationBar与UITabBar默认都是半透明模糊效果，在这种情况下系统会对视图控制器的UI布局进行优化：当视图控制器里面【第一个】被添加进去的视图是UIScrollView或其子类时，系统会自动调整其内边距属性contentInset，以保证滑动视图里的内容不被UINavigationBar与UITabBar遮挡。

备注：可通过修改self.viewArray中视图顺序，并查看contentOffset变化结果来验证。


iOS11.0 以上

1.枚举解读
UIScrollViewContentInsetAdjustmentBehavior 是一个枚举类型,值有以下几种:
* automatic 和scrollableAxes一样,scrollView会自动计算和适应顶部和底部的内边距并且在scrollView 不可滚动时,也会设置内边距.
* scrollableAxes 自动计算内边距.
* never不计算内边距
* always 根据safeAreaInsets 计算内边距

2.验证结论
UITableView/UICollectionView 无论是否为Viewd第一个视图。都会响应ContentInsetAdjustmentBehavior配置。

UITextView/UIScrollView 只有为第一个添加的视图时(第一个通过addSubView到VC.view上)时，才会响应ContentInsetAdjustmentBehavior配置。

3.其他
无Home键的手机，底部会计算34pt的安全间距




## 参考链接

- [automaticallyAdjustsScrollViewInsets](https://www.jianshu.com/p/a1987a7c11ba)
- [适配iOS11--contentInsetAdjustmentBehavior](https://www.jianshu.com/p/1601bd885f83)

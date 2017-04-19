# OXClassifyTagDemo
三级指标/三级分类内容展示demo

因为项目需要实现了一个分类查找的界面，多个类别/指标之间有多级依赖关系，效果如下：

![](http://img.blog.csdn.net/20170419220453231?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvQ2xvdWRveF8=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

整个demo使用MVC架构。

分三级，也就是分三类，用表头的view来展示，自定义实现一个表头的headerView类。

表头右边指标的箭头动画使用UIView动画实现，点击后会判断该类下是否有内容并且避免跳级展开显示，通过delegate回调刷新列表，但是为了完整显示箭头动画，这个回调操作使用GCD来延迟执行。收起时会收起所有小于等于该级别的分类列表

各个分类/指标使用一个自定义的Model来装载数据。每个Model有以下数据：

* id
* 标题
* 是否是叶子节点（比如古文学就是个叶子节点，下面不会再有分类了，因此点击后没有效果了
* 下属节点数组（比如文学下属数组包含中国文学和外国文学，中国文学下属数组包含古文学和小说文学，在点击一个节点后通过该数组获取其下属内容并显示）

采用这种结构是为了方便构建多级依赖关系的树状结构，同时用一个是否有叶子节点的属性，可以用于不一定都是满树的情况。

列表及一些逻辑放在Controller内，列表、delegate等，都比较常见。

更多内容可以查看[我的博客](http://blog.csdn.net/Cloudox_/article/details/70246020)

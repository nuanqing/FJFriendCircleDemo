# FJFriendCircleDemo
仿微信朋友圈

>
>仿微信朋友圈Demo
>

![效果图](https://github.com/nuanqing/FJFriendCircleDemo/blob/master/FJFriendCicle.gif)

主要功能介绍
-----
1.使用YYKit进行圆角处理，防止离屏渲染
2.使用YYKit对评论持久化存储
3.拥有点赞，富文本加入可点击链接手机号
4.动态改变评论框的大小
5.使用SDPhotoBrowser对图片进行处理，可放大点击
6.使用Masonry进行布局

说明
-----
主体分为三部分：头视图，tableViewCell，脚视图，发表的内容为头视图部分，评论内容为单个cell，这样能够进行tableView的复用，避免计算上的麻烦，没有使用tableView预估高度处理，而是通过手动计算，更加精确，同时避免tableView reloadData 时耗费更多时长计算cell高度



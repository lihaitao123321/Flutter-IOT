import 'package:flutter/material.dart';

class KScroll extends StatefulWidget {
  final bool openRefresh; // 开启下拉刷新
  final bool openLoad; // 开启上拉加载
  final String topSuccessText;
  final String topErrorText;
  final String bottomLoadingText;
  final String bottomErrorText;
  final List datasource;
  final int total;
  final Function refreshFun;
  final Function loadFun;
  final Function itemBuilder; // 渲染item的方法

  KScroll({
    Key key,
    this.openRefresh = true,
    this.openLoad = true,
    this.topSuccessText = '刷新成功',
    this.topErrorText = '刷新失败，请稍后再试',
    this.bottomLoadingText = '玩命加载中...',
    this.bottomErrorText = '哎呀，已经到底啦😅',
    this.datasource,
    this.refreshFun,
    this.loadFun,
    this.itemBuilder,
    this.total,
  }) : super(key: key);

  @override
  _KScrollState createState() => _KScrollState();
}

class _KScrollState extends State<KScroll> {
  bool isLoading = false;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    // 给列表滚动添加监听
    this.scrollController.addListener(() {
      // 滑动到底部的关键判断
      if (!isLoading &&
          scrollController.position.pixels >= scrollController.position.maxScrollExtent &&
          widget.datasource.length < widget.total) {
        // 开始加载数据
        setState(() {
          isLoading = true;
          widget.loadFun().then((res) {
            isLoading = false;
          });
        });
      }
    });
  }

  Widget renderBottom() {
    if (widget.datasource.length >= widget.total) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        child: Text(
          widget.bottomErrorText,
          style: TextStyle(
            fontSize: 15,
            color: Color(0xFF333333),
          ),
        ),
      );
    } else if (this.isLoading) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.bottomLoadingText,
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF333333),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 10)),
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 3),
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        child: Text(
          '上拉加载更多',
          style: TextStyle(
            fontSize: 15,
            color: Color(0xFF333333),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.refreshFun,
      child: ListView.separated(
        controller: this.scrollController,
        itemCount: widget.datasource.length + 1,
        itemBuilder: (context, index) {
          if (index < widget.datasource.length) {
            return widget.itemBuilder(context, index);
          } else {
            return this.renderBottom();
          }
        },
        separatorBuilder: (context, index) {
          // indent: 起点缩进距离
          // endIndent: 终点缩进距离
          // color: 分割线颜色
          // height: 分割线区域的高度，并非分割线的高度
          // thickness: 分割线的厚度，真正的分割线的高度
          return Divider(
            height: .5,
            indent: 16,
            endIndent: 16,
            color: Color(0xFFDDDDDD),
          );
        },
      ),
    );
  }
}

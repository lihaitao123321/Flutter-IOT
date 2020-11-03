import 'package:charge/components/card/news.dart';
import 'package:charge/components/scroll.dart';
import 'package:charge/components/toast.dart';
import 'package:charge/pages/videos/video_player.dart';
import 'package:charge/provide/theme_provide.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

class VideoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<VideoPage> {
  List videos = [];
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      videos.add({
        "id": i.toString(),
        "title": i.toString() + '江南皮革厂倒闭了。。。',
        "source": '江南大事件',
        "comments": i,
        "coverImgUrl":
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1604380142056&di=64f283c90e5a74a7ac53e7605189732f&imgtype=0&src=http%3A%2F%2Fa1.att.hudong.com%2F24%2F78%2F20300000291746133783784887147.jpg"
      });
    }
  }

  Future onRefresh() {
    return Future.delayed(Duration(seconds: 2), () {
      List videoList = [];
      for (int i = 0; i < 10; i++) {
        videoList.add({
          "id": i.toString(),
          "title": i.toString() + '江南皮革厂倒闭了。。。',
          "source": '江南大事件',
          "comments": i,
          "coverImgUrl":
              "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1604380142056&di=64f283c90e5a74a7ac53e7605189732f&imgtype=0&src=http%3A%2F%2Fa1.att.hudong.com%2F24%2F78%2F20300000291746133783784887147.jpg"
        });
      }
      setState(() {
        videos = videoList;
      });
      KToast.success('刷新成功');
    });
  }

  Future onLoad() {
    return Future.delayed(Duration(seconds: 2), () {
      int length = videos.length;
      for (int i = length; i < length + 10; i++) {
        videos.add({
          "id": i.toString(),
          "title": i.toString() + '江南皮革厂倒闭了。。。',
          "source": '江南大事件',
          "comments": i,
          "coverImgUrl":
              "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1604380142056&di=64f283c90e5a74a7ac53e7605189732f&imgtype=0&src=http%3A%2F%2Fa1.att.hudong.com%2F24%2F78%2F20300000291746133783784887147.jpg"
        });
        setState(() {
          videos = [...videos];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProvideMulti(
        requestedValues: [ThemeProvide],
        builder: (context, child, model) {
          return Scaffold(
              body: KScroll(
                  datasource: videos,
                  total: 50,
                  refreshFun: onRefresh,
                  loadFun: onLoad,
                  itemBuilder: (con, index) => NewsCard(
                      key: UniqueKey(),
                      data: videos[index],
                      onTapCallback: (res) {
                        Navigator.push(
                            context, new MaterialPageRoute(builder: (context) => new VideoDetial(id: res["id"])));
                      })));
        });
  }
}

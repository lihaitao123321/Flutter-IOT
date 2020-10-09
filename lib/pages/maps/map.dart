import 'dart:convert';

import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:decorated_flutter/decorated_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

import 'package:charge/components/loading.dart';
import 'package:charge/components/toast.dart';
import 'package:charge/provide/theme_provide.dart';
import 'package:charge/service/http_service.dart';
import 'package:charge/tools/amapUtil.dart';

import '../../config/index.dart';

class MapPage extends StatefulWidget {
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng _latLng;
  AmapController _controller;
  bool showMarker = false;
  Map markInfo;
  List<Marker> _markers = [];
  List<Map> bannerList = [
    {"label": '运行', "value": 306, "color": Colors.green},
    {"label": '停机', "value": 54, "color": Colors.grey},
    {"label": '异常', "value": 7, "color": Colors.yellow},
    {"label": '报警', "value": 8, "color": Colors.red}
  ];

  /// 地图创建完成
  Future<void> _onMapCreated(AmapController controller) async {
    _controller = controller;
    //地图按中心点缩放
    await _controller?.setZoomByCenter(true);
    //开始定位
    await _controller?.showMyLocation(
        MyLocationOption(show: true, myLocationType: MyLocationType.Rotate));
    //获取定位位置
    final latLng = await _controller?.getLocation();
    _latLng = latLng;
    _initData();
    //设置中心点为当前定位位置
    await _controller
        ?.setCenterCoordinate(LatLng(latLng.latitude, latLng.longitude));
  }

  /// marker列表创建
  void createMarkerList(List<Map> dataList) async {
    List markers = [];
    for (int i = 0; i < dataList.length; i++) {
      Map item = dataList[i];
      final marker = await _controller?.addMarker(MarkerOption(
          latLng: LatLng(item["latitude"], item["longitude"]),
          iconProvider: AssetImage('asset/images/mark_red.png'),
          title: '北京',
          // snippet: '中国的首都北京，欢迎来到北京',
          object: json.encode({
            "latitude": _latLng.latitude - 0.5,
            "longitude": _latLng.longitude - 0.5
          })));
      //给点标记增加点击事件监听
      await _controller?.setMarkerClickedListener((marker) async {
        marker.object.then((value) {
          _setMarkInfo(json.decode(value));
          _setShowMarker(true);
        });
      });
      //把点标记存储起来
      markers.add(marker);
    }
    _markers = markers;
  }

  /// marker的展示或隐藏
  void _setShowMarker(bool boo) {
    setState(() {
      showMarker = boo;
    });
  }

  /// 设置弹出层的展示信息
  void _setMarkInfo(Map info) {
    setState(() {
      markInfo = info;
    });
  }

  /// 初始化页面数据
  void _initData() {
    // KToast toast = KToast();
    // ignore: missing_return
    request('getMapPointList', {
      "longitude": _latLng.longitude,
      "latitude": _latLng.latitude,
      "radius": 9999999999
    }).then((data) {
      //这是地图左侧和站点marker列表的内容,目前不能切换站点，还没有数据
      print(data);
    });
  }

  void setLeftInfo() {}

  @override
  Widget build(BuildContext context) {
    // final double topPadding = MediaQuery.of(context).padding.top;
    // final double bottomPadding = MediaQuery.of(context).padding.bottom;
    return ProvideMulti(
        requestedValues: [ThemeProvide],
        builder: (context, child, model) {
          Map currentTheme = model.get<ThemeProvide>().currentTheme;
          return Scaffold(
            backgroundColor: KColor.backgroundColor,
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () => {},
            //   tooltip: 'Increment',
            //   child: Icon(Icons.add),
            // ),
            body: FutureBuilder(
              builder: (context, snapshot) {
                return ConstrainedBox(
                    constraints: BoxConstraints.expand(),
                    child: Stack(
                      alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
                      children: <Widget>[
                        AmapView(
                          // 地图View创建完成回调
                          onMapCreated: _onMapCreated,
                          //地图类型
                          mapType: MapType.Standard,
                          // 是否显示SDK自带的缩放控件，如果你有自定义缩放控件的需求，就隐藏之。
                          showZoomControl: false,
                          // 是否显示指南针
                          showCompass: true,
                          // 是否显示比例尺
                          showScaleControl: true,
                          // 是否使能缩放手势
                          zoomGesturesEnabled: true,
                          // 是否使能滚动手势
                          scrollGesturesEnabled: true,
                          // 是否使能旋转手势
                          rotateGestureEnabled: true,
                          // 是否使能倾斜手势
                          tiltGestureEnabled: false,
                          // 初始的缩放级别 地图的缩放级别一共分为 17 级，从 3 到 19. 数字越大，展示的图面信息越精细
                          zoomLevel: 13,
                          // 初始的中心点
                          // this.centerCoordinate,
                          // 初始的marker
                          // this.markers,
                          // marker点击事件监听
                          // this.onMarkerClicked,
                          // 地图点击事件监听
                          // this.onMapClicked,
                          // 地图移动开始监听
                          // this.onMapMoveStart,
                          // 地图移动中监听（专业版）
                          // this.onMapMoving,
                          // 地图移动中监听
                          // this.onMapMoveEnd,
                          maskDelay: Duration(milliseconds: 500),
                        ),
                        // 地图工具条
                        _MapTools(onPlusChange: () {
                          _controller?.zoomIn();
                        }, onCutChange: () {
                          _controller?.zoomOut();
                        }),

                        // 底部站点弹框
                        _MarkInfoWidget(
                            show: showMarker,
                            markInfo: markInfo,
                            currentTheme: currentTheme,
                            onHideMartInfo: () {
                              _setShowMarker(false);
                            }),
                        //左侧总面板
                        _LeftInfoWidget(dataList: bannerList),
                      ],
                    ));
              },
            ),
          );
        });
  }
}

/// 自定义地图工具条
class _MapTools extends StatelessWidget {
  final onPlusChange;
  final onCutChange;
  _MapTools({
    Key key,
    this.onPlusChange,
    this.onCutChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: 5,
        bottom: 30,
        width: 50,
        height: 100,
        child: DecoratedColumn(
            // color: Colors.red,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            children: <Widget>[
              Container(
                  width: 50,
                  height: 50,
                  child: InkWell(child: Icon(Icons.add), onTap: onPlusChange),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromRGBO(0, 0, 0, 0.1))))),
              Container(
                  width: 50,
                  height: 50,
                  child: InkWell(child: Icon(Icons.remove), onTap: onCutChange))
            ]));
  }
}

// 左侧总面板
class _LeftInfoWidget extends StatelessWidget {
  final List<Map> dataList;
  _LeftInfoWidget({Key key, this.dataList}) : super(key: key);
  // 左侧每一个
  Widget buildLeftItem(BuildContext context, Map itemInfo) {
    return Container(child: Text(itemInfo['label']));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _list = new List();
    dataList.forEach((element) {
      _list.add(buildLeftItem(context, element));
    });
    return Positioned(
        left: 0,
        width: 50,
        height: 200,
        child: Container(
            height: 200,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: ListView(children: _list)));
  }
}

// 站点信息面板展示
class _MarkInfoWidget extends StatelessWidget {
  // 接收父级参数定义
  final bool show;
  final Map markInfo;
  final Map currentTheme;
  final onHideMartInfo;
  // 构造函数
  _MarkInfoWidget(
      {Key key,
      this.show,
      this.markInfo,
      this.currentTheme,
      this.onHideMartInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (show == true) {
      return Positioned(
          right: 0,
          left: 0,
          bottom: 0,
          height: 200,
          child: Container(
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(children: <Widget>[
                Container(
                    width: 375,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Color.fromRGBO(0, 0, 0, 0.1)))),
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                  child: InkWell(
                                      child:
                                          Icon(Icons.close, color: Colors.grey),
                                      onTap: () {
                                        onHideMartInfo();
                                      })),
                              Container(
                                  width: 70,
                                  height: 28,
                                  decoration: BoxDecoration(
                                      color: currentTheme['primaryColor'],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(14))),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image(
                                            width: 15,
                                            height: 15,
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                'asset/images/navigation.png')),
                                        Container(
                                            margin:
                                                EdgeInsets.fromLTRB(3, 0, 0, 0),
                                            child: InkWell(
                                              child: Text('导航',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              onTap: () {
                                                MapUtil.gotoAMap(
                                                    markInfo["longitude"],
                                                    markInfo["latitude"]);
                                              },
                                            ))
                                      ])),
                            ]))),
              ])));
    } else {
      return Container();
    }
  }
}

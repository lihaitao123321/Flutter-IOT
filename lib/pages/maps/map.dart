import 'dart:math';

import 'package:decorated_flutter/decorated_flutter.dart';
import 'package:flutter/material.dart';
import '../../config/index.dart';
import 'dart:convert';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';

class MapPage extends StatefulWidget {
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  get children => null;
  List<Marker> _markers = [];
  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    AmapController _controller;
    return Scaffold(
      backgroundColor: KColor.backgroundColor,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => {},
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            print(data);
          }
          return ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: Stack(
                alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
                children: <Widget>[
                  AmapView(
                    // 地图View创建完成回调
                    onMapCreated: (controller) async {
                      _controller = controller;
                      print('地图创建完成');
                      await _controller?.showMyLocation(MyLocationOption(
                          show: true, myLocationType: MyLocationType.Locate));
                      print('地图显示当前位置');
                      _controller?.setZoomByCenter(true);
                      print('地图设置中心点');
                      final latLng = await _controller?.getLocation();
                      print('当前经纬度: ${latLng.latitude}, ${latLng.longitude}');
                      _controller?.setCenterCoordinate(
                          LatLng(latLng.latitude, latLng.longitude));
                      final marker = await _controller?.addMarker(MarkerOption(
                        latLng: LatLng(latLng.latitude, latLng.longitude),
                        iconProvider: AssetImage('asset/images/mark_red.png'),
                        // widget: Image(
                        //     width: 10,
                        //     height: 10,
                        //     fit: BoxFit.cover,
                        //     image: AssetImage('asset/images/girl.jpeg')),
                        title: '北京',
                        snippet: '中国的首都北京，欢迎来到北京',
                      ));
                      _markers.add(marker);
                      // _controller?.requireAlwaysAuth();

                      // _controller?
                      //     .getLocation(
                      //         interval: Duration(seconds: 1),
                      //         timeout: Duration(seconds: 10))
                      //     .then((value) => print(value));
                    },
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
                  Positioned(
                      right: 5,
                      bottom: 30,
                      width: 50,
                      height: 100,
                      child: DecoratedColumn(
                          // color: Colors.red,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          children: <Widget>[
                            Container(
                                width: 50,
                                height: 50,
                                child: InkWell(
                                  child: Icon(Icons.add),
                                  onTap: () {
                                    _controller?.zoomIn();
                                  },
                                ),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Color.fromRGBO(
                                                0, 0, 0, 0.1))))),
                            Container(
                                width: 50,
                                height: 50,
                                child: InkWell(
                                  child: Icon(Icons.remove),
                                  onTap: () {
                                    _controller?.zoomOut();
                                  },
                                ))
                          ])),
                ],
              ));
        },
      ),
    );
  }
}

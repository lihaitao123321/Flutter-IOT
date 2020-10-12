import 'package:charge/generated/l10n.dart';
import 'package:charge/provide/lang_provide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:intl/intl.dart';

class LangPage extends StatefulWidget {
  _LangPageState createState() => _LangPageState();
}

class _LangPageState extends State {
  bool check = false;
  String _langValue = Intl.getCurrentLocale();

  /// `更改语言环境
  void _toggleLangChange(value, [model]) async {
    print(value);
    print(model);
    setState(() {
      _langValue = value;
    });
    if (model != null) {
      List list = value.split('_');
      String lang = value.split('_')[0];
      String country = '';
      if (list.length > 1) {
        country = value.split('_')[1];
      }
      print('修改前语言环境:${Intl.getCurrentLocale()}');
      await S.load(Locale(lang, country));
      Future.delayed(Duration(milliseconds: 1000), () {
        S.load(Locale(lang, country));
      });
      print('修改后语言环境:${Intl.getCurrentLocale()}');
      model.get<LangProvide>().changeLang(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('当前语言环境:${Intl.getCurrentLocale()}');
    ScreenUtil.init(context, width: 750, height: 1334);
    return ProvideMulti(
        requestedValues: [LangProvide],
        builder: (context, child, model) {
          List<Map> langSelectList = Provide.value<LangProvide>(context).langSelectList;
          List<Widget> langList = [];
          langSelectList.forEach((element) {
            langList.add(RadioListTile(
              value: element['value'],
              title: Text(element['label']),
              groupValue: _langValue,
              onChanged: (value) {
                _toggleLangChange(value, model);
              },
            ));
          });
          return Scaffold(
            appBar: AppBar(title: Text(S.of(context).lang_title)),
            body: Column(children: langList),
          );
        });
  }
}

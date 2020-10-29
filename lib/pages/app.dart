import 'package:charge/config/index.dart';
import 'package:charge/generated/l10n.dart';
import 'package:charge/provide/lang_provide.dart';
import 'package:charge/provide/theme_provide.dart';
import 'package:charge/tools/spUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provide/provide.dart';

import 'logins/login_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    //设置默认语言
    String lastLangValue = SpUtil.preferences.getString("lastLangValue");
    if (lastLangValue != null && lastLangValue.isNotEmpty) {
      S.load(Locale(lastLangValue));
    } else {
      S.load(Locale('zh'));
    }
    return ProvideMulti(
      requestedValues: [ThemeProvide, LangProvide],
      builder: (context, child, model) {
        String lastThemeValue = SpUtil.preferences.getString("lastThemeValue");
        String currentThemeValue = model.get<ThemeProvide>().currentThemeValue;
        if (currentThemeValue != lastThemeValue) {
          if (lastThemeValue != null) {
            model.get<ThemeProvide>().changeTheme(lastThemeValue);
          } else {
            model.get<ThemeProvide>().changeTheme('0');
          }
        }
        Map currentTheme = model.get<ThemeProvide>().currentTheme;

        return Container(
            child: MaterialApp(
                title: KString.mainTitle, //通用主标题
                debugShowCheckedModeBanner: true,
                //主题
                theme: ThemeData(
                  primaryColor: currentTheme['color'],
                ),
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate
                ],
                supportedLocales: S.delegate.supportedLocales,
                localeListResolutionCallback: (locales, supportedLocales) {
                  // print(locales);
                  return;
                },
                home: LoginPage()));
      },
    );
  }
}

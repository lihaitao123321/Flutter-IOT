import 'package:charge/provide/currnet_index_provide.dart';
import 'package:charge/provide/lang_provide.dart';
import 'package:charge/provide/theme_provide.dart';
import 'package:provide/provide.dart';

class IndexProvide {
  static Providers initProvide() {
    var currentIndexProvide = CurrentIndexProvide();
    var themeProvide = ThemeProvide();
    var langProvide = LangProvide();
    var providers = Providers();
    providers
      ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide))
      ..provide(Provider<ThemeProvide>.value(themeProvide))
      ..provide(Provider<LangProvide>.value(langProvide));
    return providers;
  }
}

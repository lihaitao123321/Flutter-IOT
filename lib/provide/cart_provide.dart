import 'package:charge/model/Shop.dart';
import 'package:charge/model/product.dart';
import 'package:flutter/material.dart';

class CartProvide with ChangeNotifier {
  List<Shop> shops = []; // 店铺列表
  List<Product> products = []; // 商品池
  addOneProduct(Product product) {
    Shop shop = new Shop();
    for (int i; i < shops.length; i++) {
      if (shops[i].id == product.shopId) {
        shop = shops[i];
      }
    }
    if (shop.id.isNotEmpty) {
      List<Product> productList = shop.products;
      bool b = productList.every((element) => element.id != product.id);
      if (b) {
        productList.add(product);
      }
    } else {
      shop.products.add(product);
      shops.add(shop);
    }
  }
}

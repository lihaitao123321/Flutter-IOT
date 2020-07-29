import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:flutter/services.dart' show rootBundle;
final parser = RSAKeyParser();
class KRsa {
  static Future<String> encryption(String password) async {
    String publicKeyString = await rootBundle.loadString('keys/publicKey.pem');
    RSAPublicKey publicKey = parser.parse(publicKeyString);
    final encrypter = Encrypter(RSA(publicKey: publicKey));
    return encrypter.encrypt(password).base64;
  }
}
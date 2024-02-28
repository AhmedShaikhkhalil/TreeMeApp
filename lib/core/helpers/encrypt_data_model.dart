import 'package:encrypt/encrypt.dart';

class EncryptData {
//for AES Algorithms

  static Encrypted? encrypted;
  static var decrypted;

  static encryptAES(plainText) {
    final key = Key.fromUtf8('my 32 length key................');
    print(AES(key).key.base16.toString());
    final iv = IV.fromLength(16);

    final encrypter = Encrypter(AES(key));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    final decrypted = encrypter.decrypt(encrypted, iv: iv);

    print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
    print(encrypted.base64);
    print(encrypter.decrypt64(encrypted.base64, iv: iv));
  }

  static decryptAES(encrypted) {
    final key = Key.fromUtf8('my 32 length key................');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    decrypted = encrypter.decrypt(encrypted!, iv: iv);
    print(decrypted);
  }
}

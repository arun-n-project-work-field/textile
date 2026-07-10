import 'dart:convert';

import 'package:crypto/crypto.dart';

class HashService {

  static String sha512(String value) {

    return sha512.convert(
      utf8.encode(value),
    ).toString();

  }

}
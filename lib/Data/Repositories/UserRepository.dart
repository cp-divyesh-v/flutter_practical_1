import 'package:flutter/services.dart';
import 'package:practical_1/Data/Models/User.dart';
import 'dart:convert';

import 'package:practical_1/Utils/JsonUtils.dart';

class UserRepository {
  static final shared = UserRepository();

  Future<User> getUser() async {
      final data = await readJson('assets/sample.json');
      return User.fromJson(data);
  }
}


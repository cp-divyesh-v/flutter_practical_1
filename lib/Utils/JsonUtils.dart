
import 'dart:convert';

import 'package:flutter/services.dart';

Future readJson(String filePath) async {
  final String response = await rootBundle.loadString(filePath);
  return await json.decode(response);
}

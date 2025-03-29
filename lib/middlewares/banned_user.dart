import 'dart:convert';
import 'package:activeitzone/helpers/auth_helper.dart';
import 'package:activeitzone/helpers/system_config.dart';
import 'package:activeitzone/middlewares/middleware.dart';
import 'package:activeitzone/screens/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:one_context/one_context.dart';

class BannedUser extends Middleware {
  @override
  bool next(http.Response response) {
    var jsonData = jsonDecode(response.body);
    if (jsonData.runtimeType!=List && jsonData.containsKey("result") && !jsonData['result']) {
      if (jsonData.containsKey("status") &&
          jsonData['status'] == "banned") {
        AuthHelper().clearUserData();
        if(SystemConfig.context !=null) {
          SystemConfig.context!.go('/');
        }

        return false;
      }
    }
    return true;
  }
}

import 'dart:convert';
import 'package:activeitzone/custom/device_info.dart';
import 'package:activeitzone/helpers/auth_helper.dart';
import 'package:activeitzone/middlewares/middleware.dart';
import 'package:activeitzone/my_theme.dart';
import 'package:activeitzone/screens/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:one_context/one_context.dart';

class MaintenanceMiddleware extends Middleware {
  @override
  bool next(http.Response response) {
    try {
      var jsonData = jsonDecode(response.body);
      if (jsonData.runtimeType!=List && jsonData['result']!=null && !jsonData['result']) {
        if (jsonData.containsKey("status") &&
            jsonData['status'] == "maintenance") {
          OneContext().addOverlay(
              overlayId: "maintenance",
              builder: (context) => Scaffold(
                    body: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      height: DeviceInfo(context).height!,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/maintenance.png",
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Text(
                              jsonData['message'],
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: MyTheme.font_grey),
                            )
                          ]),
                    ),
                  ));
          return false;
        }
      }
    } on Exception catch (e) {
      // TODO
    }
    return true;
  }
}

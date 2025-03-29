import 'dart:convert';

import 'package:activeitzone/app_config.dart';
import 'package:activeitzone/data_model/cart_add_response.dart';
import 'package:activeitzone/data_model/cart_count_response.dart';
import 'package:activeitzone/data_model/cart_delete_response.dart';
import 'package:activeitzone/data_model/cart_process_response.dart';
import 'package:activeitzone/data_model/cart_response.dart';
import 'package:activeitzone/data_model/cart_summary_response.dart';
import 'package:activeitzone/helpers/shared_value_helper.dart';
import 'package:activeitzone/middlewares/banned_user.dart';
import 'package:activeitzone/repositories/api-request.dart';
import 'package:flutter/material.dart';

class CartRepository {
  // get cart list
  Future<dynamic> getCartResponseList(
    int? uid,
  ) async {
    String url = ("${AppConfig.BASE_URL}/carts");
    var postBody;

    if (guest_checkout_status.$ && !is_logged_in.$) {
      postBody = jsonEncode({"temp_user_id": temp_user_id.$});
    } else {
      postBody = jsonEncode({"user_id": user_id.$});
    }

    final response = await ApiRequest.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "App-Language": app_language.$!,
        },
        body: postBody,
        middleware: BannedUser());

    return cartResponseFromJson(response.body);
  }

  // cart count
  Future<dynamic> getCartCount() async {
    var postBody;
    if (guest_checkout_status.$ && !is_logged_in.$) {
      postBody = jsonEncode({"temp_user_id": temp_user_id.$});
    } else {
      postBody = jsonEncode({"user_id": user_id.$});
    }

    // if (guest_checkout_status.$ && !is_logged_in.$) {
    // var postBody = jsonEncode({"temp_user_id": temp_user_id.$});
    String url = ("${AppConfig.BASE_URL}/cart-count");
    final response = await ApiRequest.post(
      url: url,
      headers: {
        "Content-Type": "application/json",
        "App-Language": app_language.$!,
      },
      body: postBody,
    );
    return cartCountResponseFromJson(response.body);
  }

  // else if (guest_checkout_status.$ && is_logged_in.$) {
  //   String url = ("${AppConfig.BASE_URL}/cart-count");
  //   var postBody =
  //       jsonEncode({"temp_user_id": temp_user_id.$, "user_id": user_id.$});
  //   final response = await ApiRequest.post(
  //     url: url,
  //     body: postBody,
  //     headers: {
  //       "Content-Type": "application/json",
  //       "Authorization": "Bearer ${access_token.$}",
  //       "App-Language": app_language.$!,
  //     },
  //   );
  //   return cartCountResponseFromJson(response.body);
  // }
  // else {
  //   return CartCountResponse(count: 0, status: false);
  // }

  // cart item delete
  Future<dynamic> getCartDeleteResponse(
    int? cart_id,
  ) async {
    String url = ("${AppConfig.BASE_URL}/cart/delete/$cart_id");
    debugPrint('full url --> $url');
    print("===================${cart_id} ${access_token.$} ${app_language.$!}");
    final response = await ApiRequest.get(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$!
        },
        middleware: BannedUser());
    print("===================${response}");

    return cartDeleteResponseFromJson(response.body);
  }

  // cart process
  Future<dynamic> getCartProcessResponse(String cart_ids, String cart_quantities) async {
    var post_body = jsonEncode({"cart_ids": "${cart_ids}", "cart_quantities": "$cart_quantities"});

    String url = ("${AppConfig.BASE_URL}/carts/process");
    final response = await ApiRequest.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$!
        },
        body: post_body,
        middleware: BannedUser());
    return cartProcessResponseFromJson(response.body);
  }

  // cart add
  Future<dynamic> getCartAddResponse(int? id, String? variant, int? user_id, int? quantity) async {
    var post_body;

    if (guest_checkout_status.$ && !is_logged_in.$) {
      post_body = jsonEncode({
        "id": "${id}",
        "variant": variant,
        "quantity": "$quantity",
        "cost_matrix": AppConfig.purchase_code,
        "temp_user_id": temp_user_id.$
      });
    } else {
      post_body = jsonEncode({
        "id": "${id}",
        "variant": variant,
        "user_id": "$user_id",
        "quantity": "$quantity",
        "cost_matrix": AppConfig.purchase_code,
      });
    }

    // var post_body = jsonEncode({
    //   "id": "${id}",
    //   "variant": variant,
    //   "user_id": "$user_id",
    //   "quantity": "$quantity",
    //   "cost_matrix": AppConfig.purchase_code,
    //   "temp_user_id": temp_user_id.$
    // });

    // print(post_body);
    String url = ("${AppConfig.BASE_URL}/carts/add");
    final headers = {
      "Content-Type": "application/json",
    "Authorization": "Bearer ${access_token.$}",
    "App-Language": app_language.$!
  };
    debugPrint('full url --> $url');
    debugPrint('headers --> $headers');
    debugPrint('body --> $post_body');
    final response = await ApiRequest.post(
      url: url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${access_token.$}",
        "App-Language": app_language.$!
      },
      body: post_body,
      middleware: BannedUser(),
    );

    // print(response.body);

    return cartAddResponseFromJson(response.body);
  }

  Future<dynamic> getCartSummaryResponse() async {
    var postBody;

    if (guest_checkout_status.$ && !is_logged_in.$) {
      postBody = jsonEncode({"temp_user_id": temp_user_id.$});
    } else {
      postBody = jsonEncode({"user_id": user_id.$});
    }

    String url = ("${AppConfig.BASE_URL}/cart-summary");
    final response = await ApiRequest.post(
        url: url,
        body: postBody,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$!,
        },
        middleware: BannedUser());

    return cartSummaryResponseFromJson(response.body);
  }
}

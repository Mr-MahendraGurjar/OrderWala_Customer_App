import 'package:activeitzone/app_config.dart';
import 'package:activeitzone/data_model/check_response_model.dart';
import 'package:activeitzone/middlewares/banned_user.dart';
import 'package:activeitzone/repositories/api-request.dart';
import 'dart:convert';
import 'package:activeitzone/data_model/simple_image_upload_response.dart';
import 'package:activeitzone/helpers/shared_value_helper.dart';


class FileRepository {
  Future<dynamic> getSimpleImageUploadResponse(
       String image,  String filename) async {
    var post_body = jsonEncode({"image": "${image}", "filename": "$filename"});

    String url=("${AppConfig.BASE_URL}/file/image-upload");
    final response = await ApiRequest.post(url:url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$!
        },
        body: post_body,middleware: BannedUser());

    return simpleImageUploadResponseFromJson(response.body);
  }
}

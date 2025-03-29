import 'package:activeitzone/app_config.dart';
import 'package:activeitzone/data_model/addons_response.dart';
import 'package:activeitzone/data_model/offline_wallet_recharge_response.dart';
import 'package:activeitzone/repositories/api-request.dart';

class AddonsRepository {
  Future<List<AddonsListResponse>> getAddonsListResponse() async {
    // $();
    String url = ('${AppConfig.BASE_URL}/addon-list');
    final response = await ApiRequest.get(url: url);
    return addonsListResponseFromJson(response.body);
  }
}

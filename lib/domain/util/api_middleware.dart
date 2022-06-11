import 'package:get/get.dart';
import 'package:weather_flutter/display/component/error_dialog.dart';
import 'package:weather_flutter/domain/util/constant.dart';

class ApiMiddleware extends GetConnect {
  Future<Response?> gets(String url, Map<String, String>? queries) async {
    Response? _res = await get(url, query: queries);
    if (_res.hasError) {
      showErrorDialog(textTitleApiError, _res.statusText ?? '');
    }
    return _res;
  }

  showErrorDialog(String title, String content) {
    Get.dialog(ErrorDialog(title: title, content: content));
  }
}

import 'package:http/http.dart';
import 'package:simple_weather/domain/util/constant.dart';
import 'package:simple_weather/domain/util/dialog_manager.dart';

Future<Response?> midCheck(Response? res) async {
  switch (res?.statusCode ?? -1) {
    case 200:
      break;

    default:
      await showMessageDialog(textTitleApiError, res?.body);
      break;
  }
  return res;
}

Future<dynamic> midError(e) async {
  return await showMessageDialog(textTitleApiError, '$e');
}

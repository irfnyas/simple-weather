import 'package:http/http.dart';
import 'package:simple_weather/domain/util/constant.dart';
import 'package:simple_weather/domain/util/dialog_manager.dart';

Future<Response?> getr(String url, {Map<String, String>? queries}) async {
  Response? res;
  try {
    final uri = Uri.parse(url).replace(queryParameters: queries);
    final req = await get(uri);
    res = await midCheck(req);
  } catch (e) {
    await midError(e);
  }

  return res;
}

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

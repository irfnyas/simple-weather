import 'package:http/http.dart';
import 'package:simple_weather/domain/util/constant.dart';
import 'package:simple_weather/domain/util/dialog_manager.dart';

class ApiMiddleware {
  static Response? check(Response? res) {
    switch (res?.statusCode ?? 0) {
      case 200:
        {
          break;
        }
      default:
        {
          DialogManager.showMessage(textTitleApiError, res?.body);
          break;
        }
    }
    return res;
  }

  static error(e) {
    DialogManager.showMessage(textTitleApiError, '$e');
  }
}

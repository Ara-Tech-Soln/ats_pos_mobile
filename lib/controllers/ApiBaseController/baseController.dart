import 'package:startupapplication/helpers/dialog_helper.dart';
import 'package:startupapplication/services/app_exceptions.dart';

class BaseController {
  void handelError(error) {
    if (error is BadRequestException) {
      //Show Dialog
      var message = error.message;

      DialogHelper.showErrorDialog(description: message!);
    } else if (error is FetchDataException) {
      var message = error.message;

      DialogHelper.showErrorDialog(description: message!);
    } else if (error is ApiNotResponding) {
      DialogHelper.showErrorDialog(
          description: 'Oops! it take longer to respond.');
    }
  }
}

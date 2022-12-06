import 'package:get/get.dart';
import 'package:startupapplication/controllers/ApiBaseController/apiRequestController.dart';
import 'package:startupapplication/controllers/getSharedData.dart';
import 'package:startupapplication/models/Accounts.dart';
import 'package:startupapplication/models/Card.dart';

class CardController extends GetxController {
  ApiRequestController controller = ApiRequestController();
  GetSharedContoller getSharedContoller = Get.find();
  var isLoading = false.obs;
  var selectedAccount;
  var selectedType;

  List<Card> cards = <Card>[];
  List<Accounts> accounts = <Accounts>[];

  //onInit
  @override
  void onInit() {
    getcards();
    getAccounts();
    super.onInit();
  }

  getcards() async {
    try {
      isLoading(true);
      await controller.getCards(token: getSharedContoller.token).then((value) {
        value != null ? cards = value : null;

        isLoading(false);
      });
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }

  getAccounts() async {
    try {
      isLoading(true);
      await controller
          .getAccounts(token: getSharedContoller.token)
          .then((value) {
        value != null
            ? {
                accounts = value,
                selectedAccount = accounts[0].id,
              }
            : null;

        isLoading(false);
      });
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}

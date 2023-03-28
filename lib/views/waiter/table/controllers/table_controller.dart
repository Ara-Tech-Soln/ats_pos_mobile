import 'package:get/get.dart';
import 'package:startupapplication/controllers/ApiBaseController/apiRequestController.dart';
import 'package:startupapplication/controllers/getSharedData.dart';
import 'package:startupapplication/helpers/functions.dart';
import 'package:startupapplication/models/Table.dart';

class TableController extends GetxController {
  ApiRequestController controller = ApiRequestController();
  GetSharedContoller getSharedContoller = Get.find();

  var isLoading = true.obs;
  List<Table?> tables = <Table>[];

  getTables() async {
    try {
      isLoading(true);
      await controller.getTables(token: getSharedContoller.token).then((value) {
        value != null ? tables.assignAll(value) : null;
        isLoading(false);
      });
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }

  swapTable(table_id, new_table_id) async {
    try {
      isLoading(true);
      await controller
          .swapTable(
              table_id: table_id,
              new_table_id: new_table_id,
              token: getSharedContoller.token)
          .then((value) {
        value != null ? tables.assignAll(value) : null;
        isLoading(false);
      });
    } catch (e) {
      print(e);
    } finally {
      HelperFunctions.showToast("Table Swapped Successfully");
      isLoading(false);
    }
  }
 
}

import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:startupapplication/controllers/ApiBaseController/apiRequestController.dart';
import 'package:startupapplication/controllers/getSharedData.dart';
import 'package:startupapplication/helpers/functions.dart';
import 'package:startupapplication/models/Card.dart';

class QrController extends GetxController {
  ApiRequestController controller = ApiRequestController();
  GetSharedContoller getSharedContoller = Get.find();

  String scanBarcode = 'Unknown';

  var isClicked = false.obs;
  var isLoading = false.obs;
  var cardDetail = Card();

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      scanBarcode = barcodeScanRes;
      print(scanBarcode);
      await getCardDetail();
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    } catch (e) {
      scanBarcode = 'Unknown';
      print(e);
    }
  }

  Future<void> scanQrBalance() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      scanBarcode = barcodeScanRes;
      print(scanBarcode);
      await getCardDetail();
      checkBalance();
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    } catch (e) {
      scanBarcode = 'Unknown';
      print(e);
    }
  }

  getCardDetail() async {
    try {
      isLoading(true);
      var response = await controller.getCardDetail(
        token: getSharedContoller.token,
        name: scanBarcode,
      );
      print(response);
      if (response != null) {
        cardDetail = response;
      } else {
        print('error');
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }

  checkBalance() async {
    try {
      if (cardDetail.balance == 0) {
        HelperFunctions.showToast('Card Balance is 0');
      } else {
        HelperFunctions.showToast('Card Balance is ${cardDetail.balance}');
      }
    } catch (e) {
      print(e);
    }
  }
}

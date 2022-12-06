import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:startupapplication/controllers/ApiBaseController/apiRequestController.dart';
import 'package:startupapplication/controllers/getSharedData.dart';
import 'package:startupapplication/helpers/functions.dart';
import 'package:startupapplication/models/Card.dart';
import 'package:startupapplication/routes/app_pages.dart';
import 'package:startupapplication/views/admin/card/controllers/card_controller.dart';

class QrController extends GetxController {
  ApiRequestController controller = ApiRequestController();
  GetSharedContoller getSharedContoller = Get.find();
  CardController cardController = Get.find();

  String scanBarcode = 'Unknown';
  var tableId, tableName;
  var cardName;
  var cardNumber;
  var data;

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
      var a = barcodeScanRes.split("ADR:").last;
      cardName = a.split(";TEL:").first;
      print("CardID: " + cardName);
      var b = barcodeScanRes.split(";ADR:").first;
      cardNumber = b.split("MECARD:N:").last;
      print("Card Number: " + cardNumber);
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
      var a = barcodeScanRes.split("ADR:").last;
      cardName = a.split(";TEL:").first;
      print("CardID: " + cardName);
      var b = barcodeScanRes.split(";ADR:").first;
      cardNumber = b.split("MECARD:N:").last;
      print("Card Number: " + cardNumber);
      await getCardBalance();
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
        name: cardName.toString(),
      );
      print(response);
      if (response != null) {
        cardDetail = response;
        Get.toNamed(Routes.MENU, arguments: [tableId, tableName]);
      } else {
        print('error');
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }

  getCardBalance() async {
    try {
      isLoading(true);
      var response = await controller.getCardDetail(
        token: getSharedContoller.token,
        name: cardName.toString(),
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

  Future<void> addQr() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      scanBarcode = barcodeScanRes;
      print(scanBarcode);
      var a = barcodeScanRes.split("ADR:").last;
      cardName = a.split(";TEL:").first;
      print("CardID: " + cardName);
      var b = barcodeScanRes.split(";ADR:").first;
      cardNumber = b.split("MECARD:N:").last;
      print("Card Number: " + cardNumber);
      await addCard();
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    } catch (e) {
      scanBarcode = 'Unknown';
      print(e);
    }
  }

  addCard() async {
    try {
      var response = await controller.addCard(
        token: getSharedContoller.token,
        name: cardName.toString(),
        address: cardNumber.toString(),
      );
      print(response);
      if (response != null) {
        await cardController.getcards();
        HelperFunctions.showToast('Card Added Successfully');
      } else {
        print('error');
        HelperFunctions.showToast('Something went wrong');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> SearchQr() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      scanBarcode = barcodeScanRes;
      print(scanBarcode);
      var a = barcodeScanRes.split("ADR:").last;
      cardName = a.split(";TEL:").first;
      print("CardID: " + cardName);
      var b = barcodeScanRes.split(";ADR:").first;
      cardNumber = b.split("MECARD:N:").last;
      print("Card Number: " + cardNumber);
      await searchCard();
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    } catch (e) {
      scanBarcode = 'Unknown';
      print(e);
    }
  }

  searchCard() async {
    try {
      isLoading(true);
      var response = await controller.getCardDetail(
        token: getSharedContoller.token,
        name: cardName.toString(),
      );
      print(response);
      if (response != null) {
        cardDetail = response;
        Get.toNamed(Routes.CARD_DETAILS, arguments: cardDetail);
      } else {
        print('error');
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}

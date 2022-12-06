import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:startupapplication/controllers/qrController.dart';
import 'package:startupapplication/helpers/functions.dart';
import 'package:startupapplication/routes/app_pages.dart';
import 'package:startupapplication/views/loadingWidget.dart';

import '../controllers/card_controller.dart';

class CardView extends StatefulWidget {
  const CardView({Key? key}) : super(key: key);

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  CardController cardController = Get.find();
  QrController qrController = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          backgroundColor: Theme.of(context).backgroundColor,
          title: const Text('Available Cards'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.qr_code_rounded),
              onPressed: () {
                qrController.SearchQr();
              },
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                cardController.getcards();
              },
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await HelperFunctions.clearAllValue();
                Get.offNamed(Routes.LOGIN);
              },
            ),
          ],
        ),
        body: Obx(() => cardController.isLoading.value
            ? LoadingWidget()
            : RefreshIndicator(
                onRefresh: () async {
                  cardController.getcards();
                },
                child: ListView.builder(
                    itemCount: cardController.cards.length,
                    itemBuilder: (context, index) {
                      var card = cardController.cards[index];
                      //order by balance desc
                      cardController.cards
                          .sort((a, b) => b.balance!.compareTo(a.balance!));
                      return Card(
                        child: ListTile(
                            tileColor: card.balance! > 0
                                ? Colors.green[900]
                                : Colors.red,
                            leading: QrImage(
                              foregroundColor: Colors.white,
                              data: "MECARD:N:" +
                                  card.address! +
                                  card.name! +
                                  ";ADR:" +
                                  card.name! +
                                  ";TEL:;EMAIL:;;",
                              version: QrVersions.auto,
                              size: 50.0,
                            ),
                            title: Text(
                              card.name!.toUpperCase(),
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white),
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  card.address!,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic),
                                ),
                                Text(
                                  'Rs. ' + card.balance.toString(),
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.yellowAccent),
                                )
                              ],
                            ),
                            trailing: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.balance_rounded,
                                  size: 30,
                                ),
                                onPressed: () {
                                  Get.toNamed(Routes.CARD_DETAILS,
                                      arguments: card);
                                },
                              ),
                            )),
                      );
                    }),
              )),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            qrController.addQr();
          },
          icon: const Icon(Icons.qr_code_scanner_sharp),
          label: const Text('Add Card'),
          backgroundColor: Theme.of(context).backgroundColor,
        ),
      ),
    );
  }
}

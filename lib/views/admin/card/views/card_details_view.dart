import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:startupapplication/helpers/functions.dart';
import 'package:startupapplication/views/admin/card/controllers/card_controller.dart';

class CardDetailsView extends StatefulWidget {
  const CardDetailsView({Key? key}) : super(key: key);

  @override
  State<CardDetailsView> createState() => _CardDetailsViewState();
}

class _CardDetailsViewState extends State<CardDetailsView> {
  var card = Get.arguments;
  CardController cardController = Get.find();
  String? selectedType;
  String? selectedAccount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(card.name!),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.5,
              child: QrImage(
                data: "MECARD:N:" +
                    card.address! +
                    card.name! +
                    ";ADR:" +
                    card.name! +
                    ";TEL:;EMAIL:;;",
                version: QrVersions.auto,
                size: MediaQuery.of(context).size.width * 0.5,
              ),
            ),
            Text(
              'Current Balance: Rs. ' + card.balance.toString() + "/-",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Material(
                elevation: 2.0,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: TextFormField(
                  onChanged: (String value) {
                    setState(() {
                      print(value);
                    });
                  },
                  keyboardType: TextInputType.number,
                  validator: (amount) {
                    if (amount!.isEmpty) {
                      return "Please enter amount";
                    }
                    return null;
                  },
                  cursorColor: Theme.of(context).backgroundColor,
                  decoration: InputDecoration(
                      hintText: "Enter Amount",
                      prefixIcon: Material(
                        elevation: 0,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Icon(
                          Icons.attach_money_outlined,
                          color: Theme.of(context).backgroundColor,
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select Account",
                    style: TextStyle(color: Colors.black54),
                  ),
                  Material(
                      elevation: 2.0,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      child: DropdownButton(
                        hint: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Select Account",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                        isExpanded: true,
                        items: cardController.accounts.map((value) {
                          return DropdownMenuItem(
                              value: value.id,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text(value.name!),
                              ));
                        }).toList(),
                        value: selectedAccount ??
                            cardController.accounts[0].id.toString(),
                        onChanged: (value) {
                          setState(() {
                            selectedAccount = value.toString();
                            cardController.selectedAccount = value.toString();
                          });
                        },
                      )),
                ],
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select Deposit/Withdraw",
                    style: TextStyle(color: Colors.black54),
                  ),
                  Material(
                      elevation: 2.0,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      child: DropdownButton<String>(
                        hint: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Select Deposit/Withdraw",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                        isExpanded: true,
                        items:
                            <String>['Deposit', 'Withdraw'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(value),
                            ),
                          );
                        }).toList(),
                        value: selectedType ?? 'Deposit',
                        onChanged: (value) {
                          setState(() {
                            selectedType = value.toString();
                            cardController.selectedType = value.toString();
                          });
                        },
                      )),
                ],
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Material(
                elevation: 2.0,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: TextFormField(
                  onChanged: (String value) {
                    setState(() {
                      print(value);
                    });
                  },
                  maxLength: 4,
                  keyboardType: TextInputType.text,
                  cursorColor: Theme.of(context).backgroundColor,
                  decoration: InputDecoration(
                      hintText: "Enter notes",
                      prefixIcon: Material(
                        elevation: 0,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Icon(
                          Icons.note_add,
                          color: Theme.of(context).backgroundColor,
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              decoration: HelperFunctions.gradientBtnDecoration,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.9,
              height: 50,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Add Transaction",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupapplication/controllers/wecomeController.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  WelcomeContoller welcomeController = Get.put(WelcomeContoller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome To ATS POS'),
        actions: [
          //button to exit the app
          IconButton(
            onPressed: () {
              //exit the full app
              exit(0);
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //image
            Image.asset(
              'images/logo.png',
              height: 200,
              width: 200,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'http://192.168.100.1',
                  hintStyle: TextStyle(color: Colors.grey),
                  label: Text(
                    'Enter Your IP Address Or Url',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                onChanged: (value) {
                  welcomeController.ipUrl = value;
                },
              ),
            ),
            //button to save the ip address
            ElevatedButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.focused)) return Colors.red;
                  return null; // Defer to the widget's default.
                }),
              ),
              onPressed: () async {
                welcomeController.setIp();
              },
              child: Obx(() => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: welcomeController.isLoading.value
                        ? CircularProgressIndicator()
                        : Text(
                            'Proceed',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

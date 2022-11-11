import 'package:flutter/material.dart';
import 'package:startupapplication/helpers/themeService.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StartUp App'),
        actions: [
          IconButton(
            onPressed: (() => ThemeService().switchTheme()),
            icon: Icon(
              Icons.brightness_6,
            ),
          ),
        ],
      ),
      body: Center(
        child: Text('You can start any application modifing this'),
      ),
    );
  }
}

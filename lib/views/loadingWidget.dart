import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/logo.png',
                  width: 100, height: 100, fit: BoxFit.cover),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: LinearProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                  color: Theme.of(context).backgroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

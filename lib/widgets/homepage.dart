import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: Text("Go To Second Screen"),
                onPressed: () {
                  Navigator.of(context).popAndPushNamed("/second");
                },
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Go To Second Screen"),
          onPressed: () {
            Navigator.of(context).popAndPushNamed("/second");
            // Navigator.of(context).pushReplacementNamed("/second");
          },
        ),
      ),
    );
  }
}

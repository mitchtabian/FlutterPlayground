import 'package:firstflutterapp/styles.dart';
import 'package:flutter/material.dart';

class NotFoundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("404 Not Found!"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.all(DefaultPadding),
          child: Text(
            "Whoops, something went wrong. We couldn't find that page.",
            style: TextStyle(
                color: Colors.black,
                fontSize: 24
            ),
          ),
        ),
      ),
    );
  }
}

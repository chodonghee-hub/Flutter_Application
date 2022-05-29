import 'package:flutter/material.dart';

class GetImage extends StatefulWidget {
  @override
  State<GetImage> createState() => _GetImage();
}

class _GetImage extends State<GetImage> {
  static const routeName = '/getimage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TextButton(
                onPressed: () {},
                child: Text('Camera')),
            TextButton(
              onPressed: () {},
              child: Text('Gallery'),
            ),
          ],
        ),
      ),
    );
  }
}
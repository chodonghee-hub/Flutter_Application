import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({Key? key, required this.onPressed, required this.icon, required Color color}) : super(key: key);

  final VoidCallback onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: Colors.white70,
      elevation: 4.0,
      child: IconButton(onPressed: onPressed, icon: icon, color:Color.fromRGBO(110, 110, 140, 1),),
    );
  }
}

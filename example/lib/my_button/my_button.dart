import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  // MyButton(_Image, _Text, _Color, _Radius, _OnPressed){
  //   this.image = _Image;
  //   this.text = _Text;
  //   this.color = _Color;
  //   this.radius = _Radius;
  //   this.onPressed = _OnPressed;
  // }
  MyButton({this.image, this.text, this.color, this.radius, this.onPressed});

  var image;
  var text;
  var color;
  var radius;
  var onPressed;

  @override
  Widget build(BuildContext context) {

    return ButtonTheme(
      height: 50.0,
      child: ElevatedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            image,
            text,
            Opacity(
              opacity: 0.0,
              child: Image.asset('image/glogo.png'),
            ),
          ],
        ),
        // RaisedButton → ElevatedButton 변경 후 color 속성 값 변경
        // color: Colors.white,
        style: ElevatedButton.styleFrom(primary: color),
        onPressed: onPressed,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../my_button/my_button.dart';

class LogInRefac extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(102, 102, 153, 1),
      appBar: AppBar(
        title: Text("T4 Calendar",
          style: TextStyle(
            fontFamily: 'Noto_Serif_KR',
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color.fromRGBO(102, 102, 153, 1),
      ),
      // appBar: AppBar(
      //   backgroundColor: Colors.blue,
      //   title: Text(
      //     'Sign In',
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   centerTitle: true,
      //   elevation: 0.2,
      // ),
      body: _buildButton(),
    );
  }

  // Prvate build options
  Widget _buildButton() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MyButton(
            image: Image.asset('image/glogo.png'),
            text: Text(
              'Login with Google',
              style: TextStyle(color: Colors.black, fontSize: 15.0),
            ),
            color: Colors.white,
            radius: 4.0,
            onPressed: (){},
          ),

          SizedBox(
            height: 10.0,
          ),

          MyButton(
            image: Image.asset('image/flogo.png'),
            text: Text(
              'Login with Facebook',
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            ),
            color: Color(0xFF334D92),
            radius: 4.0,
            onPressed: (){},
          ),

          SizedBox(
            height: 10.0,
          ),

          MyButton(
            image: Icon(
              Icons.mail,
              color: Colors.white,
            ),
            text: Text(
              'Login with Email',
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            ),
            color: Colors.green,
            radius: 4.0,
            onPressed: (){},
          ),
        ],
      ),
    );
  }
}
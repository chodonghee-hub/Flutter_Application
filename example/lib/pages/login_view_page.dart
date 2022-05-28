import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
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
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: (){},
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.menu),
              onPressed: (){}
          )
        ],
      ),

      body: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 50)),
          Center(
            child: Image(
              image: AssetImage('image/t1.gif'),
              width: 170,
              height: 190,
            ),
          ),
          Form(
              child: Theme(
                data: ThemeData(
                  primaryColor: Colors.teal,
                  inputDecorationTheme: InputDecorationTheme(
                    labelStyle: TextStyle(
                      color: Colors.teal,
                      fontSize: 15
                    )
                  )
                ),
                child: Container(
                  padding: EdgeInsets.all(40),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Enter "dice"'
                        ),
                        keyboardType: TextInputType.emailAddress,
                      )
                    ],
                  )
                )
              )
          )
        ],
      )
    );
  }
}

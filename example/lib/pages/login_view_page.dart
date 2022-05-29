import 'package:flutter/material.dart';
import '../pages/mobile/mobile_home_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(102, 102, 153, 1),
      appBar: AppBar(
        title: Text("T4 Calendar",
          style: TextStyle(
            fontFamily: 'Noto_Sans_KR',
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

      body: Builder(
        builder: (context){
          return GestureDetector(
            onTap : (){
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Column(
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
                                      fontSize: 20
                                  )
                              )
                          ),
                          child: Container(
                              padding: EdgeInsets.all(40),
                              child: Column(
                                children: <Widget>[
                                  TextField(
                                    autofocus: true,
                                    controller: controller,
                                    decoration: InputDecoration(
                                        labelText: 'Enter "dice"'
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  TextField(
                                    autofocus: true,
                                    controller: controller2,
                                    decoration: InputDecoration(
                                        labelText: 'Enter Password'
                                    ),
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                  ),
                                  SizedBox(height: 40),
                                  ButtonTheme(
                                      minWidth: 100,
                                      height: 50,
                                      shape: RoundedRectangleBorder( //버튼을 둥글게 처리
                                          borderRadius: BorderRadius.circular(100)
                                      ),
                                      child: ElevatedButton(
                                          child: Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                            size: 35,
                                          ),
                                          onPressed: (){

                                            if (controller.text == 'dice' && controller2.text == '1234'){
                                              // ################ FireBase 로그인 유저 정보 출력 ###########
                                              showToastMessage("login success");
                                              Navigator.push(context,
                                                  MaterialPageRoute(builder: (BuildContext context) => MobileHomePage()));
                                            }else if(controller.text == 'dice' && controller2.text != '1234'){
                                              showSnackBar(context);
                                            }else if(controller.text != 'dice' && controller2.text == '1234'){
                                              showSnackBar2(context);
                                            }else{

                                            }
                                          }
                                      )
                                  ),
                                ],
                              )
                          )
                      )
                  )
                ],
              ),
            ),
          );
        },
      )
    );
  }
}

void showSnackBar(BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content:
    Text('로그인 정보를 다시 확인하세요',
    textAlign: TextAlign.center,),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.blue,
    )
  );
}

void showSnackBar2(BuildContext context){
  // Scaffold.of(context).showSnackBar(snackbar)
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content:
      Text('비밀번호가 일치하지 않습니다',
        textAlign: TextAlign.center,),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.blue,
      )
  );
}

void showSnackBar3(BuildContext context){
  // Scaffold.of(context).showSnackBar(snackbar)
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content:
      Text('아이디를 확인 해주세요',
        textAlign: TextAlign.center,),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.blue,
      )
  );
}

void showToastMessage(String message) {
  Fluttertoast.showToast(msg: message,
  backgroundColor:Colors.grey,
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.BOTTOM
  );
}
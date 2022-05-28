import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './memo/screens/edit.dart';
import './memo/screens/view.dart';
import './memo/database/db.dart';
import './memo/database/memo.dart';

String deleteId = ''; //전역 변수 설정 -> 삭제할 때 memo.id를 못 불러온다.

class MemoEvent extends StatefulWidget {
  @override
  State<MemoEvent> createState() => _MemoEventState();
}

class _MemoEventState extends State<MemoEvent> {

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: TextField(controller: controller,),
        actions: <Widget>[
          /*
          IconButton(
            onPressed: () {
              final name = controller.text;
              createUser(name: name);
            },
            icon: const Icon(Icons.refresh),
          ),
           */
        ],
      ),
      body: InkWell(
        onDoubleTap: () {
          setState(() {});
        },
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: 5, top: 10, bottom: 20),
                child: Container(
                  /*
                  child: Text('메모',
                      style: TextStyle(fontSize: 36, color: Colors.blue)),
                  alignment: Alignment.centerLeft,
                   */
                )),
            Expanded(child: memoBuilder(context))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => EditPage()));
        },
        tooltip: '메모 추가를 위해 클릭하시오.',
        label: Text('메모 추가'),
        icon: Icon(Icons.add),
      ),
    );
  }

  /*
  //파이어베이스 유저 이름
  Future createUser ({required String name}) async{
    final docUser = FirebaseFirestore.instance.collection('user1').doc('my-id');

    final json = {
      'title' : memo.title,
      'age' : 21,
      'birthday' : DateTime(2022, 5, 28),
    };
    await docUser.set(json);
  }
   */

  //메모 불러오기
  Future <List<Memo>> loadMemo() async {
    DBHelper sd = DBHelper();
    return await sd.memos();
  }

  //메모 삭제
  Future<void> deleteMemo(String id) async {
    DBHelper sd = DBHelper();
    return await sd.deleteMemo(id);
  }

  void showAlertDialog(BuildContext context) async {
    String result = await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('삭제 경고'),
          content: Text("정말 삭제하시겠습니까?\n삭제된 메모는 복구되지 않습니다."),
          actions: <Widget>[
            TextButton(
              child: Text('삭제'),
              onPressed: () {
                Navigator.pop(context, "삭제");
                setState(() {
                  deleteMemo(deleteId);
                });
                deleteId = '';
              },
            ),
            TextButton(
              child: Text('취소'),
              onPressed: () {
                deleteId = '';
                Navigator.pop(context, "취소");
              },
            ),
          ],
        );
      },
    );
  }

  Widget memoBuilder(BuildContext parentContext) {
    return FutureBuilder(
      builder: (context, Snap) {
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: (Snap.data as List).length,
          itemBuilder: (context, index) {
            Memo memo = (Snap.data as List)[index];


            //메모 연동
            Future createUser ({required String name}) async{
              final docUser = FirebaseFirestore.instance.collection('user1').doc('my-id');

              final json = {
                'title' : memo.title,
                'text' : memo.text,
                'createTime' : memo.createTime,
                'editTime' : memo.editTime,
              };

              await docUser.set(json);
            }


            return InkWell(

              onDoubleTap: (){
                createUser(name: 'user1');
              },

              /*
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => ViewPage(id: memo.id)));
                //id 넘겨주기 statless widget pass data 검색
              },
               */
              onLongPress: () {
                setState(() {
                  deleteId = memo.id;
                  showAlertDialog(parentContext);
                });
              }, //길게 누르면 삭제
              child: Container(
                height: 500,
                alignment: Alignment.center,
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: NetworkImage(
                        'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                    fit: BoxFit.cover,
                  ),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.blueGrey,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: <Widget>[
                    /*
                      Scaffold(
                        body: Image.network('https://picsum.photos/250?image=9'),
                      ),
                       */
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          memo.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          memo.text,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            backgroundColor: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            "최종 수정 : " + memo.editTime.split('.')[0],
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              backgroundColor: Colors.white,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ]),
                    // Widge t to display the list of project
                  ],
                ),
              ),
            );
          },
        );
      },
      future: loadMemo(),
    );
  }
}
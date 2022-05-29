import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './edit.dart';
import './view.dart';
import './../database/db.dart';
import './../database/memo.dart';

String deleteId = '';

//업데이트하고 내려받은 메모

class MemoUpdate extends StatefulWidget {
  @override
  State<MemoUpdate> createState() => _MemoUpdate();
}

class _MemoUpdate extends State<MemoUpdate> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<List<User>>(
          stream: readUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final users = snapshot.data!;

              return ListView(
                children: users.map(buildUser).toList(),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      );

  Widget buildUser(User user) => ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            child: Text('user1'[0]),
          ),
        ],
      ),
      //add
      //CircleAvatar(child: Text('${user.id[0]}'),), -> id 사용하고 싶을 때. 근데 user1이 아니고 저장된 id임
      title: Text(
        '\n' + user.title + '\n',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
      ),
      subtitle: Text(
        user.text + '\n\n\n' + user.editTime.substring(0, 16),
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.delete,
              size: 20.0,
              color: Colors.black,
            ),
            onPressed: () {
              deleteId = user.id;
              showAlertDialog(context);
              /*
              final docUser =
                  FirebaseFirestore.instance.collection('user1').doc(user.id);

              docUser.delete();
               */
            },
          ),
        ],
      ));

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection('user1')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());

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
          content: Text("이미 업로드한 일기를 삭제하시겠습니까?"),
          actions: <Widget>[
            TextButton(
              child: Text('삭제'),
              onPressed: () {
                Navigator.pop(context, "삭제");
                final docUser =
                    FirebaseFirestore.instance.collection('user1').doc(deleteId);

                docUser.delete();
              },
            ),
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.pop(context, "취소");
              },),],
        );},
    );}

}

//서버에서 받아오는 정보 읽기

class User {
  String id;
  final String title;
  final String text;
  final String editTime;

  User({
    this.id = '',
    required this.title,
    required this.text,
    required this.editTime,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'text': text,
        'editTime': editTime,
      };

  static User fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        title: json['title'],
        text: json['text'],
        editTime: json['editTime'],
      );
}

Future<void> deleteMemo(String id) async {
  DBHelper sd = DBHelper();
  return await sd.deleteMemo(id);
}
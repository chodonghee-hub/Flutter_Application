import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

import '../database/db.dart';
import '../database/memo.dart';

class EditPage extends StatelessWidget {

  String title = '';
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: saveDB,
          ),
        ],
        title: Text('메모 추가'),
      ),
      body:
      Padding(
        padding: EdgeInsets.all(10),
        child: Column(
            children: <Widget>[
               TextField(
                //obscureText: true,
                 onChanged: (String title){ this.title = title; },
                 //제목 입력하거나 바뀌면 title로 넘어간다. 맨 위의 title에 저장됨.
                 keyboardType: TextInputType.multiline,
                 maxLines: 2,
                 style: TextStyle(
                   fontSize: 15,
                 ),
                decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '제목',
                hintText: '제목을 입력하시오.',
                ),),
              Padding(padding: EdgeInsets.all(10)),
              TextField(
                //obscureText: true,
                onChanged: (String text){ this.text = text; },
                keyboardType: TextInputType.multiline,
                maxLines: 8,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '내용',
                  hintText: '내용을 입력하시오.',
                ),),
        ],),
      ),);
}
  Future<void> saveDB() async{

    DBHelper sd = DBHelper();

    var fido = Memo(
      id: Str2Sha256(DateTime.now().toString()), //현재 날짜를 해쉬값으로 만들어서 id로 사용
      title: this.title,
      text: this.text,
      createTime: DateTime.now().toString(),
      editTime: DateTime.now().toString(),
    );

    await sd.insertMemo(fido);

    print(await sd.memos()); //데이터가 잘 저장됐는지 확인용, 필요는 없음
  }

  String Str2Sha256(String text) {
    var key = utf8.encode('p@ssw0rd');
    var bytes = utf8.encode(text);

    var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
    var digest = hmacSha256.convert(bytes);

    return digest.toString();
  }
}
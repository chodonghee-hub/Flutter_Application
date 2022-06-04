import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

import '../database/db.dart';
import '../database/memo.dart';

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class EditPage extends StatefulWidget {
  @override
  State<EditPage> createState() => _EditPage();
}

class _EditPage extends State<EditPage> {

  String title = '';
  String text = '';
  //List<XFile>? imageFileList;

  final ImagePicker imagePicker = ImagePicker();

  List<XFile>? imageFileList = [];

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        actions: <Widget>[
          /*
          IconButton(
            icon: const Icon(Icons.camera_alt),
            color: Colors.white,
            onPressed: () {
              selectImages();
            },
          ),
           */
          IconButton(
            icon: const Icon(Icons.save),
            color: Colors.white,
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      itemCount: imageFileList!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (BuildContext context, int index) {
                        return Image.file(File(imageFileList![index].path),
                            fit: BoxFit.cover);
                      }),
                ),
              ),
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
      //image: this.imageFileList,
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
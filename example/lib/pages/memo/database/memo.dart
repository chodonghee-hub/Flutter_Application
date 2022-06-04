import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Memo {
  final String id;
  final String title;
  final String text;
  final String createTime;
  final String editTime;
  //final List<XFile>? image;

  Memo(
      //{required this.id, required this.title, required this.text, required this.createTime, required this.editTime, required this.image});
      {required this.id, required this.title, required this.text, required this.createTime, required this.editTime});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'text': text,
      'createTime': createTime,
      'editTime': editTime,
      //'image': image,
    };
  }

  @override
  String toString() {
    //return 'Memo{id: $id, title:$title, text: $text, createTime: $createTime, editTime: $editTime, image: $image}';
    return 'Memo{id: $id, title:$title, text: $text, createTime: $createTime, editTime: $editTime}';
  }

}
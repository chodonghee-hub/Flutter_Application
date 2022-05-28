import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './../database/memo.dart';
import './../database/db.dart';

//null 값이 반환되어 일단 보류

class ViewPage extends StatelessWidget {
  ViewPage({required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete),
            ),
            /*
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {},
            ),
             */
          ],
          title: Text('메모 추가'),
        ),
        body: Padding(padding: EdgeInsets.all(10), child: Loadbuilder()));
  }

  Future<List<Memo>> loadMemo(var id) async {
    DBHelper sd = DBHelper();
    return await sd.findMemo(id);
  }

  Loadbuilder() {
    return FutureBuilder<List<Memo>>(
      future: loadMemo(id),
      builder: (BuildContext context, AsyncSnapshot<List<Memo>> snapshot) {
          Memo memo = snapshot.data![0];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container( //오버플로우 대처
                 child : SingleChildScrollView(
                   child: Text(memo.title),),
              ),
              Text(memo.createTime),
              Text(memo.editTime),
              Padding(padding: EdgeInsets.all(10)),
              Text(memo.text),
            ],
          );
        }
    );
  }
}
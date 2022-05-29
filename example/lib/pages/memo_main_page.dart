import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'memo/screens/memo_event_page.dart';
import 'memo/screens/update.dart';

//메모 메인 페이지 (탭 2개)
class MemoMain extends StatefulWidget {
  const MemoMain({
    Key? key,
  }) : super(key: key);

  @override
  _MemoMainState createState() => _MemoMainState();
}

class _MemoMainState extends State<MemoMain> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            '일기',
            style: TextStyle(
              fontFamily: 'Noto_Serif_KR',
              fontSize: 20.0,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color.fromRGBO(102, 102, 153, 1),
                Color.fromRGBO(110, 110, 140, 1),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.bottomRight,
            )),
          ),
          bottom: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white24,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: Colors.white10),
              //TabBar style
              tabs: [
                Tab(
                  icon: Icon(Icons.note_outlined),
                  text: '쓴 일기',
                ),
                Tab(
                  icon: Icon(Icons.download_rounded),
                  text: '업로드한 일기',
                ),
              ]),
        ),
        body: TabBarView(
          children: [
            Center(child: MemoEvent()),
            Center(child: MemoUpdate()),
          ],
        ),
      ),
    );
  }
}

import 'package:calendar_view/calendar_view.dart';
import 'package:example/weather_screen/weather_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../extension.dart';
import '../model/event.dart';
import '../widgets/day_view_widget.dart';
import '../widgets/month_view_widget.dart';
import '../widgets/week_view_widget.dart';
import 'create_event_page.dart';
import '../action_button.dart';
import '../expandable_fab.dart';
import 'memo_main_page.dart';
import 'remove_event_page.dart';
import '../../login_app/login_refactor.dart';

class MonthViewPageDemo extends StatefulWidget {
  const MonthViewPageDemo({
    Key? key,
  }) : super(key: key);

  @override
  _MonthViewPageDemoState createState() => _MonthViewPageDemoState();
}

class _MonthViewPageDemoState extends State<MonthViewPageDemo> {

  // ################## 로그인 유저 ####################
  late FirebaseAuth logined_user = FirebaseAuth.instance;
  late String user_name = logined_user.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('T4 Calendar Demo',
            style: TextStyle(
              fontFamily: 'Gamja_Flower',
              fontSize: 20.0,
              color: Colors.white,
            ),),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orangeAccent, Colors.orangeAccent,
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.bottomRight,
                )
            ),
          ),

          // #################### 로그아웃 아이콘 버튼 ###################
          // ... 오후 11:17 2022-05-30 로그아웃 버튼 삭제
          // ... 뒤로 가기 버튼을 눌렀을 때 원활하게 로그아웃이 진행 되도록
          // ... 로그인 페이지 접속 시, 로그아웃을 실행 되도록 변경

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
                Tab(icon: Icon(Icons.calendar_month_outlined), text: 'Month',),
                Tab(icon: Icon(Icons.access_time_outlined), text: 'Day',),
                Tab(icon: Icon(Icons.cloud), text: 'Weather',),
              ]),),
        //###################### TapBar 이동 부분 #######################
        // ... 오후 1:30 2022-06-01 WeatherScreen 기능 추가
        body: TabBarView(children: [
          Center(child: MonthViewWidget()),
          Center(child: DayViewWidget()),
          Center(child: WeatherLoading()),
        ],),
        //##############################################################
        floatingActionButton:
        ExpandableFab(
          distance: 150,
          children: [
            ActionButton(
              onPressed: _addEvent,
              icon: Icon(Icons.add),
              color: Colors.white,
            ),
            ActionButton(
              onPressed: (){}, //_removeEvent,
              icon: Icon(Icons.sports_baseball_outlined),
              color: Colors.white,
            ),
            ActionButton(
              onPressed: (){
                Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => MemoMain())
                );
              },
              icon: Icon(Icons.note),
              color: Colors.white,),
          ],
        ),
      ),
    );
  }

  Future<void> _addEvent() async {
    final event = await context.pushRoute<CalendarEventData<Event>>(
      CreateEventPage(
        withDuration: true,
      ),
    );
    if (event == null) return;
    CalendarControllerProvider
        .of<Event>(context)
        .controller
        .add(event);
  }
}
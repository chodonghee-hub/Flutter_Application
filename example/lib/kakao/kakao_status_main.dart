import 'package:example/kakao/kakao_login.dart';
import 'package:flutter/material.dart';

import 'kakao_main_view_model.dart';

class KakaoStatusMain extends StatefulWidget {
  const KakaoStatusMain({Key? key}) : super(key: key);

  @override
  State<KakaoStatusMain> createState() => _KakaoStatusMainState();
}

class _KakaoStatusMainState extends State<KakaoStatusMain> {
  final viewModel = KakaoMainViewModel(KakaoLogin());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kakao Status"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Image.network(viewModel.user?.kakaoAccount?.profile?.profileImageUrl?? ''),
            Text(
              '${viewModel.isLogined}',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
              onPressed: () async{
                await viewModel.login();
              },
              child: const Text('Login')
            ),

            ElevatedButton(
                onPressed: () async{
                  await viewModel.logout();
                },
                child: const Text('Logout')
            ),
          ],
        ),
      ),
    );
  }
}

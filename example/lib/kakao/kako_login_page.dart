import 'package:flutter/material.dart';
import 'kakao_login.dart';
import 'kakao_main_view_model.dart';

class KakaoLoginPage extends StatefulWidget {
  const KakaoLoginPage({Key? key}) : super(key: key);

  @override
  State<KakaoLoginPage> createState() => _KakaoLoginPageState();
}

class _KakaoLoginPageState extends State<KakaoLoginPage> {
  final viewModel = KakaoMainViewModel(KakaoLogin());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
                onPressed: () async {
                  await viewModel.login();
                  setState((){});
                },
                child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () async {
                await viewModel.logout();
                setState((){});
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

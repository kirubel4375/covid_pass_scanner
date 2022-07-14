import 'package:covid_pass_scanner/Models/user_info.dart';
import 'package:covid_pass_scanner/Models/user_model.dart';
import 'package:covid_pass_scanner/Resources/auth_methods.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:scan/scan.dart';

import '../result_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScanController _controller = ScanController();
  String email = " ";
  String uid = " ";
  bool isLoading = false;
  bool isRuning = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scann Qr code"),
        centerTitle: false,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.logout)),
        ],
      ),
      body: LoadingOverlay(
        isLoading: isLoading,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * .5,
              width: double.infinity,
              child: ScanView(
                controller: _controller,
                onCapture: (value) async{
                  setState(() {
                    if(value.isNotEmpty && value.contains(",")){
                      List<String> stringValue = value.split(',');
                      email = stringValue.first;
                      uid = stringValue.last;
                    }
                  });
                  if (email.isNotEmpty) {
                    setState(() {
                      isLoading = true;
                    });
                    if(email.contains("@")){
                      AuthMethods authMethods = AuthMethods();
                    UserModel? userModel = await authMethods.getEmployeeInfo(email);
                    UserInfo? userInfo = await authMethods.getEmployeeDetailInfo(email, uid);
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => ResultPage(userInfo: userInfo, userModel: userModel,)),
                      ),
                    );
                    }
                  }
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                isRuning? _controller.pause(): _controller.resume();
                setState(() {
                  isRuning = !isRuning;
                });
              },
              child: Text(isRuning? "Pause": "Resume"),
            ),
          ],
        ),
      ),
    );
  }
}

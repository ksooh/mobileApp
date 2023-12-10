import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login/LoginPage.dart';

class Setting extends StatelessWidget {
  Setting({Key? key}) : super(key:key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('설정', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SettingDetail(),
    );
  }
}
// Modify the SettingDetail class

class SettingDetail extends StatefulWidget {
  const SettingDetail({super.key});

  @override
  State<SettingDetail> createState() => _SettingDetailState();
}

class _SettingDetailState extends State<SettingDetail> {

  void _handleLogout() async {
    // Show confirmation dialog
    bool confirmed = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('로그아웃 확인', style: TextStyle(fontWeight: FontWeight.bold,),)),
          content: Text('로그아웃하시겠습니까?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Return false if not confirmed
              },
              child: Text('아니오'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Return true if confirmed
              },
              child: Text('예'),
            ),
          ],
        );
      },
    );

    // If user confirmed, proceed with logout
    if (confirmed == true) {
      // Perform any additional logout logic if needed

      // Navigate to LoginPage
      // Get.offAll(() => LoginPage());
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  // Add a method to show the account information dialog
  Future<void> _showAccountInfoDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('계정 정보', style: TextStyle(fontWeight: FontWeight.bold,),)),
          content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5, // Adjust the width as needed
              height: MediaQuery.of(context).size.height * 0.1, // Adjust the width as needed
              child: AccountDetail()
          ), // Display the AccountDetail widget in the AlertDialog
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('닫기'),
            ),
          ],
        );
      },
    );
  }

  // Add this method to show a confirmation dialog
  Future<void> _showConfirmationDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('회원 탈퇴 확인', style: TextStyle(fontWeight: FontWeight.bold,),)),
          content: Text('정말 탈퇴하시겠습니까?\n탈퇴시 모든 정보는 사라집니다.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () async {
                // Clear all schedules from the Drift database
                // await GetIt.I<LocalDatabase>().deleteAllScheduleIds();

                // Update the UI of the PlanPage (assuming PlanPage is the calendar page)
                setState(() {});

                // Navigate to LoginPage
                // Get.offAll(() => LoginPage());
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));

              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ListView(
        children: [
          ListTile(
            title: Text('계정 정보'),
            onTap: () {
              _showAccountInfoDialog(context); // Call the method to show the dialog
            },
          ),
          ListTile(
            title: Text('로그아웃'),
            onTap: () {
              _handleLogout();
              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => LogoutPage()));
            },
          ),
          ListTile(
            title: Text('회원 탈퇴'),
            onTap: () {
              _showConfirmationDialog();
            },
          ),
        ],
      ),
    );
  }
}



class AccountDetail extends StatefulWidget {
  const AccountDetail({super.key});

  @override
  State<AccountDetail> createState() => _AccountDetailState();
}
class _AccountDetailState extends State<AccountDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   body: Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         GetBuilder<AuthService>(
      //           builder: (authController) {
      //             // 사용자가 로그인하지 않았을 때
      //             if (authController.user.value == null) {
      //               return Text(
      //                 '로그인되지 않았습니다.',
      //                 style: TextStyle(fontSize: 16),
      //               );
      //             }
      //
      //             // 사용자가 익명 로그인한 경우
      //             if (loginMethod=='Anonymous') {
      //               return Column(
      //                 children: [
      //                   Text(
      //                     '\'익명 로그인\' 상태입니다.',
      //                     style: TextStyle(fontSize: 18),
      //                   ),
      //                 ],
      //               );
      //             }
      //
      //             // 사용자가 Google 로그인한 경우
      //             if (loginMethod=='Google') {
      //               return Column(
      //                 children: [
      //                   Text(
      //                     '계정: Google 로그인',
      //                     style: TextStyle(fontSize: 16),
      //                   ),
      //                 ],
      //               );
      //             }
      //
      //             // 다른 로그인 방식에 대한 처리 추가 가능
      //
      //             return Container(); // 기타 경우에는 빈 컨테이너 반환
      //           },
      //         ),
      //       ],
      //     ),
      //   ),
    );
  }
}



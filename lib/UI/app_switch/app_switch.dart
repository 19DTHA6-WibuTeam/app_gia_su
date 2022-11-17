import 'package:flutter/material.dart';
import 'package:gia_su_trung_tam_mobile/UI/account/tutor_account.dart';
import 'package:gia_su_trung_tam_mobile/UI/calender/calender_home/tutor_calender.dart';
import 'package:gia_su_trung_tam_mobile/UI/home_page/tutor_home.dart';
import 'package:gia_su_trung_tam_mobile/UI/session/session_home/student_session.dart';
import 'package:gia_su_trung_tam_mobile/theme/colors.dart';

class Tutor extends StatefulWidget {
  Tutor({Key? key}) : super(key: key);

  @override
  _TutorState createState() => _TutorState();
}

class _TutorState extends State<Tutor> {
  int _bottomNavIndex = 0;

  final List<Widget> _widgetOptions = const <Widget>[
    TutorHome(),
    TutorCalender(),
    SessionScreen(),
    TutorAccount(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_bottomNavIndex)),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12.0,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_rounded),
            label: 'Lịch dạy',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity),
            label: 'Lớp',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Tài khoản',
          ),
        ],
        currentIndex: _bottomNavIndex,
        unselectedItemColor: const Color(0xFFDADADA),
        selectedItemColor: AppColors.primary,
        onTap: _onItemTapped,
      ),
    );
  }
}

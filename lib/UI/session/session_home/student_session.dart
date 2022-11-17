import 'package:flutter/material.dart';
import 'package:gia_su_trung_tam_mobile/UI/session/session_home/session_child_2.dart';
import 'package:gia_su_trung_tam_mobile/UI/session/session_home/session_child_3.dart';
import 'package:gia_su_trung_tam_mobile/theme/colors.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: TabBar(
            physics: BouncingScrollPhysics(),
            isScrollable: true,
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.black,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(text: "Đang dạy"),
              Tab(text: "Đã hoàn thành"),
            ],
          ),
          body: TabBarView(
            physics: BouncingScrollPhysics(),
            children: [
              SessionChild2(),
              SessionChild3(),
            ],
          )),
    ));
  }
}

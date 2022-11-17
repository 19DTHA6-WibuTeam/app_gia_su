import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gia_su_trung_tam_mobile/UI/app_switch/app_switch.dart';
import 'package:gia_su_trung_tam_mobile/UI/sign_in/tutor_login.dart';
import 'package:gia_su_trung_tam_mobile/manager/shared_preferences.dart';
import 'package:gia_su_trung_tam_mobile/theme/colors.dart';
import 'package:gia_su_trung_tam_mobile/theme/dimens.dart';
import 'package:gia_su_trung_tam_mobile/theme/images.dart';
import 'package:gia_su_trung_tam_mobile/widget/text_style.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, route);
  }

  route() async {
    final userToken = await BaseSharedPreferences.getString('token');
    if (userToken.length > 0) {
      Get.to(Tutor());
    } else {
      Get.to(const TutorLoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width;
    final double maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: maxWidth,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primaryLight, AppColors.primary]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: maxHeight * 0.15,
            ),
            SizedBox(
                width: maxWidth * 0.8, child: Image.asset(Images.imageIntro4)),
            SizedBox(
              height: maxHeight * 0.05,
            ),
            Text(
              Dimens.continueLearn,
              style: AppTextStyle.style(
                  fontSize: Dimens.TEXT_SIZE_22, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: maxHeight * 0.05,
            ),
            SizedBox(
                height: maxHeight * 0.1,
                child: LoadingAnimationWidget.discreteCircle(
                  color: AppColors.redPink,
                  secondRingColor: AppColors.dark,
                  thirdRingColor: AppColors.orange,
                  size: maxHeight * 0.1,
                )),
          ],
        ),
      ),
    );
  }
}

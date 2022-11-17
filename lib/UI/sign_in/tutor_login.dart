import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gia_su_trung_tam_mobile/UI/app_switch/app_switch.dart';
import 'package:gia_su_trung_tam_mobile/api/login.dart';
import 'package:gia_su_trung_tam_mobile/models/user.dart';
import 'package:gia_su_trung_tam_mobile/theme/colors.dart';
import 'package:gia_su_trung_tam_mobile/theme/dimens.dart';
import 'package:gia_su_trung_tam_mobile/theme/images.dart';
import 'package:gia_su_trung_tam_mobile/widget/app_text_field.dart';
import 'package:gia_su_trung_tam_mobile/widget/app_text_filed_pass.dart';
import 'package:gia_su_trung_tam_mobile/widget/text_style.dart';

class TutorLoginScreen extends StatefulWidget {
  const TutorLoginScreen({Key? key}) : super(key: key);

  @override
  State<TutorLoginScreen> createState() => _TutorLoginScreenState();
}

class _TutorLoginScreenState extends State<TutorLoginScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primaryLight, AppColors.primary]),
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: Image.asset(Images.imageSplash),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: Dimens.PADDING_10, bottom: Dimens.PADDING_10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Dimens.welcomeTutor,
                          style: AppTextStyle.style(
                              fontSize: Dimens.TEXT_SIZE_22,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          Dimens.SignInContinue,
                          style: AppTextStyle.style(
                              fontSize: Dimens.TEXT_SIZE_20,
                              color: Colors.white.withOpacity(0.65),
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.65,
                padding: const EdgeInsets.all(Dimens.PADDING_20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimens.RADIUS_15),
                    topLeft: Radius.circular(Dimens.RADIUS_15),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Dimens.loginByAcc,
                        style: AppTextStyle.style(
                            fontSize: Dimens.TEXT_SIZE_14,
                            color: AppColors.redPink,
                            fontWeight: FontWeight.normal),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      AppTextField(
                        labelText: Dimens.Email,
                        enabled: true,
                        obscureText: false,
                        controllerName: _emailController,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      AppTextFieldPass(
                        labelText: Dimens.Password,
                        controllerName: _passwordController,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      SizedBox(
                        height: Dimens.HEIGHT_55,
                        //padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(Dimens.RADIUS_10),
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(Dimens.SignIn,
                                    style: AppTextStyle.style(
                                        fontSize: Dimens.TEXT_SIZE_20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            onPressed: () async {
                              User? user = await fetchLogin(
                                  _emailController.text,
                                  _passwordController.text);
                              if (user != null) {
                                saveLogin(user);
                                print(user.user_email);
                                Get.offAll(Tutor());
                              } else
                                print("something wrong");
                            }),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            Dimens.NotAccount,
                            style: AppTextStyle.style(
                                fontSize: Dimens.TEXT_SIZE_14,
                                color: AppColors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            Dimens.contact,
                            style: AppTextStyle.style(
                                fontSize: Dimens.TEXT_SIZE_14,
                                color: AppColors.black,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            Dimens.phone,
                            style: AppTextStyle.style(
                                fontSize: Dimens.TEXT_SIZE_DEFAULT,
                                color: AppColors.primary,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            Dimens.toSp,
                            style: AppTextStyle.style(
                                fontSize: Dimens.TEXT_SIZE_14,
                                color: AppColors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

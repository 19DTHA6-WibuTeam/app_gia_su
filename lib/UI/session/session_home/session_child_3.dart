import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:gia_su_trung_tam_mobile/UI/session/session_detail/session_child_2_detail.dart';
import 'package:gia_su_trung_tam_mobile/UI/session/session_detail/session_child_3_detail.dart';
import 'package:gia_su_trung_tam_mobile/api/calender.dart';
import 'package:gia_su_trung_tam_mobile/api/user.dart';
import 'package:gia_su_trung_tam_mobile/main.dart';
import 'package:gia_su_trung_tam_mobile/manager/shared_preferences.dart';
import 'package:gia_su_trung_tam_mobile/models/session.dart';
import 'package:gia_su_trung_tam_mobile/theme/colors.dart';
import 'package:gia_su_trung_tam_mobile/theme/dimens.dart';
import 'package:gia_su_trung_tam_mobile/widget/text_style.dart';
import 'package:intl/intl.dart';

class SessionChild3 extends StatefulWidget {
  const SessionChild3({super.key});

  @override
  State<SessionChild3> createState() => _SessionChild3State();
}

class _SessionChild3State extends State<SessionChild3> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _getData();
    });
  }

  List<Datum> sessionList = [];
  var isLoaded = false;
  int userId = 0;
  Future<void> _getData() async {
    sessionList =
        (await getCalenderList(BaseSharedPreferences.getString('token')))!;
    var user = await getUser(BaseSharedPreferences.getString('MaNguoiDung'),
        BaseSharedPreferences.getString('token'));
    userId = user!.user_id;
    isLoaded = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double maxHeight = MediaQuery.of(context).size.height;
    final double maxWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Visibility(
          visible: isLoaded,
          replacement: SizedBox(
            width: maxWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: maxHeight * 0.3),
                const CircularProgressIndicator(),
              ],
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: maxHeight * 0.01,
              ),
              for (int i = 0; i < sessionList.length; i++)
                sessionList[i].maGiaSu == userId
                    ? GestureDetector(
                        onTap: () {
                          Get.to(
                            SessionChild3Detail(
                              sessionId: sessionList[i].maKhoaHoc!,
                            ),
                          );
                        },
                        child: sessionList[i].tinhTrang == 3
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: maxWidth * 0.05),
                                margin: EdgeInsets.only(
                                    bottom: maxHeight * 0.01,
                                    right: maxWidth * 0.02,
                                    left: maxWidth * 0.02),
                                width: maxWidth,
                                height: maxHeight * 0.2,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(Dimens.RADIUS_15),
                                  color: AppColors.green,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          sessionList[i].tenMonHoc!,
                                          style: AppTextStyle.chooseText
                                              .copyWith(
                                                  fontSize: maxWidth * 0.07,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.white),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Ngày bắt đầu: ",
                                              style: AppTextStyle.chooseText
                                                  .copyWith(
                                                      fontSize:
                                                          maxWidth * 0.05),
                                            ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              DateFormat('dd/MM/yyyy').format(
                                                  sessionList[i].ngayBatDau ??
                                                      DateTime.now()),
                                              style: AppTextStyle.chooseText
                                                  .copyWith(
                                                      fontSize:
                                                          maxWidth * 0.05),
                                            )
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Thời gian học: ",
                                              style: AppTextStyle.chooseText
                                                  .copyWith(
                                                      fontSize:
                                                          maxWidth * 0.05),
                                            ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              "${sessionList[i].thoiKhoaBieuTomTat!.gioBatDau!.substring(0, 5)} - ${sessionList[i].thoiKhoaBieuTomTat!.gioKetThuc!.substring(0, 5)}",
                                              style: AppTextStyle.chooseText
                                                  .copyWith(
                                                      fontSize:
                                                          maxWidth * 0.05),
                                            )
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Học phí: ",
                                              style: AppTextStyle.chooseText
                                                  .copyWith(
                                                      fontSize:
                                                          maxWidth * 0.05),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "${numberWithDot(sessionList[i].soTien.toString())} VNĐ",
                                              style: AppTextStyle.chooseText
                                                  .copyWith(
                                                      fontSize:
                                                          maxWidth * 0.05),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: maxWidth * 0.02),
                                          height: maxHeight * 0.15,
                                          width: 1,
                                          color: AppColors.white,
                                        ),
                                        RotatedBox(
                                          quarterTurns: 3,
                                          child: Text(
                                            "Đã hoàn thành",
                                            style: AppTextStyle.chooseText
                                                .copyWith(
                                                    fontSize: maxWidth * 0.05),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(),
                      )
                    : SizedBox()
            ],
          ),
        ),
      ),
    ));
  }
}

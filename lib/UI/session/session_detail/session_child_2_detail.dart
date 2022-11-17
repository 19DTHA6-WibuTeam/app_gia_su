import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:gia_su_trung_tam_mobile/api/calender.dart';
import 'package:gia_su_trung_tam_mobile/api/user.dart';
import 'package:gia_su_trung_tam_mobile/main.dart';
import 'package:gia_su_trung_tam_mobile/manager/shared_preferences.dart';
import 'package:gia_su_trung_tam_mobile/models/session.dart';
import 'package:gia_su_trung_tam_mobile/theme/colors.dart';
import 'package:gia_su_trung_tam_mobile/theme/dimens.dart';
import 'package:gia_su_trung_tam_mobile/widget/text_style.dart';
import 'package:intl/intl.dart';

class SessionChild2Detail extends StatefulWidget {
  int sessionId;

  SessionChild2Detail({
    super.key,
    required this.sessionId,
  });

  @override
  State<SessionChild2Detail> createState() => _SessionChild2DetailState();
}

class _SessionChild2DetailState extends State<SessionChild2Detail> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _getData();
    });
  }

  List<Datum> sessionList = [];

  int index = 0;

  var isLoaded = false;

  Future<void> _getData() async {
    sessionList =
        (await getCalenderList(BaseSharedPreferences.getString('token')))!;

    for (int i = 0; i < sessionList.length; i++) {
      if (sessionList[i].maKhoaHoc == widget.sessionId) {
        index = i;
        break;
      }
    }
    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double maxHeight = MediaQuery.of(context).size.height;
    final double maxWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: isLoaded
            ? SizedBox(
                height: maxHeight * 0.971,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: maxWidth * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: maxHeight * 0.005),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_back_ios,
                                      color: AppColors.black),
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                                Text(
                                  Dimens.sessionDetail,
                                  style: AppTextStyle.titleLarge
                                      .copyWith(fontSize: 32),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: maxHeight * 0.01,
                          ),
                          Row(
                            children: [
                              const Text(Dimens.sessionId,
                                  style: AppTextStyle.calenderDetailBoldText),
                              const SizedBox(
                                width: Dimens.WIDTH_5,
                              ),
                              Text(
                                "#${sessionList[index].maKhoaHoc.toString()}",
                                style: AppTextStyle.calenderDetailDarkText,
                              )
                            ],
                          ),
                          SizedBox(
                            height: maxHeight * 0.01,
                          ),
                          Row(
                            children: [
                              const Text(Dimens.subject,
                                  style: AppTextStyle.calenderDetailBoldText),
                              const SizedBox(
                                width: Dimens.WIDTH_5,
                              ),
                              Text(
                                sessionList[index].tenMonHoc!,
                                style: AppTextStyle.calenderDetailDarkText,
                              )
                            ],
                          ),
                          SizedBox(
                            height: maxHeight * 0.01,
                          ),
                          Row(
                            children: [
                              const Text(Dimens.classRoom,
                                  style: AppTextStyle.calenderDetailBoldText),
                              const SizedBox(
                                width: Dimens.WIDTH_5,
                              ),
                              Text(
                                sessionList[index].khoiLop!.toString(),
                                style: AppTextStyle.calenderDetailDarkText,
                              )
                            ],
                          ),
                          SizedBox(
                            height: maxHeight * 0.01,
                          ),
                          Row(
                            children: [
                              const Text(Dimens.startDay,
                                  style: AppTextStyle.calenderDetailBoldText),
                              const SizedBox(
                                width: Dimens.WIDTH_5,
                              ),
                              Text(
                                DateFormat('dd/MM/yyyy').format(
                                    sessionList[index].ngayBatDau ??
                                        DateTime.now()),
                                style: AppTextStyle.calenderDetailDarkText,
                              )
                            ],
                          ),
                          SizedBox(
                            height: maxHeight * 0.01,
                          ),
                          Row(
                            children: [
                              const Text(Dimens.learningTime,
                                  style: AppTextStyle.calenderDetailBoldText),
                              const SizedBox(
                                width: Dimens.WIDTH_5,
                              ),
                              Text(
                                "${sessionList[index].thoiKhoaBieuTomTat!.gioBatDau!.substring(0, 5)} - ${sessionList[index].thoiKhoaBieuTomTat!.gioKetThuc!.substring(0, 5)}",
                                style: AppTextStyle.calenderDetailDarkText,
                              )
                            ],
                          ),
                          SizedBox(
                            height: maxHeight * 0.01,
                          ),
                          Row(
                            children: [
                              const Text(Dimens.learningDay,
                                  style: AppTextStyle.calenderDetailBoldText),
                              const SizedBox(
                                width: Dimens.WIDTH_5,
                              ),
                              Text(
                                sessionList[index].thoiKhoaBieuTomTat?.tenThu ??
                                    "",
                                style: AppTextStyle.calenderDetailDarkText,
                              )
                            ],
                          ),
                          SizedBox(
                            height: maxHeight * 0.01,
                          ),
                          const Text(Dimens.learningPlace,
                              style: AppTextStyle.calenderDetailBoldText),
                          SizedBox(
                            height: maxHeight * 0.01,
                          ),
                          Text(sessionList[index].diaChi!,
                              style: AppTextStyle.calenderDetailBoldText),
                          SizedBox(
                            height: maxHeight * 0.01,
                          ),
                          Row(
                            children: [
                              const Text(Dimens.student,
                                  style: AppTextStyle.calenderDetailBoldText),
                              const SizedBox(
                                width: Dimens.WIDTH_5,
                              ),
                              Text(
                                sessionList[index].hoTen!,
                                style: AppTextStyle.calenderDetailDarkText
                                    .copyWith(color: AppColors.primary),
                              )
                            ],
                          ),
                          SizedBox(
                            height: maxHeight * 0.01,
                          ),
                          Row(
                            children: [
                              const Text("${Dimens.chooseFee}: ",
                                  style: AppTextStyle.calenderDetailBoldText),
                              const SizedBox(
                                width: Dimens.WIDTH_5,
                              ),
                              Text(
                                "${numberWithDot(sessionList[index].soTien.toString())} VNĐ",
                                style: AppTextStyle.calenderDetailBoldText,
                              ),
                              const SizedBox(
                                width: Dimens.WIDTH_10,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: maxHeight * 0.01,
                          ),
                          Row(
                            children: const [
                              Text(Dimens.status,
                                  style: AppTextStyle.calenderDetailBoldText),
                              SizedBox(
                                width: Dimens.WIDTH_5,
                              ),
                              Text(
                                "Đang dạy",
                                style: AppTextStyle.calenderDetailDarkText,
                              )
                            ],
                          ),
                          SizedBox(
                            height: maxHeight * 0.01,
                          ),
                          const Text("${Dimens.note}: ",
                              style: AppTextStyle.calenderDetailBoldText),
                          Text(
                            sessionList[index].ghiChu != null
                                ? sessionList[index].ghiChu.toString()
                                : "Không",
                            style: AppTextStyle.calenderDetailBoldText,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : SizedBox(
                width: maxWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: maxHeight * 0.3),
                    const CircularProgressIndicator(),
                  ],
                ),
              ),
      )),
    );
  }
}

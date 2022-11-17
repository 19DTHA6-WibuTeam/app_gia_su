import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:gia_su_trung_tam_mobile/api/calender.dart';
import 'package:gia_su_trung_tam_mobile/manager/shared_preferences.dart';
import 'package:gia_su_trung_tam_mobile/models/session.dart';
import 'package:gia_su_trung_tam_mobile/theme/colors.dart';
import 'package:gia_su_trung_tam_mobile/theme/dimens.dart';
import 'package:gia_su_trung_tam_mobile/widget/text_style.dart';

class CalenderDetail extends StatefulWidget {
  int sessionId;
  int dayId;
  String learningDay;
  CalenderDetail(
      {super.key,
      required this.sessionId,
      required this.dayId,
      required this.learningDay});

  @override
  State<CalenderDetail> createState() => _CalenderDetailState();
}

class _CalenderDetailState extends State<CalenderDetail> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _getData();
    });
  }

  List<Datum> calenderList = [];
  int index = 0;
  int day = 1;

  var isLoaded = false;
  Future<void> _getData() async {
    calenderList =
        (await getCalenderList(BaseSharedPreferences.getString('token')))!;
    for (int i = 0; i < calenderList.length; i++) {
      if (widget.sessionId == calenderList[i].maKhoaHoc) {
        index = i;
        break;
      }
    }
    for (int i = 0; i < calenderList[index].thoiKhoaBieu!.length; i++) {
      if (widget.dayId == calenderList[index].thoiKhoaBieu![i].maThu) {
        day = i;
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
            ? Padding(
                padding: EdgeInsets.only(
                    left: maxWidth * 0.05, top: maxHeight * 0.005),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: maxHeight * 0.005),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios,
                                color: AppColors.black),
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onPressed: () {
                              Get.back();
                            },
                          ),
                          Text(
                            Dimens.calenderDetail,
                            style:
                                AppTextStyle.titleLarge.copyWith(fontSize: 32),
                          )
                        ],
                      ),
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
                          calenderList[index].tenMonHoc!,
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
                          widget.learningDay,
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
                          "${calenderList[index].thoiKhoaBieuTomTat!.gioBatDau!.substring(0, 5)} - ${calenderList[index].thoiKhoaBieuTomTat!.gioKetThuc!.substring(0, 5)}",
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
                          calenderList[index].thoiKhoaBieu![day].tenThu!,
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
                    Text(calenderList[index].diaChi!,
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
                          calenderList[index].hoTen!,
                          style: AppTextStyle.calenderDetailBoldText,
                        )
                      ],
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

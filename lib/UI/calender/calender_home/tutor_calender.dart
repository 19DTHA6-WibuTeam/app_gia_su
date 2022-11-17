import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:gia_su_trung_tam_mobile/UI/calender/calender_detail/calender_detail.dart';
import 'package:gia_su_trung_tam_mobile/api/calender.dart';
import 'package:gia_su_trung_tam_mobile/api/user.dart';
import 'package:gia_su_trung_tam_mobile/manager/shared_preferences.dart';
import 'package:gia_su_trung_tam_mobile/models/session.dart';
import 'package:gia_su_trung_tam_mobile/theme/colors.dart';
import 'package:gia_su_trung_tam_mobile/theme/dimens.dart';
import 'package:gia_su_trung_tam_mobile/widget/text_style.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class TutorCalender extends StatefulWidget {
  const TutorCalender({super.key});

  @override
  State<TutorCalender> createState() => _TutorCalenderState();
}

class _TutorCalenderState extends State<TutorCalender> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _getData();
    });
  }

  int userId = 0;
  List<Datum> calenderList = [];
  var isLoaded = false;
  Future<void> _getData() async {
    calenderList =
        (await getCalenderList(BaseSharedPreferences.getString('token')))!;
    var user = await getUser(BaseSharedPreferences.getString('MaNguoiDung'),
        BaseSharedPreferences.getString('token'));
    userId = user!.user_id;
    for (int i = 0; i < calenderList.length; i++) {
      for (int j = 0; j < calenderList[i].thoiKhoaBieu!.length; j++) {
        if (calenderList[i].maGiaSu == userId) {
          if (_selectedDay.value.weekday ==
              calenderList[i].thoiKhoaBieu![j].maThu) {
            isInit.value = true;
            break;
          }
        }
      }
    }

    setState(() {
      isLoaded = true;
    });
  }

  RxString chooseDay =
      DateFormat.yMMMMd().format(DateTime.now()).toString().obs;
  final Rx<DateTime> _selectedDay = DateTime.now().obs;
  final Rx<DateTime> _focusedDay = DateTime.now().obs;

  final RxBool isInit = false.obs;
  final CalendarFormat _format = CalendarFormat.week;
  @override
  Widget build(BuildContext context) {
    final double maxHeight = MediaQuery.of(context).size.height;
    final double maxWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Center(
              child: Obx(
            () => Text(
              chooseDay.value,
              style: AppTextStyle.titleLarge,
            ),
          )),
          Obx(
            () => TableCalendar(
              firstDay: DateTime(1990),
              lastDay: DateTime(2050),
              focusedDay: _selectedDay.value,
              calendarFormat: _format,
              startingDayOfWeek: StartingDayOfWeek.sunday,
              daysOfWeekVisible: true,
              onDaySelected: ((selectedDay, focusedDay) {
                _focusedDay.value = selectedDay;
                _selectedDay.value = selectedDay;
                chooseDay.value =
                    DateFormat.yMMMMd().format(selectedDay).toString();
                for (int i = 0; i < calenderList.length; i++) {
                  for (int j = 0;
                      j < calenderList[i].thoiKhoaBieu!.length;
                      j++) {
                    if (calenderList[i].maGiaSu == userId) {
                      if (_selectedDay.value.weekday ==
                          calenderList[i].thoiKhoaBieu![j].maThu) {
                        isInit.value = false;
                        isInit.value = true;
                        break;
                      }
                    }
                  }
                }
              }),
              calendarStyle: const CalendarStyle(
                  isTodayHighlighted: true,
                  selectedDecoration: BoxDecoration(
                      color: AppColors.primary, shape: BoxShape.circle),
                  selectedTextStyle: TextStyle(color: AppColors.white)),
              selectedDayPredicate: ((day) {
                return isSameDay(_selectedDay.value, day);
              }),
              headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  formatButtonShowsNext: true),
            ),
          ),
          SizedBox(
            height: maxHeight * 0.01,
          ),
          Visibility(
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
            child: Obx(() => isInit.value
                ? Column(
                    children: [
                      for (int i = 0; i < calenderList.length; i++)
                        for (int j = 0;
                            j < calenderList[i].thoiKhoaBieu!.length;
                            j++)
                          calenderList[i].maGiaSu == userId &&
                                  calenderList[i].tinhTrang == 2
                              ? GestureDetector(
                                  onTap: () {
                                    Get.to(CalenderDetail(
                                      sessionId: calenderList[i].maKhoaHoc!,
                                      learningDay: DateFormat('dd/MM/yyyy')
                                          .format(_selectedDay.value)
                                          .toString(),
                                      dayId: calenderList[i]
                                          .thoiKhoaBieu![j]
                                          .maThu!,
                                    ));
                                  },
                                  child: _selectedDay.value.weekday ==
                                          calenderList[i].thoiKhoaBieu![j].maThu
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
                                                  BorderRadius.circular(
                                                      Dimens.RADIUS_15),
                                              color: AppColors.primary),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    calenderList[i].tenMonHoc!,
                                                    style: AppTextStyle
                                                        .chooseText
                                                        .copyWith(
                                                            fontSize:
                                                                maxWidth * 0.07,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: AppColors
                                                                .white),
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .access_time_rounded,
                                                        color: AppColors.white,
                                                        size: maxWidth * 0.05,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        //đá
                                                        "${calenderList[i].thoiKhoaBieuTomTat!.gioBatDau!.substring(0, 5)} - ${calenderList[i].thoiKhoaBieuTomTat!.gioKetThuc!.substring(0, 5)}",
                                                        style: AppTextStyle
                                                            .chooseText
                                                            .copyWith(
                                                                fontSize:
                                                                    maxWidth *
                                                                        0.05),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        color: AppColors.white,
                                                        size: maxWidth * 0.05,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      SizedBox(
                                                        width: maxWidth * 0.695,
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            calenderList[i]
                                                                .diaChi!,
                                                            style: AppTextStyle
                                                                .chooseText
                                                                .copyWith(
                                                                    fontSize:
                                                                        maxWidth *
                                                                            0.04),
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                maxWidth *
                                                                    0.02),
                                                    height: maxHeight * 0.15,
                                                    width: 1,
                                                    color: AppColors.white,
                                                  ),
                                                  RotatedBox(
                                                    quarterTurns: 3,
                                                    child: Text(
                                                      "Chi tiết",
                                                      style: AppTextStyle
                                                          .chooseText
                                                          .copyWith(
                                                              fontSize:
                                                                  maxWidth *
                                                                      0.05),
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
                  )
                : SizedBox(
                    height: maxHeight * 0.5,
                    child: Center(
                      child: Text(
                        "Không có lịch dạy hôm nay!!",
                        style: AppTextStyle.titleSmall.copyWith(
                            fontSize: maxWidth * 0.04, color: AppColors.black),
                      ),
                    ),
                  )),
          )
        ],
      ),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:get/get.dart';
import 'package:gia_su_trung_tam_mobile/UI/app_switch/app_switch.dart';
import 'package:gia_su_trung_tam_mobile/api/session.dart';
import 'package:gia_su_trung_tam_mobile/main.dart';
import 'package:gia_su_trung_tam_mobile/manager/shared_preferences.dart';
import 'package:gia_su_trung_tam_mobile/models/session.dart';
import 'package:gia_su_trung_tam_mobile/theme/colors.dart';
import 'package:gia_su_trung_tam_mobile/theme/dimens.dart';
import 'package:gia_su_trung_tam_mobile/widget/text_style.dart';
import 'package:intl/intl.dart';

class HomeDetail extends StatefulWidget {
  HomeDetail({super.key, required this.sessionId});

  int sessionId;

  @override
  State<HomeDetail> createState() => _HomeDetailState();
}

class _HomeDetailState extends State<HomeDetail> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _getData();
    });
  }

  List<Datum> homeDetailList = [];
  int index = 0;
  var isLoaded = false;
  Future<void> _getData() async {
    homeDetailList =
        (await getSession1List(BaseSharedPreferences.getString('token')))!;
    for (int i = 0; i < homeDetailList.length; i++) {
      if (homeDetailList[i].maKhoaHoc == widget.sessionId) {
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
                              const Text(Dimens.subject,
                                  style: AppTextStyle.calenderDetailBoldText),
                              const SizedBox(
                                width: Dimens.WIDTH_5,
                              ),
                              Text(
                                homeDetailList[index].tenMonHoc!,
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
                                homeDetailList[index].khoiLop!.toString(),
                                style: AppTextStyle.calenderDetailDarkText,
                              )
                            ],
                          ),
                          SizedBox(
                            height: maxHeight * 0.01,
                          ),
                          Row(
                            children: [
                              const Text(Dimens.studentName,
                                  style: AppTextStyle.calenderDetailBoldText),
                              const SizedBox(
                                width: Dimens.WIDTH_5,
                              ),
                              Text(
                                homeDetailList[index].hoTen!,
                                style: AppTextStyle.calenderDetailDarkText,
                              )
                            ],
                          ),
                          SizedBox(
                            height: maxHeight * 0.01,
                          ),
                          Row(
                            children: [
                              const Text(Dimens.inputDay,
                                  style: AppTextStyle.calenderDetailBoldText),
                              const SizedBox(
                                width: Dimens.WIDTH_5,
                              ),
                              Text(
                                DateFormat('dd/MM/yyyy').format(
                                    homeDetailList[index].ngayDangKy ??
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
                                "${homeDetailList[index].thoiKhoaBieuTomTat!.gioBatDau!.substring(0, 5)} - ${homeDetailList[index].thoiKhoaBieuTomTat!.gioKetThuc!.substring(0, 5)}",
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
                                homeDetailList[index]
                                        .thoiKhoaBieuTomTat
                                        ?.tenThu ??
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
                          Text(homeDetailList[index].diaChi!,
                              style: AppTextStyle.calenderDetailBoldText),
                          SizedBox(
                            height: maxHeight * 0.01,
                          ),
                          Row(
                            children: [
                              const Text(Dimens.tutor,
                                  style: AppTextStyle.calenderDetailBoldText),
                              const SizedBox(
                                width: Dimens.WIDTH_5,
                              ),
                              Text(
                                homeDetailList[index].maGiaSu != null
                                    ? homeDetailList[index].maGiaSu.toString()
                                    : "Đang chờ",
                                style: AppTextStyle.calenderDetailDarkText,
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
                                '${numberWithDot(homeDetailList[index].soTien.toString())} VNĐ',
                                style: AppTextStyle.calenderDetailBoldText
                                    .copyWith(color: AppColors.redPink),
                              )
                            ],
                          ),
                          SizedBox(
                            height: maxHeight * 0.01,
                          ),
                          const Text("${Dimens.note}: ",
                              style: AppTextStyle.calenderDetailBoldText),
                          Text(
                            homeDetailList[index].ghiChu != null
                                ? homeDetailList[index].ghiChu.toString()
                                : "Không",
                            style: AppTextStyle.calenderDetailBoldText,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: GestureDetector(
                          onTap: () async {
                            _dismissDialog() {
                              Get.back();
                            }

                            showDialog(
                                context: context,
                                builder: (newContext) {
                                  return AlertDialog(
                                    title: const Text('Xác nhận đăng ký dạy?'),
                                    content: const Text(
                                        'Sau khi đăng ký sẽ không được hủy. Liên hệ admin để hỗ trợ nếu muốn thay đổi!'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          _dismissDialog();
                                          setState(() {});
                                        },
                                        child: const Text('Không'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          bool Apply = await applySession(
                                              BaseSharedPreferences.getString(
                                                  'token'),
                                              widget.sessionId);
                                          Get.offAll(Tutor());
                                        },
                                        child: const Text('Có'),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(Dimens.PADDING_20),
                            color: AppColors.green,
                            child: const Center(
                                child: Text(
                              Dimens.apply,
                              style: AppTextStyle.changePassText,
                            )),
                          )),
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

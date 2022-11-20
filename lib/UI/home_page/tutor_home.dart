import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:gia_su_trung_tam_mobile/UI/account/controller/image_picker_controller.dart';
import 'package:gia_su_trung_tam_mobile/UI/home_page/home_detail.dart';
import 'package:gia_su_trung_tam_mobile/api/session.dart';
import 'package:gia_su_trung_tam_mobile/api/user.dart';
import 'package:gia_su_trung_tam_mobile/main.dart';
import 'package:gia_su_trung_tam_mobile/manager/shared_preferences.dart';
import 'package:gia_su_trung_tam_mobile/models/session.dart';
import 'package:gia_su_trung_tam_mobile/theme/colors.dart';
import 'package:gia_su_trung_tam_mobile/theme/dimens.dart';
import 'package:gia_su_trung_tam_mobile/theme/images.dart';
import 'package:gia_su_trung_tam_mobile/widget/text_style.dart';

class TutorHome extends StatefulWidget {
  const TutorHome({super.key});

  @override
  State<TutorHome> createState() => _TutorHomeState();
}

class _TutorHomeState extends State<TutorHome> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _getData();
    });
  }

  final ProfileController controller = ProfileController();
  String name = '';
  var isLoaded = false;
  List<Datum> session1List = [];
  Future<void> _getData() async {
    session1List =
        (await getSession1List(BaseSharedPreferences.getString('token')))!;
    var user = await getUser(BaseSharedPreferences.getString('MaNguoiDung'),
        BaseSharedPreferences.getString('token'));
    name = user!.user_fullname ?? Dimens.Tutor;
    controller.imageURL = user.avatar ?? '';
    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double mainWidth = MediaQuery.of(context).size.width;
    final double mainHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Visibility(
          visible: isLoaded,
          replacement: SizedBox(
            width: mainWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: mainHeight * 0.3),
                const CircularProgressIndicator(),
              ],
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: Dimens.PADDING_10,
                            top: Dimens.PADDING_20,
                            right: Dimens.PADDING_10,
                            bottom: Dimens.PADDING_20),
                        child: SizedBox(
                          height: mainWidth * 0.17,
                          width: mainWidth * 0.17,
                          child: Obx(() {
                            if (controller.isLoading.value) {
                              return const CircleAvatar(
                                backgroundImage:
                                    AssetImage(Images.imageDefault),
                                child: Center(
                                    child: CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                )),
                              );
                            } else {
                              if (controller.imageURL.length != 0) {
                                return CachedNetworkImage(
                                  imageUrl: controller.imageURL,
                                  fit: BoxFit.cover,
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                    backgroundColor: Colors.white,
                                    backgroundImage: imageProvider,
                                  ),
                                  placeholder: (context, url) =>
                                      const CircleAvatar(
                                    backgroundImage:
                                        AssetImage(Images.imageDefault),
                                    child: Center(
                                        child: CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                    )),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                );
                              } else {
                                return const CircleAvatar(
                                  backgroundImage:
                                      AssetImage(Images.imageDefault),
                                );
                              }
                            }
                          }),
                        ),
                      ),
                      SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: Dimens.PADDING_20,
                              right: Dimens.PADDING_10,
                              bottom: Dimens.PADDING_10),
                          child: Container(
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Dimens.hello,
                                  style: AppTextStyle.titleLarge
                                      .copyWith(fontSize: mainWidth * 0.06),
                                ),
                                Text(
                                  name,
                                  style: AppTextStyle.titleSmall
                                      .copyWith(fontSize: mainWidth * 0.04),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              for (int i = 0; i < session1List.length; i++)
                GestureDetector(
                  onTap: () {
                    Get.to(HomeDetail(
                      sessionId: session1List[i].maKhoaHoc!,
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: Dimens.PADDING_10,
                        right: Dimens.PADDING_10,
                        top: Dimens.PADDING_5,
                        bottom: Dimens.PADDING_10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.lightgray,
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(bottom: Dimens.PADDING_10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: mainHeight * 0.07,
                              width: mainWidth * 0.95,
                              decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8.0),
                                      topRight: Radius.circular(8.0))),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: Dimens.PADDING_15),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Text(
                                        session1List[i].tenMonHoc!,
                                        style: AppTextStyle.chooseText,
                                      ),
                                      const SizedBox(width: Dimens.WIDTH_5),
                                      Text(
                                        session1List[i].khoiLop.toString(),
                                        style: AppTextStyle.chooseText,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: mainHeight * 0.01),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: Dimens.PADDING_15),
                              child: Row(
                                children: [
                                  const Text(
                                    Dimens.address,
                                    style: AppTextStyle.titleSmallDark,
                                  ),
                                  const SizedBox(
                                    width: Dimens.WIDTH_10,
                                  ),
                                  SizedBox(
                                    width: mainWidth * 0.65,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        session1List[i].diaChi!,
                                        style: AppTextStyle.titleSmall,
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: mainHeight * 0.01),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: Dimens.PADDING_15),
                              child: Row(
                                children: [
                                  const Text(
                                    Dimens.salary,
                                    style: AppTextStyle.titleSmallDark,
                                  ),
                                  const SizedBox(
                                    width: Dimens.WIDTH_5,
                                  ),
                                  Text(
                                    '${numberWithDot(session1List[i].soTien.toString())} VNĐ',
                                    style: AppTextStyle.titleSmall
                                        .copyWith(color: AppColors.redPink),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: mainHeight * 0.01),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: Dimens.PADDING_15),
                              child: Row(
                                children: [
                                  const Text(
                                    Dimens.learningDay,
                                    style: AppTextStyle.titleSmallDark,
                                  ),
                                  const SizedBox(
                                    width: Dimens.WIDTH_5,
                                  ),
                                  Text(
                                    session1List[i].thoiKhoaBieuTomTat!.tenThu!,
                                    style: AppTextStyle.titleSmall,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: mainHeight * 0.01),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: Dimens.PADDING_15),
                              child: Row(
                                children: [
                                  const Text(
                                    Dimens.learningTime,
                                    style: AppTextStyle.titleSmallDark,
                                  ),
                                  const SizedBox(
                                    width: Dimens.WIDTH_5,
                                  ),
                                  Text(
                                    "${session1List[i].thoiKhoaBieuTomTat!.gioBatDau!.substring(0, 5)} - ${session1List[i].thoiKhoaBieuTomTat!.gioKetThuc!.substring(0, 5)}",
                                    style: AppTextStyle.titleSmall,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: mainHeight * 0.01),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: Dimens.PADDING_15),
                              child: Row(
                                children: [
                                  const Text(
                                    Dimens.week,
                                    style: AppTextStyle.titleSmallDark,
                                  ),
                                  const SizedBox(
                                    width: Dimens.WIDTH_5,
                                  ),
                                  Text(
                                    session1List[i].soTuan.toString(),
                                    style: AppTextStyle.titleSmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
            ],
          ),
        )),
      ),
    );
  }
}

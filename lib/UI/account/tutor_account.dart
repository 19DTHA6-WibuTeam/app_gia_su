import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gia_su_trung_tam_mobile/UI/account/controller/image_picker_controller.dart';
import 'package:gia_su_trung_tam_mobile/UI/app_switch/app_switch3.dart';
import 'package:gia_su_trung_tam_mobile/UI/change_pass/change_pass_page.dart';
import 'package:gia_su_trung_tam_mobile/UI/sign_in/tutor_login.dart';
import 'package:gia_su_trung_tam_mobile/api/logout.dart';
import 'package:gia_su_trung_tam_mobile/api/user.dart';
import 'package:gia_su_trung_tam_mobile/manager/shared_preferences.dart';
import 'package:gia_su_trung_tam_mobile/theme/colors.dart';
import 'package:gia_su_trung_tam_mobile/theme/dimens.dart';
import 'package:gia_su_trung_tam_mobile/theme/images.dart';
import 'package:gia_su_trung_tam_mobile/widget/app_text_field.dart';
import 'package:gia_su_trung_tam_mobile/widget/round_avatar.dart';
import 'package:gia_su_trung_tam_mobile/widget/text_style.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';

class TutorAccount extends StatefulWidget {
  const TutorAccount({super.key});

  @override
  State<TutorAccount> createState() => _TutorAccountState();
}

class _TutorAccountState extends State<TutorAccount> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _getData();
    });
  }

  final ProfileController controller = ProfileController();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  var isLoaded = false;
  Future<void> _getData() async {
    var user = await getUser(BaseSharedPreferences.getString('MaNguoiDung'),
        BaseSharedPreferences.getString('token'));
    _fullNameController.text = user?.user_fullname ?? '';
    _phoneNumberController.text = user?.user_phone_number ?? '';
    _addressController.text = user?.user_address ?? '';
    pickedDate.value = DateTime.parse("${user?.user_birthday} 00:00:00");
    gender.value = user?.user_gender ?? 0;
    if (gender.value == 1) {
      isFeMale.value = false;
    }
    controller.imageURL = user?.avatar ?? '';

    setState(() {
      isLoaded = true;
    });
  }

  RxInt gender = 0.obs;
  //RxString avatar = "".obs;
  RxBool enabled = false.obs;

  final Rx<DateTime> pickedDate = DateTime.now().obs;
  List<String> genderList = ['Nữ', 'Nam'];
  RxBool isFeMale = true.obs;
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    final double maxHeight = MediaQuery.of(context).size.height;
    final double maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: (SingleChildScrollView(
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
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        icon: enabled.value
                            ? const Icon(
                                Icons.edit,
                                color: Colors.black,
                              )
                            : const Icon(
                                Icons.edit,
                                color: AppColors.dark,
                              ),
                        onPressed: () {
                          if (enabled.value == false) {
                            enabled.value = true;
                          } else {
                            _showChangeInfoDialog(context);
                            enabled.value = false;
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 40,
                      ),
                    ],
                  ),
                  child: SizedBox(
                    height: maxHeight * 0.15,
                    width: maxHeight * 0.15,
                    child: Stack(
                      fit: StackFit.expand,
                      //overflow: Overflow.visible,
                      children: [
                        Obx(() {
                          if (controller.isLoading.value) {
                            return const CircleAvatar(
                              backgroundImage: AssetImage(Images.imageDefault),
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
                        Positioned(
                          left: maxHeight * 0.11,
                          bottom: 0,
                          child: SizedBox(
                            height: maxHeight * 0.035,
                            width: maxHeight * 0.035,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                primary: AppColors.gray,
                                backgroundColor: AppColors.gray,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: BorderSide(color: Colors.white),
                                ),
                              ),
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(50),
                              //   side: BorderSide(color: Colors.white),
                              // ),
                              // color: Colors.grey[200],
                              onPressed: () {
                                Get.bottomSheet(
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(16.0),
                                          topRight: Radius.circular(16.0)),
                                    ),
                                    child: Wrap(
                                      alignment: WrapAlignment.end,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.end,
                                      children: [
                                        ListTile(
                                          leading: Icon(Icons.camera),
                                          title: Text('Camera'),
                                          onTap: () {
                                            Get.back();
                                            controller.uploadImage(
                                              ImageSource.camera,
                                            );
                                          },
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.image),
                                          title: Text('Gallery'),
                                          onTap: () {
                                            Get.back();
                                            controller.uploadImage(
                                                ImageSource.gallery);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: SvgPicture.asset(Images.iconCamera),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: maxHeight * 0.03),
                Padding(
                  padding: const EdgeInsets.only(
                      left: Dimens.PADDING_20,
                      right: Dimens.PADDING_20,
                      bottom: Dimens.PADDING_20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => AppTextField(
                          labelText: Dimens.Phone,
                          enabled: enabled.value,
                          obscureText: false,
                          controllerName: _phoneNumberController,
                        ),
                      ),
                      SizedBox(height: maxHeight * 0.02),
                      Obx(
                        () => AppTextField(
                          labelText: Dimens.Name,
                          enabled: enabled.value,
                          obscureText: false,
                          controllerName: _fullNameController,
                        ),
                      ),
                      SizedBox(height: maxHeight * 0.02),
                      Obx(
                        () => AppTextField(
                          labelText: Dimens.address,
                          enabled: enabled.value,
                          obscureText: false,
                          controllerName: _addressController,
                        ),
                      ),
                      SizedBox(height: maxHeight * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Dimens.birthday,
                            style:
                                AppTextStyle.titleSmall.copyWith(fontSize: 13),
                          ),
                          Text(
                            Dimens.gender,
                            style:
                                AppTextStyle.titleSmall.copyWith(fontSize: 13),
                          )
                        ],
                      ),
                      SizedBox(height: maxHeight * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: Dimens.HEIGHT_55,
                            width: maxWidth * 0.5,
                            padding: EdgeInsets.only(
                                top: maxHeight * 0.005,
                                bottom: maxHeight * 0.005),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.lightgray,
                                borderRadius:
                                    BorderRadius.circular(Dimens.RADIUS_10),
                              ),
                              child: Obx(
                                () => OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                          color: AppColors.transparent)),
                                  onPressed: enabled.value
                                      ? () {
                                          DatePicker.showDatePicker(context,
                                              showTitleActions: true,
                                              minTime: DateTime.now().subtract(
                                                  const Duration(days: 365000)),
                                              maxTime: DateTime.now(),
                                              onConfirm: (date) {
                                            pickedDate.value = date;
                                          },
                                              currentTime: DateTime.now(),
                                              locale: LocaleType.vi);
                                        }
                                      : null,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Center(
                                      child: Text(
                                        DateFormat('dd/MM/yyyy')
                                            .format(pickedDate.value),
                                        style: enabled.value
                                            ? AppTextStyle.style(
                                                fontSize: 22,
                                                color: Colors.black
                                                    .withOpacity(0.8),
                                              )
                                            : AppTextStyle.titleSmall
                                                .copyWith(fontSize: 22),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: maxWidth * 0.35,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.lightgray,
                                borderRadius:
                                    BorderRadius.circular(Dimens.RADIUS_10),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: Dimens.PADDING_20),
                                  child: Obx(
                                    () => DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        hint: Text(
                                          isFeMale.value
                                              ? genderList[0]
                                              : genderList[1],
                                          style: enabled.value
                                              ? AppTextStyle.style(
                                                  color: Colors.black
                                                      .withOpacity(0.8),
                                                )
                                              : AppTextStyle.titleSmall,
                                        ),
                                        value: dropdownValue,
                                        elevation: 16,
                                        onChanged: enabled.value
                                            ? (String? newValue) {
                                                setState(() {
                                                  dropdownValue = newValue!;
                                                  print(dropdownValue);
                                                });
                                              }
                                            : null,
                                        items: genderList
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: enabled.value
                                                  ? AppTextStyle.style(
                                                      color: Colors.black
                                                          .withOpacity(0.8),
                                                    )
                                                  : AppTextStyle.titleSmall,
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  )),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: maxHeight * 0.02),
                      GestureDetector(
                          onTap: () {
                            Get.to(const ChangePassPage());
                          },
                          child: Container(
                            padding: const EdgeInsets.all(Dimens.PADDING_20),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimens.RADIUS_10),
                              color: AppColors.primary,
                            ),
                            child: const Center(
                                child: Text(
                              Dimens.changePass,
                              style: AppTextStyle.changePassText,
                            )),
                          )),
                      SizedBox(height: maxHeight * 0.02),
                      GestureDetector(
                          onTap: () {
                            _showDialog(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(Dimens.PADDING_20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor),
                              borderRadius:
                                  BorderRadius.circular(Dimens.RADIUS_10),
                              color: AppColors.white,
                            ),
                            child: const Center(
                                child: Text(
                              Dimens.signOut,
                              style: AppTextStyle.signOutText,
                            )),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  _showChangeInfoDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
                title: const Text('Xác nhận thay đổi thông tin'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Không'),
                  ),
                  TextButton(
                    onPressed: () async {
                      dismissDialog() {
                        Get.back();
                      }

                      final birthday = pickedDate.value.toString().split(' ');
                      String gender = "";
                      if (dropdownValue == "Nữ") {
                        gender = "0";
                      } else {
                        gender = "1";
                      }
                      bool? success = await changeInfo(
                          BaseSharedPreferences.getString('MaNguoiDung'),
                          BaseSharedPreferences.getString('token'),
                          _fullNameController.text,
                          _addressController.text,
                          birthday[0],
                          gender,
                          _phoneNumberController.text);

                      dismissDialog();
                      Get.offAll(Tutor3());
                    },
                    child: const Text('Có'),
                  ),
                ]));
  }
}

void _showDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(title: const Text('Xác nhận thoát'), actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Không'),
            ),
            TextButton(
              onPressed: () async {
                dismissDialog() {
                  Get.back();
                }

                dismissDialog();
                await logout();
                Get.offAll(const TutorLoginScreen());
              },
              child: const Text('Có'),
            ),
          ]));
}

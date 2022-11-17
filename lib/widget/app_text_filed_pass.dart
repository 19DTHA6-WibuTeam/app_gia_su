import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gia_su_trung_tam_mobile/theme/colors.dart';
import 'package:gia_su_trung_tam_mobile/theme/dimens.dart';
import 'package:gia_su_trung_tam_mobile/widget/text_style.dart';

class AppTextFieldPass extends StatelessWidget {
  AppTextFieldPass(
      {Key? key, required this.labelText, required this.controllerName})
      : super(key: key);

  final String labelText;

  TextEditingController controllerName;

  @override
  Widget build(BuildContext context) {
    final _isObscure = true.obs;
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: AppColors.lightgray,
          borderRadius: BorderRadius.circular(Dimens.RADIUS_10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: Dimens.PADDING_20),
          child: TextFormField(
            controller: controllerName,
            obscureText: _isObscure.value,
            style: AppTextStyle.style(
              color: Colors.black.withOpacity(0.8),
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscure.value ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    _isObscure.value = !_isObscure.value;
                  },
                ),
                labelText: labelText,
                labelStyle: AppTextStyle.titleSmall),
          ),
        ),
      ),
    );
  }
}

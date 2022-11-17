import 'package:flutter/material.dart';
import 'package:gia_su_trung_tam_mobile/theme/colors.dart';
import 'package:gia_su_trung_tam_mobile/theme/dimens.dart';
import 'package:gia_su_trung_tam_mobile/widget/text_style.dart';

class AppTextField extends StatelessWidget {
  AppTextField(
      {Key? key,
      required this.labelText,
      required this.enabled,
      required this.obscureText,
      required this.controllerName,
      this.keyboardType = TextInputType.text})
      : super(key: key);

  final String labelText;
  final bool obscureText;
  final bool enabled;
  TextEditingController controllerName;
  TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightgray,
        borderRadius: BorderRadius.circular(Dimens.RADIUS_10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: Dimens.PADDING_20),
        child: TextFormField(
          keyboardType: keyboardType,
          enabled: enabled,
          controller: controllerName,
          obscureText: obscureText,
          style: enabled
              ? AppTextStyle.style(
                  color: Colors.black.withOpacity(0.8),
                )
              : AppTextStyle.titleSmall,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: labelText,
            labelStyle: AppTextStyle.titleSmall,
          ),
        ),
      ),
    );
  }
}

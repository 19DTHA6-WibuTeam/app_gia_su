import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class RoundAvatar extends StatefulWidget {
  String imagePath;
  double leftPadding;
  double topPadding;
  double rightPadding;
  double bottomPadding;
  double radius;
  bool initAvatar;

  RoundAvatar(
      {Key? key,
      required this.imagePath,
      required this.leftPadding,
      required this.topPadding,
      required this.rightPadding,
      required this.bottomPadding,
      required this.radius,
      required this.initAvatar})
      : super(key: key);

  @override
  State<RoundAvatar> createState() => _RoundAvatarState();
}

class _RoundAvatarState extends State<RoundAvatar> {
  @override
  Widget build(BuildContext context) {
    String imagePath = widget.imagePath;
    double leftPadding = widget.leftPadding;
    double topPadding = widget.topPadding;
    double rightPadding = widget.rightPadding;
    double bottomPadding = widget.bottomPadding;
    double radius = widget.radius;
    bool initAvatar = widget.initAvatar;

    return Padding(
      padding: EdgeInsets.fromLTRB(
          leftPadding, topPadding, rightPadding, bottomPadding),
      child: initAvatar
          ? CircleAvatar(
              radius: radius,
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(imagePath),
            )
          : CircleAvatar(
              radius: radius,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(imagePath),
            ),
    );
  }
}

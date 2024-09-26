import 'package:flutter/material.dart';
import '../constants/color_constant.dart';

class UserButtonWidget extends StatelessWidget{
  final String text;
  final VoidCallback onClicked;

  const UserButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

    @override
    Widget build(BuildContext context) => ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        backgroundColor: ColorConstant.themeColor,
        foregroundColor: ColorConstant.colorTextWhite,
        shape: const StadiumBorder(),
      ),
      onPressed: onClicked,
      child: FittedBox(
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 20,
          ),
        ),
      ),
    );
}
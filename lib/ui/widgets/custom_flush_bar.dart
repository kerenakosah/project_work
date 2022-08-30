import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:projectwork/index.dart';

Future<dynamic> showCustomFlushBar({
  required context,
  String? messageText,
  String? title,
  String? message,
  Color? backgroundColor,
  Color? titleColor,
  Color? iconColor,
  Color? messageColor,
  double? iconSize,
  double? messageSize,
  double? titleSize,
  IconData? icon,
  Widget? titleText,
  Duration? duration,
  bool shouldIconPulse = true,
  double borderWidth = 1.0,
  Color? borderColor,
  BorderRadius? borderRadius,
  EdgeInsets padding = const EdgeInsets.all(16.0),
  EdgeInsets margin = const EdgeInsets.all(0.0),
}) {
  return Flushbar(
    title: title,
    message: message,
    messageText: Center(
      child: CustomTextWidget(
        text: messageText ?? "There was an error",
        color: messageColor ?? BrandColors.kColorWhiteAccent,
        textAlign: TextAlign.start,
        maxLines: 3,
      ),
    ),
    titleSize: titleSize ?? 18.0,
    titleColor: titleColor ?? BrandColors.kColorWhiteAccent,
    backgroundColor: backgroundColor ?? BrandColors.primaryColor,
    messageColor: messageColor ?? BrandColors.kGrayWhite,
    shouldIconPulse: shouldIconPulse,
    borderWidth: borderWidth,
    borderColor: borderColor,
    borderRadius: borderRadius,
    margin: margin,
    padding: padding,
    icon: Icon(
      icon ?? LineAwesomeIcons.exclamation_circle,
      color: iconColor ?? BrandColors.kColorWhiteAccent,
      size: iconSize,
    ),
    duration: duration ?? const Duration(seconds: 5),
  ).show(context);
}

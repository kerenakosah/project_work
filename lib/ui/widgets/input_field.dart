import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:projectwork/index.dart';

class InputField extends ConsumerWidget {
  final String title;
  final IconData? icon;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  final bool? obscureText;
  final void Function()? onTap;
  final TextInputType? keyboardType;

  const InputField({
    Key? key,
    this.icon,
    required this.title,
    this.controller,
    this.suffixIcon,
    this.obscureText,
    this.onTap,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeController = ref.watch(themeProvider);
    return Container(
      width: 296.0,
      height: 53.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        border: Border.all(
          color: BrandColors.kStrokeColor,
          width: 2.0,
          style: BorderStyle.solid,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 60.0,
            child: icon != null
                ? Icon(
                    icon,
                    size: 20.0,
                    color: BrandColors.kStrokeColor,
                  )
                : Container(),
          ),
          Expanded(
            child: TextField(
              textAlign: TextAlign.start,
              controller: controller,
              obscuringCharacter: '*',
              obscureText: obscureText ?? false,
              keyboardType: keyboardType ?? TextInputType.text,
              keyboardAppearance: themeController.lightTheme ? Brightness.light : Brightness.dark,
              decoration: InputDecoration(
                hintText: title,
                border: InputBorder.none,
              ),
            ),
          ),
          suffixIcon != null
              ? GestureDetector(
                  onTap: onTap,
                  child: SizedBox(
                    width: 60.0,
                    child: Icon(
                      suffixIcon,
                      size: 20.0,
                      color: BrandColors.kStrokeColor,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

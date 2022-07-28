import 'package:flutter/material.dart';
import 'package:projectwork/index.dart';

class InputField extends StatelessWidget {
  final String title;
  final IconData? icon;

  const InputField({
    Key? key,
    this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              decoration: InputDecoration(
                hintText: title,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

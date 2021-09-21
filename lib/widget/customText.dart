import 'package:flutter/material.dart';

class CustomText extends Text {

  CustomText(String data, {color: Colors.white, textAlign: TextAlign.center, factor: 1.0, fontWeight: FontWeight.w400}) :
    super(
      data,
      textAlign: textAlign,
      textScaleFactor: factor,
      style: new TextStyle(color: color, fontWeight: fontWeight)
    );

}

import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  const SmallText(this.text,{super.key, this.color, this.fontSize, this.fontWeight, this.textAlign});
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(color: color,fontSize: fontSize??12,fontWeight: fontWeight),textAlign: textAlign,);
  }
}

class NormalText extends StatelessWidget {
  const NormalText(this.text,{super.key, this.color, this.fontSize, this.fontWeight, this.textAlign});
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(color: color,fontSize: fontSize,fontWeight: fontWeight),textAlign: textAlign,);
  }
}

class NormalHeadingText extends StatelessWidget {
  const NormalHeadingText(this.text,{super.key, this.color, this.fontSize, this.fontWeight, this.textAlign});
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(color: color,fontSize: fontSize,fontWeight: fontWeight??FontWeight.w600),textAlign: textAlign,);
  }
}
class HeadingText extends StatelessWidget {
  const HeadingText(this.text,{super.key, this.color, this.fontSize, this.fontWeight, this.textAlign});
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(color: color,fontSize: fontSize??16,fontWeight: fontWeight??FontWeight.w600),textAlign: textAlign,);
  }
}

class SemiBigText extends StatelessWidget {
  const SemiBigText(this.text,{super.key, this.color, this.fontSize, this.fontWeight, this.textAlign});
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(color: color,fontSize: fontSize??18,fontWeight: fontWeight??FontWeight.w600),textAlign: textAlign,);
  }
}
class BigText extends StatelessWidget {
  const BigText(this.text,{super.key, this.color, this.fontSize, this.fontWeight, this.textAlign});
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(color: color,fontSize: fontSize??20,fontWeight: fontWeight??FontWeight.w700),textAlign: textAlign,);
  }
}

class LargeText extends StatelessWidget {
  const LargeText(this.text,{super.key, this.color, this.fontSize, this.fontWeight, this.textAlign});
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(color: color,fontSize: fontSize??24,fontWeight: fontWeight??FontWeight.w800),textAlign: textAlign,);
  }
}



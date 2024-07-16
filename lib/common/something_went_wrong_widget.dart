import 'package:flutter/material.dart';
import 'package:weather_app/app_theme/app_colors.dart';
import 'package:weather_app/custom_widgets/custom_text.dart';

class SomethingWentWrongWidget extends StatelessWidget {
  const SomethingWentWrongWidget({super.key, this.center, this.retry, this.msg});
  final dynamic center;
  final Function()? retry;
  final String? msg;
  @override
  Widget build(BuildContext context) {
    return center==null?const HeadingText("Something went wrong"): Center(child: Column(mainAxisSize: MainAxisSize.min,
      children: [
        HeadingText("Something went wrong\n${msg??""}",textAlign: TextAlign.center,),
        SizedBox(height: 16,),
        InkWell(onTap: (){
          if(retry!=null) retry!();
        },child: Container(padding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: AppColors.primary),child: NormalHeadingText("Retry",color: Colors.white,),))
      ],
    ),);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/model_text_two.dart';


class TodayWeather extends StatelessWidget {
  final String title;
  final String iconUrl;
  final String temp;
  final String weather;
  TodayWeather({super.key,
    required this.title,
    required this.iconUrl,
    required this.temp,
    required this.weather });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/6,
      width: MediaQuery.of(context).size.width/4,
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          ModelTextTwo(text: title, size: 15.sp),
          Image.network(
            iconUrl,

          ),
          ModelTextTwo(text: "$temp ", size: 15.sp),
          ModelTextTwo(text: weather, size: 15.sp),
        ],
      ),
    );
  }
}
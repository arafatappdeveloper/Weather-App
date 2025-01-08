import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class ModelTextTwo extends StatelessWidget {
  String text;
  double size;

   ModelTextTwo({super.key,required this.text,required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(text,style:GoogleFonts.oswald(color: Colors.white,fontSize:size ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/Services/api_services.dart';
import 'package:weather_app/utils/model_text_two.dart';

import '../utils/date_time.dart';

class SportsScreen extends StatefulWidget {
  const SportsScreen({super.key});

  @override
  State<SportsScreen> createState() => _SportsScreenState();
}

class _SportsScreenState extends State<SportsScreen> {
  ApiServices _apiServices= ApiServices();
  String city='London';
  Map<String,dynamic>? sportData;
  Future<void> fetchSportdata()async{
   try{
     final data= await _apiServices.SportsNews(city);
     setState(() {
       sportData=data;
     });
   }catch(e){
     print('Something is else$e');
   }

  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSportdata();
  }
  @override
  Widget build(BuildContext context) {
    final double height= MediaQuery.of(context).size.height;
    final double width= MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: ModelTextTwo(text: 'Football', size: 22.sp)
      ),
      body: sportData==null? Center(child: CircularProgressIndicator(),):
      Padding(
        padding:  EdgeInsets.only(left: 10.w, right: 10.w,top: 10.h),
        child:ListView.builder(
          itemCount: sportData!['football'].length,
            itemBuilder: (context,index){
            final sport=sportData!['football'][index];
            return Card(
              color: Colors.blue,
              child: Column(
                children: [
                  ModelTextTwo(text: sport['match'], size: 20.sp),
                  ModelTextTwo(text:  formatedatetime(sport['start']), size: 16.sp),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(left: 6.w),
                        child: Container(
                          height:height/23 ,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r)
                            ),
                            child: Center(
                                child: Padding(
                              padding:  EdgeInsets.all(8.0.r),
                              child: Text('${sport['stadium']}'),
                            ))),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(right: 6.w),
                        child: ModelTextTwo(text: sport['tournament'], size: 14.sp),
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),

                ],
              ),
            );
            }
        )
      ),

    );
  }
}

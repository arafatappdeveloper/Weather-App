import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/Services/api_services.dart';
import 'package:weather_app/Widget/todayweather_widget.dart';
import 'package:weather_app/utils/model_text_two.dart';
import 'package:weather_app/utils/time.dart';

class SevenDaysWeather extends StatefulWidget {
  const SevenDaysWeather({super.key});

  @override
  State<SevenDaysWeather> createState() => _SevenDaysWeatherState();
}

class _SevenDaysWeatherState extends State<SevenDaysWeather> {
  ApiServices _apiServices= ApiServices();
  String city='London';
  Map<String,dynamic>?sevendaysweather;
  Future<void>FetchSevendaysWeather()async{
    try{
      final data= await _apiServices.SevendaysWeather(city);
      setState(() {
        sevendaysweather=data;
      });
    }catch(e){
      print('Something is else$e');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FetchSevendaysWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:ModelTextTwo(text: 'last seven days ', size: 24.sp),
      ),
      body: sevendaysweather==null?Center(child: CircularProgressIndicator(),):
      ListView.builder(
        itemCount: sevendaysweather!['forecast']['forecastday'].length,
          itemBuilder: (context,index){
          final data=sevendaysweather!['forecast']['forecastday'][index];
            return Padding(
              padding:  EdgeInsets.only(left: 8.w,right: 8.w,top: 10.h),
              child: Card(
                  color: Colors.blue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Image.network('http:${data['day']['condition']['icon']}')),
                        Expanded(
                          child: Column(
                            children: [
                             ModelTextTwo(text: data['date'], size: 15.sp),
                              ModelTextTwo(text:'Sunrise: ${data['astro']['sunrise']}', size: 15.sp),
                              ModelTextTwo(text:'Sunset: ${data['astro']['sunset']}', size: 15.sp),
                            ],
                          ),
                        )
                      ],
                    ),
                  Padding(
                    padding:  EdgeInsets.only(left: 8.w,bottom: 8.h),
                    child: ModelTextTwo(text:data['day']['condition']['text'],size: 25.sp,),
                  )
                  ],
                )
              ),
            );
          }
      ),
    );
  }
}

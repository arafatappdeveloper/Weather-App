import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/Services/api_services.dart';
import 'package:weather_app/utils/model_text_two.dart';
import 'package:weather_app/viewmodels/currenweatherscreen.dart';

class SevenDaysWeather extends StatefulWidget {
  String city;
   SevenDaysWeather({super.key,required this.city});

  @override
  State<SevenDaysWeather> createState() => _SevenDaysWeatherState();
}

class _SevenDaysWeatherState extends State<SevenDaysWeather> {
  ApiServices _apiServices= ApiServices();
  Map<String,dynamic>? sevendaysweather;
  Future<void> FetchSevendaysWeather()async{
    try{
      final search= await _apiServices.SevendaysWeather(widget.city);
      setState(() {
        sevendaysweather=search;
      });
    }catch(e){
      print('Something is error $e');
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
          automaticallyImplyLeading: true,

            title: Text('${widget.city} UpComing Weather'),
        ),
      body:sevendaysweather==null?Center(child: CircularProgressIndicator(),) :
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
                          Image.network(
                            'http:${data['day']['condition']['icon']}',
                            fit: BoxFit.contain, // Ensures the image doesn't overflow
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start, // Aligns text to the start
                            children: [
                              ModelTextTwo(text: data['date'], size: 15.sp),
                              ModelTextTwo(text: 'Sunrise: ${data['astro']['sunrise']}', size: 15.sp),
                              ModelTextTwo(text: 'Sunset: ${data['astro']['sunset']}', size: 15.sp),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: 8.w,bottom: 8.h),
                        child: ModelTextTwo(text:data['day']['condition']['text'],size: 22.sp,),
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

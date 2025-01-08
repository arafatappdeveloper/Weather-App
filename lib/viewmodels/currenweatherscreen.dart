import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/Services/api_services.dart';
import 'package:weather_app/Widget/todayweather_widget.dart';
import 'package:weather_app/utils/model_text_two.dart';
import 'package:weather_app/viewmodels/sports_screen.dart';

import '../utils/date_time.dart';
import '../utils/time.dart';

class Currenweatherscreen extends StatefulWidget {
 const Currenweatherscreen({super.key});
  @override
  State<Currenweatherscreen> createState() => _CurrenweatherscreenState();
}

class _CurrenweatherscreenState extends State<Currenweatherscreen> {
  ApiServices _apiServices= ApiServices();
  Map<String,dynamic>? currentweather;
  List? searchweather;
  String city='London';

  Future<void> FetchCurrentWeather()async{
    try{
      final data= await _apiServices.FetchCurrentWeather(city);
      setState(() {
          currentweather= data;
      });
    }catch(e){
   print('Something is error $e');
    }
  }
  Future<void> SearchWeather()async{
    try{
      final search= await _apiServices.SearchWeather(city);
      setState(() {
        searchweather=search;
      });
    }catch(e){
      print('Something is error $e');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FetchCurrentWeather();
    SearchWeather();
  }
  @override
  Widget build(BuildContext context) {
    final double height= MediaQuery.of(context).size.height;
    final double width= MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blue,
        body:currentweather==null?Center(child: CircularProgressIndicator(),) :
        SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.only(left: 10.w, right: 10.w,top: 40.h),
            child: Column(
              children: [
                Center(
                    child: Column(
                      children: [
                        Row(

                          children: [
                            Expanded(child: ModelTextTwo(text: currentweather!['location']['country'], size: 15.sp)),
                            InkWell(
                              onTap: ()async{
                                final newcity =await _showCityInputDialog(context);
                                if(newcity!.isNotEmpty && newcity!=null ){
                                  setState(() {
                                    city=newcity;
                                  });
                                  FetchCurrentWeather();
                                  SearchWeather();
                                }
                              },
                                child: Expanded(
                                    child: Icon(Icons.search,color: Colors.white,size: 30,)))
                          ],
                        ),
                        ModelTextTwo(text: currentweather!['location']['name'], size: 35.sp),
                        Image.network("http:${currentweather!['current']['condition']['icon']}",scale: 1,),
                        ModelTextTwo(text: '${currentweather!['current']['temp_c'].toString()}°C', size: 30.sp),
                        ModelTextTwo(text: currentweather!['current']['condition']['text'], size: 20.sp),
                        ModelTextTwo(text: formatedatetime(currentweather!['current']['last_updated']), size: 10.sp)
                      ],
                    )),
                SizedBox(height: height/20),
          
                Container(
                  height: height/7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amber
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
          
                          children: [
                            Image.network("http:${currentweather!['forecast']['forecastday'][0]['day']['condition']['icon']}",),
                            ModelTextTwo(text:"Humidity :${ currentweather!['current']['humidity']?.toString()}%"??"Absent Now", size: 15.sp),
          
                          ],
                        ),
                      ), // SizedBox(width: width/6,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ModelTextTwo(text:"Wind S : ${ currentweather!['current']['wind_kph']?.toString()} km/h"??"Absent Now", size: 15.sp),
                            ModelTextTwo(text: "Ccloud : ${currentweather!['current']['cloud']?.toString()}%" ?? "Absent now", size: 15.sp),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ModelTextTwo(text:"Wind Dir : ${ currentweather!['current']['wind_dir']?.toString()} "??"Absent Now", size: 15.sp),
                            ModelTextTwo(text: "Tem : ${currentweather!['current']['temp_f']?.toString()} F" ?? "Absent now", size: 15.sp),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height/20),
                ModelTextTwo(text: 'Todays Forecast Weather', size: 20.sp),
                SizedBox(height: height/40),
                Container(
                  height: height/5,
                  child: ListView.builder(
                    itemCount:currentweather!['forecast']['forecastday'][0]['hour'].length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                      final weather=currentweather!['forecast']['forecastday'][0]['hour'][index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TodayWeather(
                            title: formateTime(weather['time']),
                            iconUrl: 'http:${weather['condition']['icon']}',
                            temp: '${weather['temp_c']}°C',
                            weather: '${weather['humidity'].toString()}'),
                      );
                    },

                  ),
                )
              ],
            ),
          ),
        ),

    );
  }
  Future<String?> _showCityInputDialog(BuildContext context) async {
    String? cityName;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Enter City Name'),
        content: TextField(
          onChanged: (value) {
            cityName = value;
          },
          decoration: InputDecoration(hintText: 'City Name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
    return cityName;
  }
}

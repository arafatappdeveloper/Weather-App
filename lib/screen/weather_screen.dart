import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/Services/api_services.dart';
import 'package:weather_app/uri/model_text.dart';
import 'package:weather_app/uri/model_text_two.dart';
import 'package:weather_app/uri/today_weather.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  ApiServices _apiServices = ApiServices();
  Map<String, dynamic>? weatherData;
  String city="London";
  Future<void> fetchWeather()async{
    try{
    final data = await _apiServices.FetchCurrentWeather(city);
    setState(() {
      weatherData=data;
    });
    }catch(e){
      print("Error fetching weather: $e");
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    final double height= MediaQuery.of(context).size.height;
    final double width= MediaQuery.of(context).size.width;
    return Scaffold(
    backgroundColor: Colors.indigo[400],
      body:weatherData==null?Center(child: CircularProgressIndicator()):
      Padding(
        padding: EdgeInsets.only(left: 15.w,right: 15.w,top: 35.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ModelText(text: weatherData!['location']['country'], size: 15.sp),
              ],
            ),
             ModelText(text: weatherData!['location']['name'], size: 25.sp),
             ModelText(text: "${weatherData!['current']['temp_c']}°C", size: 50.sp),

            Image.network("http:${weatherData!['current']['condition']['icon']}",
              fit: BoxFit.cover,height: height/7,),
            Row(
           mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ModelText(text: "${weatherData!['location']['localtime'].split(' ')[0]}", size: 15.sp),
             SizedBox(
               width: 10.w,
             ),
              ModelText(text: "${weatherData!['location']['localtime'].split(' ')[1]}", size: 15.sp),
            ],
          ),

            SizedBox(
              height: height/23,
            ),
            Container(
              height:height/6 ,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18.r)
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.network("http:${weatherData!['forecast']['forecastday'][0]['day']['condition']['icon']}",),
                      ModelTextTwo(text:"${ weatherData!['current']['humidity']?.toString()}%"??"Absent Now", size: 15.sp),
                      ModelTextTwo(text:"${ weatherData!['current']['wind_kph']?.toString()} km/h"??"Absent Now", size: 15.sp),
                      ModelTextTwo(text: "${weatherData!['current']['cloud']?.toString()}%" ?? "Absent now", size: 15.sp),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ModelTextTwo(text:"${ weatherData!['forecast']['forecastday'][0]['day']['condition']['text']}", size: 15.sp),
                      ModelTextTwo(text:'Humadity', size: 15.sp),
                      ModelTextTwo(text:'Wind Speeds', size: 15.sp),
                      ModelTextTwo(text:'Colud', size: 15.sp),
                    ],
                  ),
                ],
              ),

            ),
            SizedBox(
              height: height/17,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ModelText(text: 'Today', size: 20.sp),
              ],
            ),
            SizedBox(
              height: 35.h,
            ),
            Container(
              height: height/5,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  TodayWeather(
                      title: "${weatherData!['forecast']['forecastday'][0]['hour'][0]['time'].split(' ')[1]}",
                      iconUrl: "http:${weatherData!['forecast']['forecastday'][0]['hour'][0]['condition']['icon']}",
                      temp: "${weatherData!['forecast']['forecastday'][0]['hour'][0]['temp_c']} °C",
                      weather: "${ weatherData!['forecast']['forecastday'][0]['hour'][0]['condition']['text']}"),
                  SizedBox(
                    width: width/20,
                  ),
                  TodayWeather(
                      title: "${weatherData!['forecast']['forecastday'][0]['hour'][1]['time'].split(' ')[1]}",
                      iconUrl: "http:${weatherData!['forecast']['forecastday'][0]['hour'][1]['condition']['icon']}",
                      temp: "${weatherData!['forecast']['forecastday'][0]['hour'][1]['temp_c']} °C",
                      weather: "${ weatherData!['forecast']['forecastday'][0]['hour'][1]['condition']['text']}"),
                  SizedBox(
                    width: width/20,
                  ),
                  TodayWeather(
                      title: "${weatherData!['forecast']['forecastday'][0]['hour'][2]['time'].split(' ')[1]}",
                      iconUrl: "http:${weatherData!['forecast']['forecastday'][0]['hour'][2]['condition']['icon']}",
                      temp: "${weatherData!['forecast']['forecastday'][0]['hour'][2]['temp_c']} °C",
                      weather: "${ weatherData!['forecast']['forecastday'][0]['hour'][2]['condition']['text']}"),
                  SizedBox(
                    width: width/20,
                  ),
                  TodayWeather(
                      title: "${weatherData!['forecast']['forecastday'][0]['hour'][3]['time'].split(' ')[1]}",
                      iconUrl: "http:${weatherData!['forecast']['forecastday'][0]['hour'][3]['condition']['icon']}",
                      temp: "${weatherData!['forecast']['forecastday'][0]['hour'][3]['temp_c']} °C",
                      weather: "${ weatherData!['forecast']['forecastday'][0]['hour'][3]['condition']['text']}"),
                  SizedBox(
                    width: width/20,
                  ),
                  TodayWeather(
                      title: "${weatherData!['forecast']['forecastday'][0]['hour'][4]['time'].split(' ')[1]}",
                      iconUrl: "http:${weatherData!['forecast']['forecastday'][0]['hour'][4]['condition']['icon']}",
                      temp: "${weatherData!['forecast']['forecastday'][0]['hour'][4]['temp_c']} °C",
                      weather: "${ weatherData!['forecast']['forecastday'][0]['hour'][4]['condition']['text']}"),
                  SizedBox(
                    width: width/20,
                  ),
                  TodayWeather(
                      title: "${weatherData!['forecast']['forecastday'][0]['hour'][5]['time'].split(' ')[1]}",
                      iconUrl: "http:${weatherData!['forecast']['forecastday'][0]['hour'][5]['condition']['icon']}",
                      temp: "${weatherData!['forecast']['forecastday'][0]['hour'][5]['temp_c']} °C",
                      weather: "${ weatherData!['forecast']['forecastday'][0]['hour'][5]['condition']['text']}"),
                  SizedBox(
                    width: width/20,
                  ),
                  TodayWeather(
                      title: "${weatherData!['forecast']['forecastday'][0]['hour'][6]['time'].split(' ')[1]}",
                      iconUrl: "http:${weatherData!['forecast']['forecastday'][0]['hour'][6]['condition']['icon']}",
                      temp: "${weatherData!['forecast']['forecastday'][0]['hour'][6]['temp_c']} °C",
                      weather: "${ weatherData!['forecast']['forecastday'][0]['hour'][6]['condition']['text']}"),
                  SizedBox(
                    width: width/20,
                  ),
                  TodayWeather(
                      title: "${weatherData!['forecast']['forecastday'][0]['hour'][7]['time'].split(' ')[1]}",
                      iconUrl: "http:${weatherData!['forecast']['forecastday'][0]['hour'][7]['condition']['icon']}",
                      temp: "${weatherData!['forecast']['forecastday'][0]['hour'][7]['temp_c']} °C",
                      weather: "${ weatherData!['forecast']['forecastday'][0]['hour'][7]['condition']['text']}"),
                  SizedBox(
                    width: width/20,
                  ),
                  TodayWeather(
                      title: "${weatherData!['forecast']['forecastday'][0]['hour'][8]['time'].split(' ')[1]}",
                      iconUrl: "http:${weatherData!['forecast']['forecastday'][0]['hour'][8]['condition']['icon']}",
                      temp: "${weatherData!['forecast']['forecastday'][0]['hour'][8]['temp_c']} °C",
                      weather: "${ weatherData!['forecast']['forecastday'][0]['hour'][8]['condition']['text']}"),
                  SizedBox(
                    width: width/20,
                  ),
                  TodayWeather(
                      title: "${weatherData!['forecast']['forecastday'][0]['hour'][9]['time'].split(' ')[1]}",
                      iconUrl: "http:${weatherData!['forecast']['forecastday'][0]['hour'][9]['condition']['icon']}",
                      temp: "${weatherData!['forecast']['forecastday'][0]['hour'][9]['temp_c']} °C",
                      weather: "${ weatherData!['forecast']['forecastday'][0]['hour'][9]['condition']['text']}"),
                  SizedBox(
                    width: width/20,
                  ),
                  TodayWeather(
                      title: "${weatherData!['forecast']['forecastday'][0]['hour'][10]['time'].split(' ')[1]}",
                      iconUrl: "http:${weatherData!['forecast']['forecastday'][0]['hour'][10]['condition']['icon']}",
                      temp: "${weatherData!['forecast']['forecastday'][0]['hour'][10]['temp_c']} °C",
                      weather: "${ weatherData!['forecast']['forecastday'][0]['hour'][10]['condition']['text']}"),
                  SizedBox(
                    width: width/20,
                  ),
                  TodayWeather(
                      title: "${weatherData!['forecast']['forecastday'][0]['hour'][11]['time'].split(' ')[1]}",
                      iconUrl: "http:${weatherData!['forecast']['forecastday'][0]['hour'][11]['condition']['icon']}",
                      temp: "${weatherData!['forecast']['forecastday'][0]['hour'][11]['temp_c']} °C",
                      weather: "${ weatherData!['forecast']['forecastday'][0]['hour'][11]['condition']['text']}"),
                  SizedBox(
                    width: width/20,
                  ),
                  TodayWeather(
                      title: "${weatherData!['forecast']['forecastday'][0]['hour'][12]['time'].split(' ')[1]}",
                      iconUrl: "http:${weatherData!['forecast']['forecastday'][0]['hour'][12]['condition']['icon']}",
                      temp: "${weatherData!['forecast']['forecastday'][0]['hour'][12]['temp_c']} °C",
                      weather: "${ weatherData!['forecast']['forecastday'][0]['hour'][12]['condition']['text']}"),
                  SizedBox(
                    width: width/20,
                  ),
                  TodayWeather(
                      title: "${weatherData!['forecast']['forecastday'][0]['hour'][13]['time'].split(' ')[1]}",
                      iconUrl: "http:${weatherData!['forecast']['forecastday'][0]['hour'][13]['condition']['icon']}",
                      temp: "${weatherData!['forecast']['forecastday'][0]['hour'][13]['temp_c']} °C",
                      weather: "${ weatherData!['forecast']['forecastday'][0]['hour'][13]['condition']['text']}"),
                  SizedBox(
                    width: width/20,
                  ),
                ],
              ),
            )

          ],
        ),
          )
    );
  }
}

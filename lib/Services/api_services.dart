import 'dart:convert'; // For JSON decoding
import 'package:http/http.dart' as http;


class ApiServices{
  final String apiKey="ba319d5e3abd4a709af204027242912";
  final String forecastbaseUrl="http://api.weatherapi.com/v1/forecast.json";
  final String searchUrl= 'http://api.weatherapi.com/v1/search.json';
  final String sports='http://api.weatherapi.com/v1/sports.json';

//forecast weather
  Future<Map<String,dynamic>> FetchCurrentWeather(String city)async{
    final url = "$forecastbaseUrl?key=$apiKey&q=$city&days=1&aqi=no&alerts=no";
    final response = await http.get(Uri.parse(url));
    if(response.statusCode==200){
      return json.decode(response.body);
    }else{
      throw Exception('Error fetching weather data: ');
    }
  }

//search weather
  Future<List> SearchWeather(String city)async{
    final url = "$searchUrl?key=$apiKey&q=$city";
    final response = await http.get(Uri.parse(url));
    if(response.statusCode==200){
      return json.decode(response.body);
    }else{
      throw Exception('Error fetching weather data: ');
    }
  }

 //sport

Future<Map<String,dynamic>> SportsNews(String city)async{
    final url= '$sports?key=$apiKey&q=$city';
    final response= await http.get(Uri.parse(url));
    if(response.statusCode==200){
      return json.decode(response.body);
    }else{
      throw Exception('Error fetching weather Data');
    }
}

//7days weather
Future<Map<String,dynamic>>SevendaysWeather(String city)async{
  final url = "$forecastbaseUrl?key=$apiKey&q=$city&days=7&aqi=no&alerts=no";
  final response = await http.get(Uri.parse(url));
  if(response.statusCode==200){
    return json.decode(response.body);
  }else{
    throw Exception('Someting is else');
  }
}
}
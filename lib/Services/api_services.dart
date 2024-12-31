import 'dart:convert'; // For JSON decoding
import 'package:http/http.dart' as http; // Import http package
class ApiServices{
  final String apiKey="ba319d5e3abd4a709af204027242912";
  final String forecastbaseUrl="http://api.weatherapi.com/v1/forecast.json";
  final String searchUrl="http://api.weatherapi.com/v1//search.json";


  Future<Map<String,dynamic>> FetchCurrentWeather(String city)async{
       final url = "$forecastbaseUrl?key=$apiKey&q=$city&days=1&aqi=no&alerts=no";
       final response = await http.get(Uri.parse(url));
       if(response.statusCode==200){
         return json.decode(response.body);
       }else{
         throw Exception('Error fetching weather data: ');
       }
  }

  //for seven days
  Future<Map<String,dynamic>> Fetch7daysWeather(String city)async{
    final url = "$forecastbaseUrl?key=$apiKey&q=$city&days=7&aqi=no&alerts=no";
    final response = await http.get(Uri.parse(url));
    if(response.statusCode==200){
      return json.decode(response.body);
    }else{
      throw Exception('Error fetching weather data: ');
    }
  }

  //for city suggestion
  Future<Map<String,dynamic>> FetchCitysuggestion(String quiry)async{
    final url = "$searchUrl?key=$apiKey&q=$quiry";
    final response = await http.get(Uri.parse(url));
    if(response.statusCode==200){
      return json.decode(response.body);
    }else{
      throw Exception('Error fetching weather data: ');
    }
  }
}
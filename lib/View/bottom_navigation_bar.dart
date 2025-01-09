import 'package:flutter/material.dart';
import 'package:weather_app/viewmodels/currenweatherscreen.dart';

import '../viewmodels/seven_days_weather.dart';
import '../viewmodels/sports_screen.dart';

class BottomNBavigationbar extends StatefulWidget {
  const BottomNBavigationbar({super.key});

  @override
  State<BottomNBavigationbar> createState() => _BottomNBavigationbarState();
}

class _BottomNBavigationbarState extends State<BottomNBavigationbar> {
  int _selectedIndex=1;
  static const List<Widget>_widgetlist=[

    Currenweatherscreen(),
    SportsScreen()
  ];

  void _ontapped(int index)async{
    setState(() {
      _selectedIndex=index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetlist.elementAt(_selectedIndex)
      ),
         bottomNavigationBar: BottomNavigationBar(
           currentIndex: _selectedIndex,
             onTap: _ontapped,
             selectedItemColor: Colors.amber[800],
             items: [

               BottomNavigationBarItem(
                 icon: Icon(Icons.cloud_circle),
                 label: 'Weather',
               ),
               BottomNavigationBarItem(
                 icon: Icon(Icons.games),
                 label: 'Sports',
               ),
             ]),
    );
  }
}

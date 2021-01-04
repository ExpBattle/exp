import 'dart:developer' as developer;
import 'dart:math';
import 'package:exp/history_tab.dart';
import 'package:exp/summary_tab.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:moneytextformfield/moneytextformfield.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'profile_tab.dart';
import 'Expense.dart';
import 'Summary.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
  
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  static Summary summary = Summary();
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentIndex = 0;
  final List<Widget> _children = <Widget>[
    SummaryTab(),
    HistoryTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exp'),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      onTap: onTabTapped,
      currentIndex: _currentIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'User',
        ),
      ],
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

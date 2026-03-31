import 'package:flutter/material.dart';
import 'package:smart_attendance_app/models/user.dart';
import 'package:smart_attendance_app/screens/home_screen.dart';
import 'package:smart_attendance_app/screens/qr_code_screen.dart';
import 'package:smart_attendance_app/screens/history_screen.dart';

class MainNavigationWidget extends StatefulWidget {
  final User user;

  const MainNavigationWidget({Key? key, required this.user}) : super(key: key);

  @override
  State<MainNavigationWidget> createState() => _MainNavigationWidgetState();
}

class _MainNavigationWidgetState extends State<MainNavigationWidget> {
  int _selectedIndex = 0;

  late final List<Widget> _screens = [
    HomeScreen(user: widget.user),
    QRCodeScreen(user: widget.user),
    HistoryScreen(user: widget.user),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_2),
            label: 'QR Code',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.blue[700],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.blue[200],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:smart_attendance_app/models/user.dart';
import 'package:smart_attendance_app/services/qr_code_service.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String qrCodeData;
  late String qrCodeId;

  @override
  void initState() {
    super.initState();
    _generateQRCode();
  }

  void _generateQRCode() {
    qrCodeData = QRCodeService.generateQRCode(widget.user.id);
    qrCodeId = QRCodeService.generateQRCodeId(widget.user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Attendance'),
        elevation: 0,
        backgroundColor: Colors.blue[700],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Info Card
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User Information',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      ListTile(
                        title: const Text('Name'),
                        subtitle: Text(widget.user.name),
                        leading: const Icon(Icons.person),
                      ),
                      ListTile(
                        title: const Text('Email'),
                        subtitle: Text(widget.user.email),
                        leading: const Icon(Icons.email),
                      ),
                      ListTile(
                        title: const Text('Role'),
                        subtitle: Text(widget.user.role.toUpperCase()),
                        leading: const Icon(Icons.badge),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Attendance Actions
              Text(
                'Quick Actions',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),

              // Check-In Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _navigateToCheckIn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.login),
                      SizedBox(width: 8),
                      Text('Check In', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Check-Out Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _navigateToCheckOut,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout),
                      SizedBox(width: 8),
                      Text('Check Out', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // View History Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _navigateToHistory,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.history),
                      SizedBox(width: 8),
                      Text('View History', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToCheckIn() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Check In: Feature coming soon')),
    );
  }

  void _navigateToCheckOut() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Check Out: Feature coming soon')),
    );
  }

  void _navigateToHistory() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('View History: Feature coming soon')),
    );
  }
}

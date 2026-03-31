import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:smart_attendance_app/models/user.dart';
import 'package:smart_attendance_app/services/qr_code_service.dart';

class QRCodeScreen extends StatefulWidget {
  final User user;

  const QRCodeScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  late String qrCodeData;
  late String qrCodeId;

  @override
  void initState() {
    super.initState();
    _generateQRCode();
  }

  void _generateQRCode() {
    setState(() {
      qrCodeData = QRCodeService.generateQRCode(widget.user.id);
      qrCodeId = QRCodeService.generateQRCodeId(widget.user.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My QR Code'),
        elevation: 0,
        backgroundColor: Colors.blue[700],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          '${widget.user.name}\'s QR Code',
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        // QR Code
                        QrImageView(
                          data: qrCodeData,
                          version: QrVersions.auto,
                          size: 250.0,
                          embeddedImage: null,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'QR Code ID:',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          qrCodeId,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(fontFamily: 'monospace'),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _generateQRCode,
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.refresh),
                              SizedBox(width: 8),
                              Text('Refresh QR Code'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

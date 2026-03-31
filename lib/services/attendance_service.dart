import 'package:smart_attendance_app/models/attendance.dart';
import 'package:smart_attendance_app/models/user.dart';

class AttendanceService {
  final List<Attendance> _attendanceRecords = [];

  /// Mark attendance for a user
  Future<Attendance> markAttendance({
    required String userId,
    required double latitude,
    required double longitude,
    required String qrCode,
  }) async {
    final attendance = Attendance(
      id: '${userId}_${DateTime.now().millisecondsSinceEpoch}',
      userId: userId,
      checkInTime: DateTime.now(),
      latitude: latitude,
      longitude: longitude,
      qrCode: qrCode,
    );

    _attendanceRecords.add(attendance);
    return attendance;
  }

  /// Get all attendance records
  List<Attendance> getAttendanceRecords() {
    return List.from(_attendanceRecords);
  }

  /// Get attendance for specific user
  List<Attendance> getUserAttendance(String userId) {
    return _attendanceRecords
        .where((record) => record.userId == userId)
        .toList();
  }

  /// Mark check-out time
  Future<void> markCheckOut(String attendanceId) async {
    final index = _attendanceRecords.indexWhere(
      (record) => record.id == attendanceId,
    );
    if (index != -1) {
      final oldRecord = _attendanceRecords[index];
      final newRecord = Attendance(
        id: oldRecord.id,
        userId: oldRecord.userId,
        checkInTime: oldRecord.checkInTime,
        checkOutTime: DateTime.now(),
        latitude: oldRecord.latitude,
        longitude: oldRecord.longitude,
        qrCode: oldRecord.qrCode,
      );
      _attendanceRecords[index] = newRecord;
    }
  }
}

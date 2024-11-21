// import 'package:tcc_app/models/attendance.dart';
import 'package:tcc_app/models/guardian.dart';
import 'package:tcc_app/models/student.dart';

// class StudentExit extends Attendance {
//   final String guardians;

//   const StudentExit({
//     required super.name,
//     required super.date,
//     required super.type,
//     required this.guardians,
//   });
// }

class StudentExit {
  int id;
  int studentId;
  int guardianId;
  DateTime exitAt;
  DateTime createdAt;
  DateTime updatedAt;
  Student student;
  Guardian guardian;

  StudentExit({
    required this.id,
    required this.studentId,
    required this.guardianId,
    required this.exitAt,
    required this.createdAt,
    required this.updatedAt,
    required this.student,
    required this.guardian,
  });

  factory StudentExit.fromJson(Map<String, dynamic> json) {
    return StudentExit(
      id: json['id'],
      studentId: json['student_id'],
      guardianId: json['guardian_id'],
      exitAt: DateTime.parse(json['exit_at']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      student: Student.fromJson(json['student']),
      guardian: Guardian.fromJson(json['guardian']),
    );
  }
}

import 'dart:convert';

class NotificationCustom {
  late int projectId;
  late String message;
  late String doerUsername;

  NotificationCustom({
    required this.projectId,
    required this.message,
    required this.doerUsername,
  });

  factory NotificationCustom.fromJson(Map<String, dynamic> map) {
    return NotificationCustom(
        projectId: map['projectId'],
        message: map['message'],
        doerUsername: map['doerUsername']
    );
  }

  @override
  String toString() => '🔔 $message';
}
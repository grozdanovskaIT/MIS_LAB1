import 'package:flutter/material.dart';
import '../models/exam.dart';

class ExamDetailScreen extends StatelessWidget {
  final Exam exam;

  const ExamDetailScreen({
    super.key,
    required this.exam,
  });

  @override
  Widget build(BuildContext context) {
    final isPast = exam.isPast;
    final duration = _calculateDuration();

    const calendarColor = Color(0xFFBDBDBD);
    const timeColor = Color(0xFFF06292);
    const locationColor = Color(0xFFC2185B);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Детали за испит',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: isPast 
            ? const Color(0xFF9E9E9E) 
            : const Color(0xFFEC407A),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exam.subjectName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 32),
            _buildDetailRow(
              icon: Icons.calendar_today,
              label: 'Датум',
              value: _formatDate(exam.dateTime),
              iconColor: calendarColor,
            ),
            const SizedBox(height: 20),
            _buildDetailRow(
              icon: Icons.access_time,
              label: 'Време',
              value: _formatTime(exam.dateTime),
              iconColor: timeColor,
            ),
            const SizedBox(height: 20),
            _buildDetailRow(
              icon: Icons.location_on,
              label: 'Простории',
              value: exam.rooms.join(', '),
              iconColor: locationColor,
            ),
            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isPast 
                    ? Color(0xFFF7F7F7)
                    : Color(0xFFFDE7F3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isPast 
                      ? Color(0xFFD6D6D6)
                      : const Color(0xFFF48FB1),
                  width: 2,
                ),
              ),
              child: Text(
                isPast
                    ? 'Испитот веќе помина.'
                    : 'До испитот остануваат: ${duration['days']} дена, ${duration['hours']} часа',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isPast 
                      ? Color(0xFF757575)
                      : const Color(0xFFAD1457),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 24,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime dateTime) {
    return '${dateTime.day}.${dateTime.month}.${dateTime.year}';
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  Map<String, int> _calculateDuration() {
    final now = DateTime.now();
    final examDate = exam.dateTime;

    if (examDate.isBefore(now)) {
      return {'days': 0, 'hours': 0};
    }

    final difference = examDate.difference(now);
    final days = difference.inDays;
    final hours = difference.inHours - (days * 24);

    return {
      'days': days,
      'hours': hours,
    };
  }
}


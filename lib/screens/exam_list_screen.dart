import 'package:flutter/material.dart';
import '../models/exam.dart';
import '../widgets/exam_card.dart';
import '../widgets/exam_count_badge.dart';
import '../data/exam_data.dart';
import 'exam_detail_screen.dart';

class ExamListScreen extends StatelessWidget {
  final String indexNumber;

  const ExamListScreen({
    super.key,
    this.indexNumber = '221103',
  });

  @override
  Widget build(BuildContext context) {
    final exams = ExamData.exams;
    final sortedExams = List<Exam>.from(exams)
      ..sort((a, b) => a.dateTime.compareTo(b.dateTime));

    if (sortedExams.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Распоред за испити - $indexNumber',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: const Color(0xFF0D47A1),
          elevation: 0,
        ),
        body: const Center(
          child: Text('Нема достапни испити'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Распоред за испити - $indexNumber',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFC2185B), 
        elevation: 0,
      ),
      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: sortedExams.length,
            itemBuilder: (context, index) {
              return ExamCard(
                exam: sortedExams[index],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExamDetailScreen(
                        exam: sortedExams[index],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          ExamCountBadge(count: sortedExams.length),
        ],
      ),
    );
  }
}


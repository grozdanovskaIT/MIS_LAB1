class Exam {
  final String subjectName;
  final DateTime dateTime;
  final List<String> rooms;

  const Exam({
    required this.subjectName,
    required this.dateTime,
    required this.rooms,
  });

  bool get isPast {
    return dateTime.isBefore(DateTime.now());
  }

  bool get isFuture {
    return dateTime.isAfter(DateTime.now());
  }
}


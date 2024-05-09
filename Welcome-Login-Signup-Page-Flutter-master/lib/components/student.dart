class Student {
  final String key;
  final String id;
  final String firstName;
  final String lastName;
  final String course;
  final String present;
  final String absent;
  bool selected = false;

  Student(
    {
      this.key,
      this.id,
      this.firstName,
      this.lastName,
      this.course,
      this.present,
      this.absent
    }
  );

  double computeGrade() {
    return double.parse(present) / (double.tryParse(present) + double.tryParse(absent));
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      key: json['key_stud'] as String,
      id: json['id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      course: json['course'] as String,
      present: json['presents'] as String,
      absent: json['absents'] as String,
    );
  }

}
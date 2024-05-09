class Student {
  String id;
  String firstName;
  String lastName;
  String course;

  Student({required this.id, required this.firstName, required this.lastName, required this.course});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      course: json['course'] as String,
    );
  }
}
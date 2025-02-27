class Task {
  final int id;
  final String title;
  final String description;
  final String firstname;
  final String lastname;
  final String email;
  final String phone;
  final String group;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.group,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      firstname: json['firstname'], // เพิ่มฟิลด์ firstname
      lastname: json['lastname'],   // เพิ่มฟิลด์ lastname
      email: json['email'],         // เพิ่มฟิลด์ email
      phone: json['phone'],         // เพิ่มฟิลด์ phone
      group: json['group'],         // เพิ่มฟิลด์ group
    );
  }
}

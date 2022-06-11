class Tutor {
  String? tutor_id;
  String? tutor_email;
  String? tutor_phone;
  String? tutor_name;
  String? tutor_password;
  String? tutor_description;
  String? tutor_datereg;

  Tutor(
      {this.tutor_id,
      this.tutor_email,
      this.tutor_phone,
      this.tutor_name,
      this.tutor_password,
      this.tutor_description,
      this.tutor_datereg});

  Tutor.fromJson(Map<String, dynamic> json) {
    tutor_id = json["tutor_id"];
    tutor_email = json["tutor_email"];
    tutor_phone = json["tutor_phone"];
    tutor_name = json["tutor_name"];
    tutor_password = json["tutor_password"];
    tutor_description = json["tutor_description"];
    tutor_datereg = json["tutor_datereg"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tutorId'] = tutor_id;
    data['tutorEmail'] = tutor_email;
    data['tutorPhone'] = tutor_phone;
    data['TutorName'] = tutor_name;
    data['TutorPassword'] = tutor_password;
    data['TutorDescription'] = tutor_description;
    data['TutorDatereg'] = tutor_datereg;

    return data;
  }
}

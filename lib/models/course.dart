class Course {
  String? subject_id;
  String? subject_name;
  String? subject_description;
  String? subject_price;
  String? tutor_id;
  String? subject_sessions;
  String? subject_rating;

  Course(
      {this.subject_id,
      this.subject_name,
      this.subject_description,
      this.subject_price,
      this.tutor_id,
      this.subject_sessions,
      this.subject_rating});

  Course.fromJson(Map<String, dynamic> json) {
    subject_id = json["subject_id"];
    subject_name = json["subject_name"];
    subject_description = json["subject_description"];
    subject_price = json["subject_price"];
    tutor_id = json["tutor_id"];
    subject_sessions = json["subject_sessions"];
    subject_rating = json["subject_rating"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subjectId'] = subject_id;
    data['subjectName'] = subject_name;
    data['subjectDescription'] = subject_description;
    data['subjectPrice'] = subject_price;
    data['subjectId'] = tutor_id;
    data['subjectSessions'] = subject_sessions;
    data['subjectRating'] = subject_rating;

    return data;
  }
}

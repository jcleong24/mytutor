class Course {
  String? subjectId;
  String? subjectName;
  String? subjectDescription;
  String? subjectPrice;
  String? tutorId;
  String? subjectSessions;
  String? subjectRating;

  Course(
      {this.subjectId,
      this.subjectName,
      this.subjectDescription,
      this.subjectPrice,
      this.tutorId,
      this.subjectSessions,
      this.subjectRating});

  Course.fromJson(Map<String, dynamic> json) {
    subjectId = json['subject_id'];
    subjectName = json['subject_name'];
    subjectDescription = json['subject_description'];
    subjectPrice = json['subject_price'];
    tutorId = json['tutor_id'];
    subjectSessions = json['subject_sessions'];
    subjectRating = json['subject_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subject_id'] = subjectId;
    data['subject_name'] = subjectName;
    data['subject_description'] = subjectDescription;
    data['subject_price'] = subjectPrice;
    data['tutor_id'] = tutorId;
    data['subject_sessions'] = subjectSessions;
    data['subject_rating'] = subjectRating;
    return data;
  }
}

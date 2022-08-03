class Exercise {
  String? title;
  List<dynamic>? rows;
  String? error;

  Exercise({this.title, this.rows});

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(title: json['title'], rows: json['rows']);
  }

  Exercise.withError(String errorMessage) {
    error = errorMessage;
  }
}

class RowsList {
  String? title;
  String? description;
  String? imageHref;

  RowsList({this.title, this.description, this.imageHref});
}

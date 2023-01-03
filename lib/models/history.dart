class HistoryApiResponse {
  List? data;
  List? permission;
  String? name;
  String? error;
  String? description = '';

  HistoryApiResponse({this.description, this.data, this.name, this.permission});

  factory HistoryApiResponse.fromJson(Map<String, dynamic> json) {
    return HistoryApiResponse(
      data: json['presensi'],
      name: json['name'],
      permission: json['permission'],
    );
  }
}

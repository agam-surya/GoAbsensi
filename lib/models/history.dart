class HistoryApiResponse {
  List? data;
  String? name;
  String? error;
  String? description = '';

  HistoryApiResponse({this.description, this.data, this.name});

  factory HistoryApiResponse.fromJson(Map<String, dynamic> json) {
    return HistoryApiResponse(
      data: json['presensi'],
      name: json['name'],
    );
  }
}

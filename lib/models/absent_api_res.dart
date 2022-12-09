class AbsenApiResponse {
  List? data;
  String? error;
  String? description = '';

  AbsenApiResponse({this.description});

  factory AbsenApiResponse.fromJson(Map<String, dynamic> json) {
    return AbsenApiResponse(
      description: json['message'],
    );
  }
}

class SPK {
  List<dynamic>? data;

  SPK({this.data});

  factory SPK.fromJson(Map<String, dynamic> json) {
    return SPK(
      data: json['saw'],
    );
  }
}

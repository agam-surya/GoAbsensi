import 'package:goAbsensi/common/constant.dart';

class Userprofile {
  String name;
  String image;
  String position;
  String phone;
  String address;

  Userprofile(
      {required this.name,
      required this.image,
      required this.phone,
      required this.address,
      required this.position});

  factory Userprofile.fromJson(Map<String, dynamic> json) {
    return Userprofile(
        // ignore: prefer_interpolation_to_compose_strings
        image: '$webUrl/storage/' + json['image'],
        name: json['name'],
        phone: json['phone'],
        address: json['address'],
        position: json['position']);
  }
}

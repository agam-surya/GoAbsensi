class Userprofile {
  String name;
  String image;
  String position;
  String phone;
  String address;

  Userprofile({required this.name, required this.image, required this.phone, required this.address, required this.position});

  factory Userprofile.fromJson(Map<String, dynamic> json) {
    return Userprofile(
        image: json['image'],
        name: json['name'],
        phone: json['phone'],
        address: json['address'],
        position: json['position']);
  }
}

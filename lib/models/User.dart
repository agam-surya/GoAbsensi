class User {
  String? email;
  String? token;
  String? name;
  String? image;
  int? id;

  User({
    this.email,
    this.token,
    this.name,
    this.image,
    this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        email: json['user']['email'],
        token: json['token'],
        id: json['user']['id'],
        image: json['user']['image'],
        name: json['user']['name']);
  }
}

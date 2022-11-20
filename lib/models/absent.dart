class Absent {
  int hadir;
  int izin;
  String description = '';

  Absent({this.hadir = 0, this.izin = 0, this.description = ''});

  factory Absent.fromJson(Map<String, dynamic> json) {
    return Absent(
      hadir: json['hadir'],
      izin: json['izin'],
      description: json['description'],
    );
  }
}

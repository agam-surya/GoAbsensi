part of "common.dart";

const webUrl = 'https://goabsensi-beta-2.000webhostapp.com';
const baseUrl = webUrl + '/api';
const loginUrl = baseUrl + '/login';
const registerUrl = baseUrl + '/register';
const logoutUrl = baseUrl + '/logout';
const userUrl = baseUrl + '/user';
const profileUrl = baseUrl + '/profile';
const presenceCreate = baseUrl + '/presensi/create';
const presenceIn = baseUrl + '/presensi/form_masuk';
const presenceOut = baseUrl + '/presensi/form_keluar';
const presenceShow = baseUrl + '/presensi';
const izinUrl = baseUrl + '/permission-create';
const spkUrl = baseUrl + '/SPK';

// --------ERROR---------
const serverError = 'Server error';
const unauthorized = 'unauthorized';
const somethingwentwrong = 'Something went wrong, Try Again!';

// Input Decoration Form

InputDecoration inputDecoration(String label) {
  return InputDecoration(
      labelText: label,
      contentPadding: EdgeInsets.all(10),
      border: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.black)));
}

// Text Button

TextButton kTextButton(String label, Function onPressed, Color color) {
  return TextButton(
    onPressed: () => onPressed(),
    child: Text(
      label,
      style: TextStyle(color: Colors.white),
    ),
    style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith((states) => color),
        padding: MaterialStateProperty.resolveWith(
            (states) => EdgeInsets.symmetric(vertical: 15))),
  );
}

import 'dart:convert';
import 'dart:io';

import 'package:goAbsensi/services/services.dart';

import '../common/constant.dart';
import '../models/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';

import '../models/user_prof.dart';

Future<ApiResponse> getUserProfile() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(profileUrl),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = Userprofile.fromJson(jsonDecode(response.body));
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingwentwrong;
        break;
    }
  } catch (e) {
    apiResponse.error = e.toString();
  }
  return apiResponse;
}

Future<int> updateImage(File img) async {
  int statusCode = 200;

  try {
    String token = await getToken();
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    // open a bytestream
    var stream = new http.ByteStream(DelegatingStream.typed(img.openRead()));
    // get file length
    var length = await img.length();

    // create multipart request
    var request = new http.MultipartRequest("POST", Uri.parse(profileUrl));

    // multipart that takes file
    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: basename(img.path));
    request.headers.addAll(headers);
    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {});

    // switch (response.statusCode) {
    //   case 200:
    //     apiResponse.data = Userprofile.fromJson(jsonDecode(response.));
    //     break;
    //   case 401:
    //     apiResponse.error = unauthorized;
    //     break;
    //   default:
    //     apiResponse.error = somethingwentwrong;
    //     break;
    // }
  } catch (e) {
    statusCode = 400;
  }
  return statusCode;
}

Future<int> updateProfileData({
  String name = '',
  String phone = '',
  String address = '',
}) async {
  // int apiResponse = int();
  int statusCode = 200;
  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(profileUrl),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: name != ''
            ? {
                "name": name,
              }
            : phone != ''
                ? {
                    "phone": phone,
                  }
                : {
                    "address": address,
                  });

    statusCode = response.statusCode;
    print(response.statusCode);
    // switch (response.statusCode) {
    //   case 200:
    //     // apiResponse.description = '';
    //     break;
    //   case 401:
    //     // apiResponse.error = unauthorized;
    //     break;
    //   default:
    //     // apiResponse.error = somethingwentwrong;
    //     break;
    // }
  } catch (e) {
    // apiResponse.error = serverError;
  }

  return statusCode;
}

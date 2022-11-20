import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_api_test/models/absent.dart';
import 'package:flutter_api_test/models/absent_api_res.dart';
import 'package:flutter_api_test/services/services.dart';

import '../common/constant.dart';

import 'package:http/http.dart' as http;

Future<AbsenApiResponse> showPresence() async {
  AbsenApiResponse apiResponse = AbsenApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(presenceShow),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });
    switch (response.statusCode) {
      case 200:
        apiResponse.description = '';
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingwentwrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }

  return apiResponse;
}


Future<AbsenApiResponse> createPresence() async {
  AbsenApiResponse apiResponse = AbsenApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(presenceCreate),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });
    switch (response.statusCode) {
      case 200:
        apiResponse.description = '';
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingwentwrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }

  return apiResponse;
}

Future<AbsenApiResponse> formMasuk() async {
  AbsenApiResponse apiResponse = AbsenApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(presenceIn),
        headers: <String, String>{
          'Accept': 'Application/json',
          'Authorization': 'Bearer $token'
        });

    switch (response.statusCode) {
      case 200:
        apiResponse.description = 'Berhasil melakukan Absensi';
        break;
      case 401:
        apiResponse.error = unauthorized;
        apiResponse.description = '401';
        apiResponse.description =
            AbsenApiResponse.fromJson(jsonDecode(response.body)).description;
        break;
      default:
        apiResponse.error = somethingwentwrong;
        apiResponse.description = somethingwentwrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
    print(e);
    apiResponse.description = serverError;
  }

  return apiResponse;
}

Future<AbsenApiResponse> formKeluar() async {
  AbsenApiResponse apiResponse = AbsenApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(presenceOut),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        // apiResponse.description = jsonDecode(response.body);
        print(jsonDecode(response.body));
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingwentwrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}




// Future<int> updateImage(File img) async {
//   int statusCode = 200;

//   try {
//     String token = await getToken();
//     Map<String, String> headers = {
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token'
//     };
//     // open a bytestream
//     var stream = new http.ByteStream(DelegatingStream.typed(img.openRead()));
//     // get file length
//     var length = await img.length();

//     // create multipart request
//     var request = new http.MultipartRequest("POST", Uri.parse(profileUrl));

//     // multipart that takes file
//     var multipartFile = new http.MultipartFile('image', stream, length,
//         filename: basename(img.path));
//     request.headers.addAll(headers);
//     // add file to multipart
//     request.files.add(multipartFile);

//     // send
//     var response = await request.send();

//     // listen for response
//     response.stream.transform(utf8.decoder).listen((value) {});

//     // switch (response.statusCode) {
//     //   case 200:
//     //     apiResponse.data = Userprofile.fromJson(jsonDecode(response.));
//     //     break;
//     //   case 401:
//     //     apiResponse.error = unauthorized;
//     //     break;
//     //   default:
//     //     apiResponse.error = somethingwentwrong;
//     //     break;
//     // }
//   } catch (e) {
//     statusCode = 400;
//   }
//   return statusCode;
// }

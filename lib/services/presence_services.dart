import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:goAbsensi/models/absent_api_res.dart';
import 'package:goAbsensi/services/main_services.dart';
import '../common/common.dart';

import 'package:http/http.dart' as http;

import '../models/history.dart';

Future<HistoryApiResponse> showPresence() async {
  HistoryApiResponse apiResponse = HistoryApiResponse();
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
        // print(jsonDecode(response.body)[0]);
        // print("response.body");
        apiResponse.data =
            HistoryApiResponse.fromJson(jsonDecode(response.body)).data;
        apiResponse.name =
            HistoryApiResponse.fromJson(jsonDecode(response.body)).name;
        // apiResponse.data = response.body as List;
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
  // print(apiResponse.data![0]['id']);
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

Future<AbsenApiResponse> formMasuk(
    {required String lat, required String long}) async {
  AbsenApiResponse apiResponse = AbsenApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(presenceIn),
        headers: <String, String>{
          'Accept': 'Application/json',
          'Authorization': 'Bearer $token'
        },
        body: <String, String>{
          'lat': lat,
          'long': long
        });

    switch (response.statusCode) {
      case 200:
        apiResponse.description = 'Berhasil melakukan Absensi';
        break;
      case 401:
        apiResponse.error = '401';
        apiResponse.description =
            AbsenApiResponse.fromJson(jsonDecode(response.body)).description;
        break;
      case 420:
        apiResponse.error = '420';
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

Future<AbsenApiResponse> formKeluar(
    {required String lat, required String long}) async {
  AbsenApiResponse apiResponse = AbsenApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(presenceOut),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: <String, String>{
          'lat': lat,
          'long': long
        });
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        apiResponse.description =
            AbsenApiResponse.fromJson(jsonDecode(response.body)).description;
        break;
      case 401:
        apiResponse.error = unauthorized;
        apiResponse.description =
            AbsenApiResponse.fromJson(jsonDecode(response.body)).description;
        break;
      case 420:
        apiResponse.error = '420';
        apiResponse.description =
            AbsenApiResponse.fromJson(jsonDecode(response.body)).description;
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

Future<AbsenApiResponse> izin(
    {required String desc,
    String? tgl,
    required String permTypeId,
    File? filePickerVal}) async {
  AbsenApiResponse apiResponse = AbsenApiResponse();
  try {
    String token = await getToken();
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    //post date
    var response = http.MultipartRequest('POST', Uri.parse(izinUrl));

    response.headers.addAll(headers);
    response.fields['desciption'] = desc;
    response.fields['permission_type_id'] = permTypeId;
    response.fields['tanggal'] = tgl!;

    response.files.add(http.MultipartFile('file',
        filePickerVal!.readAsBytes().asStream(), filePickerVal.lengthSync(),
        filename: filePickerVal.path.split("/").last));

    var res = await response.send();
    var responseBytes = await res.stream.toBytes();
    var responseString = utf8.decode(responseBytes);
    print(res.request!);
    //debug
    debugPrint("response code: " + res.statusCode.toString());
    debugPrint("response: " + responseString.toString());

    final dataDecode = jsonDecode(responseString);
    debugPrint(dataDecode.toString());

    switch (res.statusCode) {
      case 200:
        // apiResponse.description =
        //     AbsenApiResponse.fromJson(jsonDecode(response.body)).description;
        break;
      case 401:
        apiResponse.error = unauthorized;
        // apiResponse.description =
        //     AbsenApiResponse.fromJson(jsonDecode(response.body)).description;
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

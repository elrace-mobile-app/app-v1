import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:el_race/ui/presentation/signin/data/model.dart';
import 'package:el_race/utils/api_query.dart';
import 'package:el_race/utils/string_utils.dart';
import 'package:el_race/utils/urll_utils.dart';

import 'package:shared_preferences/shared_preferences.dart';

class UserRepo {
  ApiQuery apiQuery = ApiQuery();
  Future<Response> loginApiCall(
      String email, String password, String deviceId) async {
    Map<String, dynamic> body = {
      "jsonrpc": "2.0",
      "params": {
        "db": "test2.elrace.com",
        "login": email,
        "password": password,
        "device_id": deviceId,
      }
    };

    log(body.toString());
    var headers = {
      'Content-Type': 'application/json',
      // 'Cookie': 'session_id=d332969198d1aae1013f5859361cd40bbd3a8c49'
    };

    Response? response =
        await apiQuery.postQuery(UrlUtil.login, headers, body, 'login', true);
    return response!;
  }

  setLoginResponse(LoginResponseModel? loginResponse) async {
    if (loginResponse != null) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      String? userData = json.encode(loginResponse);
      sharedPreferences.setString(loginResponseString, userData);
    }
  }

  Future<LoginResponseModel?> getLoginResponse() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString(loginResponseString) == null) {
      return null;
    } else {
      String? userData = sharedPreferences.getString(loginResponseString);
      return LoginResponseModel.fromJson(jsonDecode(userData!));
    }
  }

  setISLoggedIn(bool isLoggedIn) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setBool(isLoggedIN, isLoggedIn);
  }

  Future<bool?> getIsLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(isLoggedIN) ?? false;
  }

  setDeviceInfo(String deviceInfo) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(deviceInfoString, deviceInfo);
  }

  Future<String?> getDeviceInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(deviceInfoString) ?? '';
  }
}

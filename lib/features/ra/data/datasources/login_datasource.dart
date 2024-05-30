import 'dart:convert';

import 'package:real_appraiser/features/ra/data/models/authenticate_user_model.dart';
import 'package:real_appraiser/features/ra/data/models/get_store_model.dart';
import 'package:real_appraiser/features/ra/data/models/login_model.dart';
import 'package:real_appraiser/features/ra/data/models/security_token_model.dart';
import 'package:real_appraiser/service_helpers/api_service_helper.dart';

abstract class LoginDataSource {
  Future submitUrl(String url);

  Future getStore(String email);

  Future authenticateUser(String email, String password);

  Future securityToken(String email, String password);
}

class LoginDataSourceImpl extends LoginDataSource {
  @override
  Future submitUrl(String url) async {
    try {
      dynamic header = <String, String>{
        "Content-Type": "application/json",
      };
      var url =
          "https://dev-ra.usa.athenatec.com/api/Utililty/app_AuthenticateAPI";

      var result = await ApiHelper.getRequest(url, header, false);
      if (result.toString().isNotEmpty) {
        var res = jsonDecode(result);
        if (res["status"] == 1) {
          if (res["msg"] == "Success") {
            return LoginModel.fromJson(res);
          }
        } else {
          return "Enter a valid Url";
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future getStore(String email) async {
    try {
      var url = "https://dev-ra.usa.athenatec.com/api/Login/GetStore";
      var data = {"email": email};
      var header = <String, String>{
        'Content-Type': 'application/json',
      };

      var result = await ApiHelper.postRequest(url, data, header);
      if (result.toString().isNotEmpty) {
        var res = jsonDecode(result);
        if (res["status"] == 1) {
          if (res["msg"] == "Success") {
            return GetStoreModel.fromJson(res);
          }
        } else {
          return "Enter a valid Url";
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future authenticateUser(String email, String password) async {
    try {
      var url =
          "https://dev-ra.usa.athenatec.com/api/Login/app_AuthenticateUser_Store";
      var data = {"email": email, "password": password};
      var header = <String, String>{
        'Content-Type': 'application/json',
      };

      var result = await ApiHelper.postRequest(url, data, header);
      if (result.toString().isNotEmpty) {
        var res = jsonDecode(result);
        if (res["status"] == 1) {
          if (res["msg"] == "Success") {
            return AuthenticateUserModel.fromJson(res);
          }
        } else {
          return "Enter a valid Url";
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future securityToken(String email, String password) async {
    try {
      var url = "https://dev-ra.usa.athenatec.com/api/security/token";
      var data = {
        "UserName": email,
        "password": password,
        "grant_type": "password"
      };
      var header = <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      };

      var result = await ApiHelper.postRequest201(url, data, header);
      if (result.toString().isNotEmpty) {
        var res = jsonDecode(result);
        return SecurityTokenModel.fromJson(res);
      } else {
        return "Enter a valid Url";
      }
    } catch (e) {
      print(e);
    }
  }
}

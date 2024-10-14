import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:real_appraiser/features/ra/data/models/authenticate_user_model.dart';
import 'package:real_appraiser/features/ra/data/models/get_store_model.dart';
import 'package:real_appraiser/features/ra/data/models/login_model.dart';
import 'package:real_appraiser/features/ra/data/models/security_token_model.dart';
import 'package:real_appraiser/service_helpers/api_service_helper.dart';

import '../../../../common_utilis/strings.dart';
import '../../../../common_utilis/utilis.dart';
import '../models/employee_branch_model.dart';

abstract class LoginDataSource {
  Future submitUrl(String url);

  Future getStore(String email,BuildContext context);

  Future authenticateUser(String email, String password,BuildContext c);

  Future securityToken(String email, String password,BuildContext c);

  Future getEmployeeBranch(BuildContext c);
}

class LoginDataSourceImpl extends LoginDataSource {
  @override
  Future submitUrl(String url) async {


  }

  @override
  Future getStore(String email,BuildContext context) async {
    try {
      // RAUtilis.showLoader(context);
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
    } finally{
      // RAUtilis.hideLoader(context);
    }
  }

  @override
  Future authenticateUser(String email, String password,BuildContext c) async {
    try {
    //  RAUtilis.showLoader(c);
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
          return "Enter a valid credentials";
        }
      }
    } catch (e) {
      print(e);
    }finally{
    //  RAUtilis.hideLoader(c);
    }
  }

  @override
  Future securityToken(String email, String password,BuildContext c) async {
    try {
      var data = {};
      var url = "https://dev-ra.usa.athenatec.com/api/security/token";
      String branchId=RAUtilis.getStorage(StorageString.branchId);
      if (branchId.isNotEmpty) {

        data = {
          "UserName": "$email,$branchId",
          "password": password,
          "grant_type": "password"
        };
      } else {
        data = {
          "UserName": email,
          "password": password,
          "grant_type": "password"
        };
      }

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
    }finally{
    }
  }

  @override
  Future getEmployeeBranch(BuildContext c) async {
    String loginId = RAUtilis.getStorage(StorageString.loginId);
    try {
      // RAUtilis.showLoader(c);
      dynamic header = <String, String>{
        "Content-Type": "application/json",
      };
      final Map<String, dynamic> queryParams = {
        'LoginId': loginId,
      };
      var url =
          "https://dev-ra.usa.athenatec.com/Api/Login/app_GetEmployeeBranches";
      final Uri uri = Uri.parse(url).replace(queryParameters: queryParams);

      var result = await ApiHelper.getRequestUri(
        uri,
        header,
        false,
      );
      if (result.toString().isNotEmpty) {
        var res = jsonDecode(result);
        if (res["status"] == 1) {
          if (res["msg"] == "Success") {
            return EmployeeBranchModel.fromJson(res);
          }
        } else {
          return "Enter a valid Url";
        }
      }
    } catch (e) {
      print(e);
    }finally{
      // RAUtilis.hideLoader(c);
    }
  }
}

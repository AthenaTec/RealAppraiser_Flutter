import 'dart:convert';

import 'package:real_appraiser/common_utilis/strings.dart';
import 'package:real_appraiser/common_utilis/utilis.dart';
import 'package:real_appraiser/features/ra/data/models/getTicketQueryModel.dart';
import 'package:real_appraiser/features/ra/data/models/insert_ticket_model.dart';
import 'package:real_appraiser/features/ra/domain/usecases/raise_a_ticket_usecases.dart';
import 'package:real_appraiser/service_helpers/api_service_helper.dart';

abstract class RaiseATicketDatasource {
  Future getTicketQuery();
  Future createTicket(InsertTicketInputData inputData);
}

class RaiseATicketDatasourceImpl extends RaiseATicketDatasource {
  @override
  Future getTicketQuery() async {
    try {
      dynamic header = <String, String>{
        "Content-Type": "application/json",
      };
      var url ="https://dev-ra.usa.athenatec.com/api/Ticket/GetTicketQueries";

      var result = await ApiHelper.getRequest(url, header, false);
      if (result.toString().isNotEmpty) {
        var res = jsonDecode(result);
        if (res["status"] == 1) {
          if (res["msg"] == "Success") {
            return GetTicketQueriesModel.fromMap(res);
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
  Future createTicket(InsertTicketInputData inputData) async{
    try {
      String loginId = RAUtilis.getStorage(StorageString.loginId);
      String branchId = RAUtilis.getStorage(StorageString.branchId);
      String token = RAUtilis.getStorage(StorageString.accessToken);
      var url = "https://dev-ra.usa.athenatec.com/api/Ticket/InsertTicketDetails";

      var header = <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };

      var data= inputData.toJson();
      var result = await ApiHelper.postRequest200(url, data, header);
      if (result
          .toString()
          .isNotEmpty) {
        var res = jsonDecode(result);
        if (res["status"] == 1) {
          if (res["msg"] == "Success") {
            return InsertTicketDetailsModel.fromMap(res);
          }
        } else {
          return "Service Failure";
        }
      }
    } catch (e) {
      print(e);
    }
  }
}

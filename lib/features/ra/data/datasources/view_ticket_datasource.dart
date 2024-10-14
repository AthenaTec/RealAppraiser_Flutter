import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:real_appraiser/common_utilis/strings.dart';
import 'package:real_appraiser/common_utilis/utilis.dart';
import 'package:real_appraiser/features/ra/data/models/get_filter_status_model.dart';
import 'package:real_appraiser/features/ra/data/models/get_ticket_details_model.dart';
import 'package:real_appraiser/features/ra/domain/usecases/view_ticket_usecases.dart';
import 'package:real_appraiser/service_helpers/api_service_helper.dart';

abstract class ViewTicketDatasource {
  Future getTicketDetails(TicketFilterInput input);
  Future getFilterStatus();
}

class ViewTicketDatasourceImpl extends ViewTicketDatasource {
  @override
  Future getTicketDetails(TicketFilterInput input) async {
    try {
      String token = RAUtilis.getStorage(StorageString.accessToken);



      var url =
          "https://dev-ra.usa.athenatec.com/api/Ticket/GetTicketDetails";
      var data = {
        "EmpId": input.empId,
        "fromdate": input.fromDate,
        "todate": input.toDate,
        "fillterby": input.filterBy,
        "ticketId": input.ticketId,
        "status": input.status,
        "roleId": input.roleId
      };
      var header = <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };

      var result = await ApiHelper.putRequest200(url, data, header);
      if (result.toString().isNotEmpty) {
        var res = jsonDecode(result);
        if (res["status"] == 1) {
          if (res["msg"] == "Success") {
            return GetTicketDetailsModel.fromJson(res);
          }
        } else {
          return "Service Failure";
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future getFilterStatus() async{
    try {
      dynamic header = <String, String>{
        "Content-Type": "application/json",
      };
      var url =
          "https://dev-ra.usa.athenatec.com/api/Ticket/GetTicketStatus";

      var result = await ApiHelper.getRequest(url, header, false);
      if (result.toString().isNotEmpty) {
        var res = jsonDecode(result);
        if (res["status"] == 1) {
          if (res["msg"] == "Success") {
            return TicketFilterStatusModel.fromJson(res);
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

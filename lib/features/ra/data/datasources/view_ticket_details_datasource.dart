import 'dart:convert';

import 'package:real_appraiser/common_utilis/strings.dart';
import 'package:real_appraiser/common_utilis/utilis.dart';
import 'package:real_appraiser/features/ra/data/models/get_image_by_ticket_id_model.dart';
import 'package:real_appraiser/features/ra/data/models/ticket_details_by_id_model.dart';
import 'package:real_appraiser/service_helpers/api_service_helper.dart';

abstract class ViewTicketDetailsDatasource {
  Future getTicketDetailsById(String ticketId);
  Future getTicketImagesById(String ticketId);
}

class ViewTicketDetailsDatasourceImpl extends ViewTicketDetailsDatasource {
  @override
  Future getTicketDetailsById(String ticketId) async {
    String token = RAUtilis.getStorage(StorageString.accessToken);

    try {
      dynamic header = <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      final Map<String, dynamic> queryParams = {
        'TicketId': ticketId,
      };
      var url = "https://dev-ra.usa.athenatec.com/api/Ticket/TicketDetailsbyId";
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
            return TicketDetailsbyIdModel.fromJson(res);
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
  Future getTicketImagesById(String ticketId) async{
    String token = RAUtilis.getStorage(StorageString.accessToken);

    try {
      dynamic header = <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      final Map<String, dynamic> queryParams = {
        'TicketId': ticketId,
      };
      var url = "https://dev-ra.usa.athenatec.com/api/Ticket/GetBLOBImageByTicketId";
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
            return GetImageByTicketIdModel.fromJson(res);
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

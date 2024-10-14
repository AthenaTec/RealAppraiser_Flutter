import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHelper {
  static var ioClient = http.Client();

  // Function to make a GET request
  static Future<dynamic> getRequest(
      String endpoint, Map<String, String> header, bool loading) async {
    try {
      final response = await http.get(Uri.parse(endpoint));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      throw e.toString();
    }
  }

  static Future<dynamic> getRequestUri(
      Uri uri, Map<String, String> header, bool loading) async {
    try {
      final response = await http.get(uri,headers: header);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      throw e.toString();
    }
  }

  // Function to make a POST request
  static Future<dynamic> postRequest(
      String endpoint, dynamic data, Map<String, String> header) async {
    print("api");
    try {
      final jsonData =
          const JsonEncoder().convert(data); // Convert data to JSON string
      final jsonBytes = utf8.encode(jsonData);
      final response = await ioClient.post(Uri.parse(endpoint),
          headers: header, body: json.encode(data));

      if (response.statusCode == 201) {
        return response.body;
      }
      else {
        print(response.statusCode.toString());
        throw Exception('Failed to post data');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  // Function to make a POST request
  static Future<dynamic> postRequest201(
      String endpoint, dynamic data, Map<String, String> header) async {
    print("201");
    try {
     // Convert data to JSON string
      final body = data.entries.map((entry) => '${entry.key}=${Uri.encodeQueryComponent(entry.value)}').join('&');
      final response = await ioClient.post(Uri.parse(endpoint),
          headers: header, body:body);

       if (response.statusCode == 200) {
        return response.body;
      } else {
        print(response.statusCode.toString());
        throw Exception('Failed to post data');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  // Function to make a put request
  static Future<dynamic> putRequest(
      String endpoint, dynamic data, Map<String, String> header) async {
    print("api");
    try {
      final jsonData =
      const JsonEncoder().convert(data); // Convert data to JSON string
      final jsonBytes = utf8.encode(jsonData);
      final response = await ioClient.put(Uri.parse(endpoint),
          headers: header, body: json.encode(data));

      if (response.statusCode == 201) {
        return response.body;
      }
      else {
        print(response.statusCode.toString());
        throw Exception('Failed to post data');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  static Future<dynamic> postRequest200(
      String endpoint, dynamic data, Map<String, String> header) async {
    print("api");
    try {
      final jsonData =
      const JsonEncoder().convert(data); // Convert data to JSON string
      final jsonBytes = utf8.encode(jsonData);
      final response = await ioClient.post(Uri.parse(endpoint),
          headers: header, body: json.encode(data));

      if (response.statusCode == 200) {
        return response.body;
      }
      else {
        print(response.statusCode.toString());
        throw Exception('Failed to post data');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  // Function to make a put request
  static Future<dynamic> putRequest200(
      String endpoint, dynamic data, Map<String, String> header) async {
    print("putRequest");
    try {
      final jsonData =
      const JsonEncoder().convert(data); // Convert data to JSON string
      final response = await ioClient.put(Uri.parse(endpoint),
          headers: header, body: json.encode(data));

      if (response.statusCode == 200) {
        return response.body;
      }
      else {
        print(response.statusCode.toString());
        throw Exception('Failed to post data');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }
}

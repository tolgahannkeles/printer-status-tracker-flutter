import 'dart:convert';
import 'dart:developer';

import 'package:test_app/models/monthly_total.dart';
import 'package:test_app/models/printer.dart';
import 'package:test_app/models/printer_status.dart';
import 'package:test_app/services/interface_data_service.dart';
import 'package:http/http.dart' as http;

class ApiDataService extends DataService {
  final String _baseUrl = "http://10.40.104.79:8080";

  @override
  Future<Printer?> getPrinter(String id) async {
    Uri? uri = Uri.tryParse("$_baseUrl/printers/$id");
    if (uri != null) {
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        var printer = Printer.fromJson(jsonDecode(response.body));
        return printer;
      }
    }
    return null;
  }

  @override
  Future<List<PrinterStatus?>> getPrinterStatusAll() async {
    List<PrinterStatus?> status = [];
    try {
      Uri? uri = Uri.tryParse("$_baseUrl/status");
      if (uri != null) {
        var response = await http.get(uri);
        if (response.statusCode == 200) {
          List<dynamic> jsonList = jsonDecode(response.body);
          status = jsonList
              .map(
                (e) => PrinterStatus.fromJson(e),
              )
              .toList();
        }
      }
    } catch (ex) {
      log(ex.toString());
    }

    return status;
  }

  @override
  Future<MonthlyTotal?> getMonthlyTotal(String date) async {
    try {
      Uri? uri = Uri.tryParse("$_baseUrl/status/totalStatus");
      if (uri != null) {
        var headers = {"Content-Type": "application/json"};
        var body = jsonEncode({"date": date});
        var response = await http.post(uri, headers: headers, body: body);
        if (response.statusCode == 200) {
          var json = jsonDecode(response.body);
          var model = MonthlyTotal.fromJson(json);
          return model;
        }
      }
    } catch (ex) {
      print(ex);
    }
    return null;
  }

  @override
  Future<List<PrinterStatus?>> getPrinterStatusAllByDate(String date) async {
    List<PrinterStatus?> status = [];
    //TODO: Edit the date format

    Uri? uri = Uri.tryParse("$_baseUrl/status/byDate");
    if (uri != null) {
      var headers = {"Content-Type": "application/json"};
      var body = jsonEncode({"date": date});
      var response = await http.post(uri, headers: headers, body: body);
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        status = jsonList
            .map(
              (e) => PrinterStatus.fromJson(e),
            )
            .toList();
      }
    }
    return status;
  }

  @override
  Future<List<PrinterStatus?>> getPrinterStatusByIp(String ip) async {
    List<PrinterStatus?> status = [];
    Uri? uri = Uri.tryParse("$_baseUrl/status/byIp");
    if (uri != null) {
      var headers = {"Content-Type": "application/json"};
      var body = jsonEncode({"ip": ip});
      var response = await http.post(uri, headers: headers, body: body);
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        status = jsonList
            .map(
              (e) => PrinterStatus.fromJson(e),
            )
            .toList();
      }
    }
    return status;
  }

  @override
  Future<List<Printer?>> getAllPrinters() async {
    List<Printer?> printer = [];
    Uri? uri = Uri.tryParse("$_baseUrl/printers");
    if (uri != null) {
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        printer = jsonList
            .map(
              (e) => Printer.fromJson(e),
            )
            .toList();
      }
    }
    return printer;
  }

  @override
  Future<List<Printer?>> getAllPrintersAvailability() async {
    List<Printer?> printer = [];
    Uri? uri = Uri.tryParse("$_baseUrl/printers/ping");
    if (uri != null) {
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        printer = jsonList
            .map(
              (e) => Printer.fromJson(e),
            )
            .toList();
      }
    }
    return printer;
  }
}

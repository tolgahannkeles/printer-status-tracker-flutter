import 'package:test_app/models/monthly_total.dart';
import 'package:test_app/models/printer.dart';
import 'package:test_app/models/printer_status.dart';

abstract class DataService {
  Future<Printer?> getPrinter(String id);
  Future<List<PrinterStatus?>> getPrinterStatusAll();
  Future<List<PrinterStatus?>> getPrinterStatusAllByDate(String date);
  Future<List<PrinterStatus?>> getPrinterStatusByIp(String ip);
  Future<MonthlyTotal?> getMonthlyTotal(String date);
  Future<List<Printer?>> getAllPrinters();
  Future<List<Printer?>> getAllPrintersAvailability();
}

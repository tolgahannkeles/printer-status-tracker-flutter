abstract class DataService {
  Future<int?> getPrinterInfo(String ip);
  Future<int?> getPrinterStatusAll(String ip);
  Future<int?> getPrinterStatusAllByDay(String ip);
}

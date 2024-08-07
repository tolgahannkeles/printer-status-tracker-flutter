import 'package:test_app/services/interface_data_service.dart';
import 'package:http/http.dart' as http;

class ApiDataService extends DataService {
  String _baseUrl = "https://10.40.104.79:8080";
  @override
  Future<int?> getPrinterInfo(String id) async {
    Uri? uri = Uri.tryParse(_baseUrl + "/printers/$id");
    if (uri != null) {
      var response = await http.get(uri);
      print(response);
    }
    return null;
  }

  @override
  Future<int?> getPrinterStatusAll(String ip) {
    // TODO: implement getPrinterStatusAll
    throw UnimplementedError();
  }

  @override
  Future<int?> getPrinterStatusAllByDay(String ip) {
    // TODO: implement getPrinterStatusAllByDay
    throw UnimplementedError();
  }
}

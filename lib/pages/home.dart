import 'package:flutter/material.dart';
import 'package:test_app/services/data_service.dart';
import 'package:test_app/services/interface_data_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    DataService dataService = ApiDataService();
    return FutureBuilder(
      builder: (context, snapshot) => snapshot.data == null
          ? const Center(child: CircularProgressIndicator())
          : Scaffold(
              body: Center(
                child: Text(snapshot.data.toString()),
              ),
            ),
      future: dataService.getPrinterInfo("1"),
    );
  }
}

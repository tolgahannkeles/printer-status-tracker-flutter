import 'dart:developer';
import 'package:dart_ping/dart_ping.dart';
import 'package:flutter/material.dart';
import 'package:test_app/models/printer.dart';
import 'package:test_app/services/data_service.dart';
import 'package:test_app/services/interface_data_service.dart';
import 'package:test_app/utils/constants.dart';

class IsWorkingPage extends StatefulWidget {
  const IsWorkingPage({super.key});

  @override
  State<IsWorkingPage> createState() => _IsWorkingPageState();
}

class _IsWorkingPageState extends State<IsWorkingPage> {
  List<Printer?> printers = [];
  List<Printer?> printersCopy = [];
  DataService dataService = ApiDataService();
  bool isLoading = true;
  bool showOffline = false;

  @override
  void initState() {
    dataService.getAllPrintersAvailability().then(
      (value) {
        setState(() {
          printers = value;
          printersCopy = printers;
          isLoading = !isLoading;
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (showOffline) {
      printersCopy = printers
          .where(
            (element) => element?.isAvailable == false ?? false,
          )
          .toList();
    } else {
      printersCopy = printers;
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Center(
          child: Text(Constants.pingResults),
        ),
        actions: [
          TextButton(
            child: Text(showOffline
                ? Constants.showAllPrinters
                : Constants.showOnlyAvailablePrinters),
            onPressed: () {
              setState(() {
                showOffline = !showOffline;
              });
            },
          )
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DataTable(
                  border: TableBorder.all(),
                  headingRowColor: WidgetStateProperty.all(Colors.grey),
                  columns: const [
                    DataColumn(label: Center(child: Text(Constants.columnIp))),
                    DataColumn(
                        label: Center(child: Text(Constants.columnName))),
                    DataColumn(
                        label:
                            Center(child: Text(Constants.columnAvailability))),
                  ],
                  rows: printersCopy
                      .map(
                        (e) => DataRow(cells: [
                          DataCell(dataCell(e?.ip ?? "null")),
                          DataCell(dataCell(e?.name ?? "null")),
                          DataCell(dataCell(e?.isAvailable ?? "null")),
                        ]),
                      )
                      .toList(),
                ),
              ),
            ),
    );
  }

  Widget dataCell(Object data) {
    return Center(
      child: Text(data.toString()),
    );
  }
}

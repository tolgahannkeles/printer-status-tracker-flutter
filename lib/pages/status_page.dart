import 'package:flutter/material.dart';
import 'package:test_app/models/monthly_total.dart';
import 'package:test_app/models/printer_status.dart';
import 'package:test_app/pages/filter_button.dart';
import 'package:test_app/services/data_service.dart';
import 'package:test_app/services/interface_data_service.dart';
import 'package:test_app/utils/constants.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  List<PrinterStatus?> status = [];
  List<PrinterStatus?> filter = [];

  DataService dataService = ApiDataService();
  TextEditingController controller = TextEditingController();
  MonthlyTotal? monthlyTotal;
  DateTime? pickedDate;

  @override
  void initState() {
    dataService.getPrinterStatusAll().then(
      (value) {
        setState(() {
          status = value;
          filter = status;
        });
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (controller.text.isEmpty) {
      filter = status;
      if (pickedDate != null) {
        filter = filter
            .where(
              (element) =>
                  element?.date
                      .toString()
                      .contains(pickedDate.toString().substring(0, 7)) ??
                  false,
            )
            .toList();
      }
    } else {
      filter = status
          .where(
            (element) =>
                element?.ip.toString().contains(controller.text) ?? false,
          )
          .toList();

      if (pickedDate != null) {
        filter = filter
            .where(
              (element) =>
                  element?.date
                      .toString()
                      .contains(pickedDate.toString().substring(0, 7)) ??
                  false,
            )
            .toList();
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.gridStatus),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text(Constants.ip),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    controller: controller,
                  ),
                )),
                ElevatedButton(
                  child: const Text(Constants.fetch),
                  onPressed: () async {
                    setState(() {});
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DataTable(
                    border: TableBorder.all(),
                    headingRowColor: WidgetStateProperty.all(Colors.grey),
                    columns: [
                      const DataColumn(
                          label: Text(Constants.columnIp), numeric: false),
                      const DataColumn(
                          label: Text(Constants.columnName), numeric: false),
                      DataColumn(
                          label: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(Constants.columnDate),
                              FilterButton(
                                onFilterOff: () async {
                                  pickedDate = await showDialog(
                                      context: context,
                                      builder: (context) => DatePickerDialog(
                                            firstDate: DateTime(2024, 0),
                                            lastDate: DateTime(2024, 12),
                                            initialCalendarMode:
                                                DatePickerMode.day,
                                          ));

                                  if (pickedDate?.year != null &&
                                      pickedDate?.month != null) {
                                    String date =
                                        pickedDate.toString().substring(0, 7);

                                    monthlyTotal =
                                        await dataService.getMonthlyTotal(date);

                                    setState(() {});
                                  }
                                },
                                onFilterOn: () async {
                                  pickedDate = null;
                                  setState(() {});
                                },
                              )
                            ],
                          ),
                          numeric: false),
                      const DataColumn(
                          label: Text(Constants.columnMonthlyMono),
                          numeric: true),
                      const DataColumn(
                          label: Text(Constants.columnTotalMono),
                          numeric: false),
                      const DataColumn(
                          label: Text(Constants.columnMonthlyColor),
                          numeric: false),
                      const DataColumn(
                          label: Text(Constants.columnTotalColor),
                          numeric: false),
                    ],
                    rows: [
                      DataRow(
                          color: const WidgetStatePropertyAll(Colors.blueGrey),
                          cells: [
                            DataCell(rowCell("-")),
                            DataCell(
                                rowCell(Constants.monthlyTotalForAllPrinters)),
                            DataCell(rowCell(
                                pickedDate ?? Constants.nullDateMessage)),
                            DataCell(rowCell(monthlyTotal?.monoCount)),
                            DataCell(rowCell("-")),
                            DataCell(rowCell(monthlyTotal?.colorCount)),
                            DataCell(rowCell("-")),
                          ]),
                      ...filter.map(
                        (e) => DataRow(cells: [
                          DataCell(rowCell(e?.ip)),
                          DataCell(rowCell(e?.name)),
                          DataCell(rowCell(e?.date)),
                          DataCell(rowCell(e?.monoCount)),
                          DataCell(rowCell(e?.monoTotal)),
                          DataCell(rowCell(e?.colorCount)),
                          DataCell(rowCell(e?.colorTotal)),
                        ]),
                      )
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget rowCell(Object? data) {
    return Text(data.toString());
  }
}

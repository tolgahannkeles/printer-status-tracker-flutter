import 'package:flutter/material.dart';
import 'package:test_app/pages/is_working_page.dart';
import 'package:test_app/pages/status_page.dart';
import 'package:test_app/utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: MediaQuery.of(context).size.height * .25,
      ),
      children: [
        gridItem(
          title: Constants.gridStatus,
          onClick: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const StatusPage(),
          )),
        ),
        gridItem(
          title: Constants.gridAvailability,
          onClick: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const IsWorkingPage(),
          )),
        ),
      ],
    ));
  }

  Widget gridItem({required String title, Function()? onClick}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onClick,
        child: Container(
          decoration: const BoxDecoration(color: Colors.grey),
          child: Center(child: Text(title)),
        ),
      ),
    );
  }
}

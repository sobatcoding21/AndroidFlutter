import 'package:androidflutter/views/device_info.dart';
import 'package:androidflutter/views/dropdown_view.dart';
import 'package:androidflutter/views/listview_pages.dart';
import 'package:androidflutter/views/login_page.dart';
import 'package:flutter/material.dart';

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
          title: const Text("Widget APP"),
        ),
        body: Container(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20, top: 20),
        child: 
                GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          children: [
            Padding(padding: const EdgeInsets.all(2.0),
              child: ElevatedButton(
              onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const DeviceInfoPage())),
              child: const Text('Device Info'),
              )
            ),
            Padding(padding: const EdgeInsets.all(2.0),
              child: ElevatedButton(
              onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const PageLogin())),
              child: const Text('Login'),
              )
            ),
            Padding(padding: const EdgeInsets.all(2.0),
              child: ElevatedButton(
              onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const DropdownPage())),
              child: const Text('Dropdown View'),
              )
            ),
            Padding(padding: const EdgeInsets.all(2.0),
              child: ElevatedButton(
              onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const PageListView())),
              child: const Text('List View'),
              )
            )
          ],
        )/*Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:    <Widget> [
            Padding(padding: const EdgeInsets.all(2.0),
              child: ElevatedButton(
              onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const DeviceInfoPage())),
              child: const Text('Device Info'),
              )
            ),
            Padding(padding: const EdgeInsets.all(2.0),
              child: ElevatedButton(
              onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const PageLogin())),
              child: const Text('Login'),
              )
            ),
            Padding(padding: const EdgeInsets.all(2.0),
              child: ElevatedButton(
              onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const DropdownPage())),
              child: const Text('Dropdown View'),
              )
            ),
            Padding(padding: const EdgeInsets.all(2.0),
              child: ElevatedButton(
              onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const PageListView())),
              child: const Text('List View'),
              )
            )
        ])*/));
  }
}
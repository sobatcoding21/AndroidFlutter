import 'package:androidflutter/views/device_info.dart';
import 'package:androidflutter/views/dropdown_view.dart';
import 'package:androidflutter/views/geomap_page.dart';
import 'package:androidflutter/views/listview_pages.dart';
//import 'package:androidflutter/views/login_local_page.dart';
import 'package:androidflutter/views/login_page.dart';
//import 'package:androidflutter/views/surat_view.dart';
//import 'package:androidflutter/views/upload_local_page.dart';
import 'package:androidflutter/views/upload_view.dart';
import 'package:flutter/material.dart';

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Widget APP"),
        ),
        body: Container(
            padding:
                const EdgeInsets.only(left: 15, right: 15, bottom: 20, top: 20),
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              children: [
                Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const DeviceInfoPage())),
                      child: const Text('Device Info'),
                    )),
                Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const PageLogin())),
                      child: const Text('Login'),
                    )),
                Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const DropdownPage())),
                      child: const Text('Dropdown View'),
                    )),
                Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const PageListView())),
                      child: const Text('List View'),
                    )),
                Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const UploadPage())),
                      child: const Text('Test Upload File'),
                    )),
                    Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const GeoMapPage())),
                      child: const Text('Flutter Map'),
                    )),
                /*Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const PageLocalLogin())),
                      child: const Text('Test Login Local'),
                    )),
                Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const UploadLocalPage())),
                      child: const Text('Test Upload Local'),
                    )),
                Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const PageSurat())),
                      child: const Text('Test Another API'),
                    ))*/
              ],
            )));
  }
}

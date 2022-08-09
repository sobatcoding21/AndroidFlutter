import 'dart:convert';

import 'package:androidflutter/models/cities.dart';
import 'package:androidflutter/ui/listview_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PageListView extends StatefulWidget {
  const PageListView({Key? key}) : super(key: key);

  @override
  _PageListViewState createState() => _PageListViewState();
}

class _PageListViewState extends State<PageListView> {
  List<Cities> listCities = [];

  getListCities() async {
    try {
      final response = await http.get(
          Uri.parse("https://api.sobatcoding.com/testing/cities"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          });

      if (response.statusCode == 200) {
        final dataDecode = jsonDecode(response.body);
        setState(() {
          for (var i = 0; i < dataDecode.length; i++) {
            listCities.add(Cities.fromJson(dataDecode[i]));
          }
        });
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  @override
  void initState() {
    getListCities();
    super.initState();
  }

  Widget bulidListItem(index) {
    var item = listCities[index];

    return ListKota(nama: item.name.toString());
    /*return Card(
      child: ListTile(
        title:
            Text(item.name.toString(), style: const TextStyle(fontSize: 18.0)),
        trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey.shade400,
                  child: IconButton(
                      color: Colors.white,
                      onPressed: () {},
                      icon: const Icon(Icons.edit))),
              const SizedBox(width: 5),
              CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.red,
                  child: IconButton(
                      color: Colors.white,
                      onPressed: () {},
                      icon: const Icon(Icons.delete)))
            ]),
      ),
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo List View"),
      ),
      body: ListView.builder(
          itemCount: listCities.length,
          itemBuilder: (BuildContext context, int index) {
            return bulidListItem(index);
          }),
    );
  }
}

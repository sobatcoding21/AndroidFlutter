import 'dart:convert';

import 'package:androidflutter/models/cities.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DropdownPage extends StatefulWidget {
  const DropdownPage({Key? key}) : super(key: key);

  @override
  _DropdownPageState createState() => _DropdownPageState();
}

class _DropdownPageState extends State<DropdownPage> {
  String? txtCity, txtCityStatic;
  List<Cities> listCities = [];
  List<Cities> listCitiesStatic = [
    Cities(id: 1, name: "Jakarta"),
    Cities(id: 2, name: "Bandung"),
    Cities(id: 3, name: "Semarang"),
    Cities(id: 4, name: "Surabaya"),
    Cities(id: 5, name: "Yogyakarta"),
  ];

  getAPICities() async {
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
  
  Widget dropdownStatic() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        hint: const Text("Pilih Kota Yang Dituju"),
        value: txtCityStatic,
        items: listCitiesStatic
            .map((data) => DropdownMenuItem<String>(
                  child: Text(data.name.toString()),
                  value: data.id.toString(),
                ))
            .toList(),
        onChanged: (value) {
          //
        },
        validator: (value) => value == null ? 'Pilih kota yang dituju' : null,
      ),
    );
  }

  Widget dropdownAPI() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        hint: const Text("Pilih Kota Yang Dituju"),
        value: txtCity,
        items: listCities
            .map((data) => DropdownMenuItem<String>(
                  child: Text(data.name.toString()),
                  value: data.id.toString(),
                ))
            .toList(),
        onChanged: (value) {
          //
        },
        validator: (value) => value == null ? 'Pilih kota yang dituju' : null,
      ),
    );
  }

  @override
  void initState() {
    getAPICities();
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Demo Dropdwon"),
        ),
        body: Center(
          child: ListView(children:  [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child:  Text("List Kota Static"),
            ),
            dropdownStatic(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("List Kota dengan API"),
            ),
            dropdownAPI(),
          ],),
    ));
  }
}
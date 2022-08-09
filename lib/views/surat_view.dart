

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/riwayatsurat.dart';

class PageSurat extends StatefulWidget {
  const PageSurat({Key? key}) : super(key: key);

  @override
  State<PageSurat> createState() => _PageSuratState();
}

class _PageSuratState extends State<PageSurat> {
  List<RiwayatSurat> listPermohonan = [];
  String idPenduduk= "";

  getListPermohonan() async {
    try {
      final response = await http.get(
          Uri.parse(
              "http://55.55.55.21/surat-desa/api/get-surat?id_penduduk=$idPenduduk"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          });

      if (response.statusCode == 200) {
        final dataDecode = jsonDecode(response.body);
        debugPrint(dataDecode['data'].toString());

        setState(() {
          for (var i = 0; i < dataDecode['data'].length; i++) {
            listPermohonan.add(RiwayatSurat.fromJson(dataDecode['data'][i]));
          }
        });
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  @override
  void initState() {

    setState(() {
      idPenduduk = "13";
    });
    getListPermohonan();
    super.initState();
  }

  Widget cardProgres(index) {
    var item = listPermohonan[index];
    return Container(
      width: MediaQuery.of(context).size.width - (2 * 100),
      height: 83,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 234, 235, 236),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              // 'Surat Keterangan Usaha',
              item.namaSurat.toString(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                const Text(
                  'Status :'
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  // 'Diterima',
                  item.status.toString(),
                  style: const TextStyle(color: Colors.lightBlue),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo List View Another API"),
      ),
      body: ListView.builder(
          itemCount: listPermohonan.length,
          itemBuilder: (BuildContext context, int index) {
            return cardProgres(index);
          }),
    );
  }
}
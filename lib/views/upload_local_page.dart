import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:file_picker/file_picker.dart';

class UploadLocalPage extends StatefulWidget {
  const UploadLocalPage({Key? key}) : super(key: key);

  @override
  State<UploadLocalPage> createState() => _UploadLocalPageState();
}

class _UploadLocalPageState extends State<UploadLocalPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String txtNama = "";
  String txtMulai = "";
  String txtSelesai = "";
  String txtTgl = "";

  var txtEditNama = TextEditingController();
  var txtDate = TextEditingController();
  var txtFilePicker = TextEditingController();
  DateTime date = DateTime.now();

  File ? filePickerVal;

  Widget buildDatePicker(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
                readOnly: true,
                controller: txtDate,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Tanggal harus diisi';
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                      borderSide: BorderSide(color: Colors.white, width: 2)),
                  hintText: 'Tanggal File',
                  contentPadding: EdgeInsets.all(10.0),
                ),
                style: const TextStyle(fontSize: 16.0)),
          ),
          const SizedBox(width: 5),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlue,
                  minimumSize: const Size(70, 48),
                  maximumSize: const Size(70, 48)),
              onPressed: () => pickDatePicker(context),
              child: const FaIcon(
                FontAwesomeIcons.calendarDay,
                color: Colors.white,
                size: 24.0,
              ))
        ],
      ),
    );
  }

  Future pickDatePicker(BuildContext context) async {
    final newDatePicker = await showDatePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDate: date,
        builder: (context, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxWidth: 400.0, maxHeight: 520.0),
                  child: child,
                ),
              )
            ],
          );
        });

    if (newDatePicker == null) return;

    setState(() {
      //
      String rawDate = newDatePicker.toString();
      var explode = rawDate.split(" ");
      String tgl = convertDateFromString(explode[0]).toString();
      txtDate.text = tgl;
    });
  }

  Widget buildFilePicker() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
                readOnly: true,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'File harus diupload';
                  } else {
                    return null;
                  }
                },
                controller: txtFilePicker,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                      borderSide: BorderSide(color: Colors.white, width: 2)),
                  hintText: 'Upload File',
                  contentPadding: EdgeInsets.all(10.0),
                ),
                style: const TextStyle(fontSize: 16.0)),
          ),
          const SizedBox(width: 5),
          ElevatedButton.icon(
            icon: const Icon(
              Icons.upload_file,
              color: Colors.white,
              size: 24.0,
            ),
            label: const Text('Pilih File', style: TextStyle(fontSize: 16.0)),
            onPressed: () {
              selectFile();
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.lightBlue,
              minimumSize: const Size(122, 48),
              maximumSize: const Size(122, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  selectFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      setState(() {
        txtFilePicker.text = result.files.single.name;
        filePickerVal = File(result.files.single.path.toString());
      });
    } else {
      // User canceled the picker
    }
  }

  void _validateInputs() {
    if (_formKey.currentState!.validate()) {
      //If all data are correct then save data to out variables
      _formKey.currentState!.save();
      simpan();
    }
  }

  simpan() async {

    final String nama = txtEditNama.text; //txtNama;
    var rawTgl = txtDate.text.split("/");
    var yM = rawTgl[2];
    var mM = rawTgl[1];
    var dM = rawTgl[0];
    final String tgl = yM + "-" + mM + "-" + dM;
    
    try {
      //post date
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var request = http.MultipartRequest('POST', Uri.parse('http://55.55.55.21/restapi_ci3/api/test-upload'));

      request.headers.addAll(headers);
      request.fields['nama'] = nama;
      request.fields['tgl'] = tgl;
      
      request.files.add(http.MultipartFile('file',
          filePickerVal!.readAsBytes().asStream(), filePickerVal!.lengthSync(),
          filename: filePickerVal!.path.split("/").last));

      var res = await request.send();
      var responseBytes = await res.stream.toBytes();
      var responseString = utf8.decode(responseBytes);

      //debug
      debugPrint("response code: " + res.statusCode.toString());
      debugPrint("response: " + responseString.toString());

      final dataDecode = jsonDecode(responseString);
      debugPrint(dataDecode.toString());

      if (res.statusCode == 200) {

        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Informasi'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const <Widget>[
                    Text(
                        "File berhasil diupload"),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    //
                    Navigator.of(context, rootNavigator: false).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
       
      }
    } catch (e) {
      debugPrint('$e');
      
    }
  }

  convertDateFromString(String strDate) {
    DateTime date = DateTime.parse(strDate);
    return DateFormat("dd/MM/yyyy").format(date);
  }

  @override
  void initState() {
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
          title: const Text("Test Upload File"),
        ),
        body: Form(
            key: _formKey,
            child: ListView(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    key: Key(txtNama),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama file harus diisi';
                      } else {
                        return null;
                      }
                    },
                    controller: txtEditNama,
                    onSaved: (String? val) {
                      txtEditNama.text = val!;
                    },
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                          borderSide:
                              BorderSide(color: Colors.white, width: 2)),
                      hintText: 'Nama file',
                      contentPadding: EdgeInsets.all(10.0),
                    ),
                    style: const TextStyle(fontSize: 16.0)),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Nama File", style: TextStyle(fontSize: 16.0)),
              ),
              buildDatePicker(context),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Browse File", style: TextStyle(fontSize: 16.0)),
              ),
              buildFilePicker(),
              Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 32.0,
                ),
                label: const Text('SIMPAN',
                    style: TextStyle(fontSize: 18.0)),
                onPressed: () {
                  _validateInputs();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlue,
                  minimumSize: const Size(115, 55),
                  maximumSize: const Size(115, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            )
            ])));
  }
}

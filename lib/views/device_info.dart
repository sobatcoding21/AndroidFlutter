import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_information/device_information.dart';
//import 'package:flutter/foundation.dart';

class DeviceInfoPage extends StatefulWidget {
  const DeviceInfoPage({Key? key}) : super(key: key);

  @override
  State<DeviceInfoPage> createState() => _DeviceInfoPageState();
}

class _DeviceInfoPageState extends State<DeviceInfoPage> {


  String _platformVersion = 'Unknown',
      _imeiNo = "",
      _modelName = "",
      _manufacturerName = "",
      _deviceName = "",
      _productName = "",
      _cpuType = "",
      _hardware = "";
  String? _apiLevel;


  getDeviceInfo() async {
    late String platformVersion,
      imeiNo = '',
      modelName = '',
      manufacturer = '',
      deviceName = '',
      productName = '',
      cpuType = '',
      hardware = '';
    String? apiLevel;

    try {
      platformVersion = await DeviceInformation.platformVersion;
      imeiNo = await DeviceInformation.deviceIMEINumber;
      modelName = await DeviceInformation.deviceModel;
      manufacturer = await DeviceInformation.deviceManufacturer;
      apiLevel = await DeviceInformation.apiLevel;
      deviceName = await DeviceInformation.deviceName;
      productName = await DeviceInformation.productName;
      cpuType = await DeviceInformation.cpuName;
      hardware = await DeviceInformation.hardware;
    } on PlatformException catch (e) {
      platformVersion = '${e.message}';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = "Running on :$platformVersion";
      _imeiNo = imeiNo;
      _modelName = modelName;
      _manufacturerName = manufacturer;
      _apiLevel = apiLevel;
      _deviceName = deviceName;
      _productName = productName;
      _cpuType = cpuType;
      _hardware = hardware;
    });
  }

  @override
  void initState() {
    getDeviceInfo();
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
          title: const Text("Device Info"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Text('$_platformVersion\n'),
              const SizedBox(
                height: 10,
              ),
              Text('IMEI Number: $_imeiNo\n'),
              const SizedBox(
                height: 10,
              ),
              Text('Device Model: $_modelName\n'),
              const SizedBox(
                height: 10,
              ),
              Text('API Level: $_apiLevel\n'),
              const SizedBox(
                height: 10,
              ),
              Text('Manufacture Name: $_manufacturerName\n'),
              const SizedBox(
                height: 10,
              ),
              Text('Device Name: $_deviceName\n'),
              const SizedBox(
                height: 10,
              ),
              Text('Product Name: $_productName\n'),
              const SizedBox(
                height: 10,
              ),
              Text('CPU Type: $_cpuType\n'),
              const SizedBox(
                height: 10,
              ),
              Text('Hardware Name: $_hardware\n'),
              const SizedBox(
                height: 10,
              ),
              
            ],
          )
        ));
  }
}
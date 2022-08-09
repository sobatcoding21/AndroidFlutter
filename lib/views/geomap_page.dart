import 'package:androidflutter/widgets/cache_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart' as locationv2;
import 'package:trust_location/trust_location.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

class GeoMapPage extends StatefulWidget {
  const GeoMapPage({Key? key}) : super(key: key);

  @override
  State<GeoMapPage> createState() => _GeoMapPageState();
}

class _GeoMapPageState extends State<GeoMapPage> {
  locationv2.Location lokasi = locationv2.Location();
  double _latitude = 0;
  double _longitude = 0;
  String? _address;
  bool isLoading = true;
  final MapController _mapController = MapController();

  @override
  void initState() {
    requestPermission();

    getLocation();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> requestPermission() async {
    bool serviceEnabled;
    locationv2.PermissionStatus permissionGranted;
    serviceEnabled = await lokasi.serviceEnabled();

    //ceck service
    if (!serviceEnabled) {
      serviceEnabled = await lokasi.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }

    //ceck permission
    permissionGranted = await lokasi.hasPermission();
    if (permissionGranted == locationv2.PermissionStatus.denied) {
      permissionGranted = await lokasi.requestPermission();
      if (permissionGranted != locationv2.PermissionStatus.granted) {
        return false;
      }
    }

    return true;
  }

  Future<void> getLocation() async {
    final hasPermisson = await requestPermission();
    if (!hasPermisson) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Permission Denied'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const [
                    Text(
                        "Tanpa izin penggunaan lokasi aplikasi ini tidak dapat digunakan dengan baik. Apa anda yakin menolak izin pengaktifan lokasi?",
                        style: TextStyle(fontSize: 18.0)),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('COBA LAGI'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    requestPermission();
                  },
                ),
                TextButton(
                  child: const Text('SAYA YAKIN'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    } else {
      //get Location
      TrustLocation.start(5);
      try {
        TrustLocation.onChange.listen((values) {
          var mockStatus = values.isMockLocation;
          if (mockStatus == true) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  'Fake GPS terdeteksi. Mohon non aktifkan fitur Fake GPS Anda'),
            ));
            TrustLocation.stop();
            return;
          }

          if (mounted) {
            setState(() {
              isLoading = false;
              _latitude = double.parse(values.latitude.toString());
              _longitude = double.parse(values.longitude.toString());

              _mapController.move(LatLng(_latitude, _longitude), 13);

              getPlace();
            });
          }
        });
      } on PlatformException catch (e) {
        debugPrint('PlatformException $e');
      }
    }
  }

  void getPlace() async {
    List<Placemark> newPlace =
        await placemarkFromCoordinates(_latitude, _longitude);

    // this is all you need
    Placemark placeMark = newPlace[0];
    String name = placeMark.name.toString();
    String subLocality = placeMark.subLocality.toString();
    String locality = placeMark.locality.toString();
    String administrativeArea = placeMark.administrativeArea.toString();
    String postalCode = placeMark.postalCode.toString();
    String country = placeMark.country.toString();
    String address =
        "$name, $subLocality, $locality, $administrativeArea $postalCode, $country";

    setState(() {
      _address = address; // update _address
    });
  }

  Widget displayMap() {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        center: LatLng(_latitude, _latitude),
        zoom: 15,
        maxZoom: 19,
      ),
      layers: [
        MarkerLayerOptions(
          rotate: true,
          markers: [
            Marker(
              width: 40.0,
              height: 40.0,
              point: LatLng(_latitude, _longitude),
              anchorPos: AnchorPos.align(AnchorAlign.top),
              builder: (ctx) => const Icon(
                Icons.fmd_good,
                color: Colors.redAccent,
                size: 20.0,
              ),
            ),
          ],
        ),
      ],
      children: [
        TileLayerWidget(
          options: TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            tileProvider: CachedTileProvider(),
            subdomains: ['a', 'b', 'c'],
            maxZoom: 19,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Map"),
        ),
        body: Container(
            color: Colors.white,
            child: Stack(children: [
              Container(
                margin: const EdgeInsets.all(0),
                height: screenSize.height / 1.5,
                child: displayMap(),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: screenSize.height / 4,
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    margin:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(children: [
                        Visibility(
                          visible: isLoading ? true : false,
                          child: const CircularProgressIndicator(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 10),
                        isLoading
                            ? const Text("Sedang mencari lokasi ...")
                            : Text(
                                "Lokasi anda adalah \n: Lat : $_latitude \nLong : $_longitude"),
                        Text("Alamat : \n" + _address.toString(),
                            textAlign: TextAlign.center),
                        const SizedBox(height: 20),
                        Visibility(
                          visible: isLoading ? false : true,
                          child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.lightBlue,
                              ),
                              onPressed: () {
                                setState(() {
                                  isLoading = true;
                                  _address = "";
                                });
                                getLocation();
                              },
                              icon: const Icon(Icons.my_location_outlined),
                              label: const Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text("Refres Lokasi",
                                    style: TextStyle(fontSize: 16)),
                              )),
                        )
                      ]),
                    ),
                  ))
            ])));
  }
}

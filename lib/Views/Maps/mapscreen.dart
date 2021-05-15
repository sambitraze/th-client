import 'dart:async';
import 'package:client/Services/DeliveryBoyService.dart';
import 'package:client/Services/UserService.dart';
import 'package:client/Views/Maps/mapRequest.dart';
import 'package:client/models/User.dart';
import 'package:client/models/deliveryBoy.dart';
import 'package:client/models/order.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final Order order;
  MapScreen({this.order});
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  User client;
  DeliveryBoy deliveryBoy;
  double lat;
  double long;
  bool _isloading = false;
  BitmapDescriptor _clientIcon, _deliveryIcon;
  final Set<Polyline> _polyLines = {};
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  Set<Polyline> get polyLines => _polyLines;
  final Set<Marker> _markers = {};
  static LatLng latLng;

  @override
  void initState() {
    super.initState();
    getloc();
  }

  void _setmarkerIcon() async {
    _clientIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/user.png');
    _deliveryIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/delivery.png');
  }

  updateLocation() async {
    const oneSec = const Duration(seconds: 15);
    new Timer.periodic(oneSec, (Timer t) async {
      deliveryBoy = await DeliveryBoyService.getDeliveryBoyByEmail(widget.order.deliveryby.email);
      setState(() {
        sendRequest();
      });
    });
  }
  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  void sendRequest() async {
    LatLng destination = LatLng(double.parse(deliveryBoy.latitude),
        double.parse(deliveryBoy.longitude));
    String route =
        await _googleMapsServices.getRouteCoordinates(latLng, destination);
    print("route: $route");
    createRoute(route);
  }

  void createRoute(String encondedPoly) {
    setState(() {
      _polyLines.add(Polyline(
          polylineId: PolylineId(latLng.toString()),
          width: 4,
          points: _convertToLatLng(_decodePoly(encondedPoly)),
          color: Colors.orange));
    });
  }

  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = [];
    int index = 0;
    int len = poly.length;
    int c = 0;
    do {
      var shift = 0;
      int result = 0;

      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }

  void getloc() async {
    setState(() {
      _isloading = true;
      _setmarkerIcon();
    });
    client = await UserService.getUser();
    print(client.toJson());

    deliveryBoy = await DeliveryBoyService.getDeliveryBoyByEmail(widget.order.deliveryby.email);

     setState(() {
      latLng =
          LatLng(double.parse(client.latitude), double.parse(client.longitude));
    });
    setState(() {
      _isloading = false;
    });
  }

  void onMapCreated(controller) {
    setState(() {
      _controller.complete(controller);
      _markers.add(
        Marker(
            icon: _clientIcon,
            markerId: MarkerId("client"),
            position: LatLng(
              double.parse(client.latitude),
              double.parse(client.longitude),
            ),
            infoWindow: InfoWindow(
              title: client.name,
              snippet: "wating",
            )),
      );
      _markers.add(
        Marker(
            icon: _deliveryIcon,
            markerId: MarkerId("Delivery"),
             position: LatLng(double.parse(deliveryBoy.latitude),
                double.parse(deliveryBoy.longitude)),
            infoWindow: InfoWindow(
              title: deliveryBoy.name,
              snippet: "On the way",
            )),
      );
      sendRequest();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isloading
          ? Center(child: CircularProgressIndicator(valueColor:
                      new AlwaysStoppedAnimation<Color>(Color(0xff25354E))),)
          : Stack(
              children: [
                GoogleMap(
                  polylines: polyLines,
                  markers: _markers,
                  onMapCreated: onMapCreated,
                  mapType: MapType.normal,
                  initialCameraPosition:
                      CameraPosition(target: latLng, zoom: 12.0),
                ),
                // Container(
                //   alignment: Alignment.bottomLeft,
                //   child: RaisedButton(onPressed: () {
                //     sendRequest();
                //   }),
                // )
              ],
            ),
    );
  }
}

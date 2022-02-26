import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
class GoogleMapTemplate extends StatefulWidget {
  const GoogleMapTemplate({Key? key}) : super(key: key);

  @override
  _GoogleMapTemplateState createState() => _GoogleMapTemplateState();
}

class _GoogleMapTemplateState extends State<GoogleMapTemplate> {

  GoogleMapController? _controller;
  Location currentLocation = Location();
  Set<Marker> _markers={};

  void getLocation() async{
    var location = await currentLocation.getLocation();
    currentLocation.onLocationChanged.listen((LocationData loc){

      _controller?.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
        target: LatLng(loc.latitude ?? 0.0,loc.longitude?? 0.0),
        zoom: 14.0,
      )));
      print(loc.latitude);
      print(loc.longitude);
      setState(() {
        _markers.add(Marker(markerId: MarkerId('Home'),
            position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0)
        ));
      });
    });
  }

  @override
  void initState(){
    super.initState();
    setState(() {
      getLocation();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Locations"),),
      body: GoogleMap(
        zoomControlsEnabled: true,
        initialCameraPosition:CameraPosition(
          target: LatLng(48.8561, 2.2930),
          zoom: 14.0,
        ),
        onMapCreated: (GoogleMapController controller){
          _controller = controller;
        },
        markers: _markers,
      ),
    );
  }
}

import 'package:estacionamento/http/LocalizacaoService.dart';
import 'package:estacionamento/models/Localizacao.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mapa extends StatefulWidget {
  //final double latitude;
  //final double longitude;

  const Mapa({
    Key? key,
    //required this.latitude,
    //required this.longitude,
  }) : super(key: key);

  @override
  State<Mapa> createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  late GoogleMapController? mapController;
  late Position? minhaLocalizacao;
  late Set<Marker> marcadores = Set();
  /*
    Marker(
        markerId: MarkerId("1111111111"),
        position: LatLng(-25.5116852, -54.5967));
    Marker(
        markerId: MarkerId("22222222"),
        position: LatLng(-25.5173638, -54.5901208));
  */

  @override
  void initState() {
    super.initState();
    //_initMinhaLocalizacao();
    // _onMapCreated();
  }

  Future _initLocalizacoes() async {
    minhaLocalizacao = await _determinePosition();
  }

  Future _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    marcadores = await LocalizacaoService().pegarlocalizacoes();
  }

  @override
  Widget build(BuildContext context) {
    /*
    return FutureBuilder(
      future: _initLocalizacoes(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapchat) {
        if (snapchat.hasData) {
          return GoogleMap(
            //onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(target: LatLng(0.0, 0.0)),
            /*CameraPosition(
              target: LatLng(
                  minhaLocalizacao!.latitude, minhaLocalizacao!.longitude),
                  
              zoom: 14.0,
            ),
            */
            //markers: marcadores,
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
    */
/*
    return FutureBuilder(
      future: _onMapCreated(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapchat) {
        if (snapchat.hasData) {
          //final Position currentLocation = snapchat.data;
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target:
                  //LatLng(currentLocation.latitude, currentLocation.longitude),
                  LatLng(minhaLocalizacao!.latitude, minhaLocalizacao!.longitude),
              zoom: 14.0,
            ),
            //markers: Set<Marker>.of(marcadores),
            markers: <Marker>{
              Marker(
                markerId: MarkerId("12345"),
                position: LatLng(
                    minhaLocalizacao!.latitude, minhaLocalizacao!.longitude),
              ),
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
    */
/*
    return FutureBuilder<LocationData?>(
      future: _currentLocation(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapchat) {
        if (snapchat.hasData) {
          final LocationData currentLocation = snapchat.data;
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target:
                  LatLng(currentLocation.latitude!, currentLocation.longitude!),
              zoom: 14.0,
            ),
            markers: <Marker>{
              Marker(
                markerId: MarkerId("12345"),
                position: LatLng(
                    currentLocation.latitude!, currentLocation.longitude!),
              ),
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
    */

    return FutureBuilder<Position?>(
      future: _determinePosition(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapchat) {
        if (snapchat.hasData) {
          final Position currentLocation = snapchat.data;
          return GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target:
                  //LatLng(currentLocation.latitude, currentLocation.longitude),
                  LatLng(-25.4415572, -54.4026853),
              zoom: 14.0,
            ),
            markers: marcadores,
            /*
            <Marker>{
              Marker(
                markerId: MarkerId("12345"),
                position: LatLng(localizacao.latitude, localizacao.longitude),
              ),
            },
            */
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
/*
  Future<Set<Marker>> initEnderecos() async {
    Set<Marker> markers = Set();
    List<Location> locations = [];
    List<Localizacao> localizacoesEndereco =
        await LocalizacaoService().pegarlocalizacoes();

    for (var loc in localizacoesEndereco) {
      List<Location> variousLocations = await locationFromAddress(loc.endereco);

      Marker marker = Marker(
        markerId: MarkerId("loc.idEstacionamento"),
        position:
            LatLng(variousLocations[0].latitude, variousLocations[0].longitude),
      );
      markers.add(marker);
    }
    return markers;
  }
*/
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Serviços de localização estão desativados.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Permissao de localização foi negada.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Permissões de localização estão negadas permanentemente, não podemos requisitar mais permissões.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}

/*
  // Pega localização atual, mas n consigo usar pq o package location conflita classe location com o geocoding

  Future<LocationData?> _currentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    Location location = new Location();

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    return await location.getLocation();
  }
  */

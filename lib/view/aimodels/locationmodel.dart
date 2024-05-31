import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/services.dart';  // Importing services for Clipboard

class LocationModel extends StatefulWidget {

  @override
  _LocationModelState createState() => _LocationModelState();
}

class _LocationModelState extends State<LocationModel> {
  late FlutterTts flutterTts;
  String locationMessage = "Determining your location...";

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    determinePosition();
  }

  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        locationMessage = "Location services are disabled.";
      });
      speakText(locationMessage);
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          locationMessage = "Location permissions are denied.";
        });
        speakText(locationMessage);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        locationMessage = "Location permissions are permanently denied.";
      });
      speakText(locationMessage);
      return;
    }

    // When we reach here, permissions are granted and we can get the position of the device.
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    String address = await _getAddressFromLatLng(position);
    setState(() {
      locationMessage = "Your location is at $address";
    });
    speakText(locationMessage);
    copyToClipboard(locationMessage); // Copy location message to clipboard
  }

  Future<String> _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      String fullAddress = "${place.street}, ${place.locality}, ${place.country}";

      // Split the address into words and take the first seven
      List<String> words = fullAddress.split(' ');
      String truncatedAddress = words.take(7).join(' ');

      return truncatedAddress;
    } catch (e) {
      print(e);
      return "Unknown location";
    }
  }

  Future<void> speakText(String text) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    print("Copied to clipboard: $text");
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 12.0,
                left: 12,
              ),
              child: Container(
                height: 50,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25)),
                    color: Color(0xFFC04817),
                    shape: BoxShape.rectangle),
                child: InkWell(
                  onTap: () {
                    speakText("Back");
                  },
                  onDoubleTap: () {
                    Navigator.pop(context);
                  },
                  child:  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(width: 60.w,),
                      Text('Current Location',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(50.r),
                  gradient: LinearGradient(

                    transform: GradientRotation(double.parse("4")),
                    colors:   const [
                      Color(0xFF766B6B),
                      Color(0xddC04817),
                      Color(0xFF766B6B),

                    ],
                  ),
                  ///                 gradient: LinearGradient(transform: GradientRotation(double.parse("4")), colors: [Color(0xFFC04817),                   Color(0xFFC04817),],),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      locationMessage,
                      style: TextStyle(color: Colors.white,
                      fontSize:20.sp ),
                    ),
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

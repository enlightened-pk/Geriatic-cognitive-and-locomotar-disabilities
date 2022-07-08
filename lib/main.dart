// ignore_for_file: prefer_const_constructors, avoid_print
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_sms/flutter_sms.dart';
import 'package:geolocator/geolocator.dart';

import 'package:flutter/material.dart';
import 'package:memory_loss_app/pages/profile_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import '../user/user_data.dart';
import 'remain.dart';
import 'src/ui/homepage/homepage.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({key});


  @override
  Widget build(BuildContext context) {
    var user = UserData.myUser;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.grey[50], // Color for Android
        statusBarBrightness: Brightness.dark));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Memory Loss Assist'),
        //   backgroundColor: Colors.blueGrey[900],
        // ),
        body: SafeArea(
            child: Column(
          children: [
            //Custom App bar using Widget
            Container(
              // height: 50,
              width: double.infinity,
              // color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Memory Loss Assist', textScaleFactor: 1.5),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                    child: CircleAvatar(
                      radius: 20.0,
                      backgroundImage: AssetImage('images/iconsApp.png'),
                      // backgroundColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  // height: 100,
                  // width: 100,
                  // margin: EdgeInsets.all(16),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: Text(
                    'Welcome, ${user.name}',
                    textScaleFactor: 2,
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FaceRecogn()),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.asset('images/facetext.jpg'),
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: GestureDetector(
                    onTap: () async {
                      // launch('https://calendar.google.com/calendar');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MedicineReminder()),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.asset('images/remindertext.jpeg'),
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SosApp()),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.asset('images/sostext.jpeg'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}

class SosApp extends StatelessWidget {
  const SosApp({key});

  Future _sendSMS(String message, List<String> recipents) async {
    String result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(result);
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SOS'),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextField(
                controller: TextEditingController()
                  ..text =
                      'Name: Devan\nAge: 78\nBlood Group: A+ve\nGender: Male\nContact: 9562494783',
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
            Container(
              width: double.infinity,
              height: 75,
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: ElevatedButton(
                onPressed: () async {
                  // for getting position
                  Position position = await Geolocator.getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.high);

                  // Navigator.pop(context);

                  String message =
                      "SOS! Message from Devan. I need help! Location:"
                      " https://www.google.com/maps/@${position.latitude},${position.longitude},21z ";
                  // String message = "SOS! Message from Devan. I need help!";
                  List<String> recipents = ["9562494783"];

                  _sendSMS(message, recipents);
                },
                child: const Text(
                  'Send SOS Message',
                  textScaleFactor: 1.5,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 75,
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: ElevatedButton(
                onPressed: () async {
                  _makePhoneCall('9562494783');
                },
                child: const Text(
                  'SOS Call',
                  textScaleFactor: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FaceRecogn extends StatefulWidget {
  const FaceRecogn({Key key}) : super(key: key);

  @override
  State<FaceRecogn> createState() => _FaceRecognState();
}

class _FaceRecognState extends State<FaceRecogn> {
  File _image;
  Future getImagefromcamera() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;

    // final imageTemporary = File(image.path);
    setState(() {
      _image = File(image.path);
    });
  }

  Future getImagefromGallery() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      _image = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Facial Recognition"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Select an image",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200.0,
              child: Center(
                child: _image == null
                    ? Text("No Image is picked")
                    : Image.file(_image),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FloatingActionButton(
                onPressed: getImagefromcamera,
                tooltip: "Pick Image form gallery",
                child: Icon(Icons.add_a_photo),
              ),
              FloatingActionButton(
                onPressed: getImagefromGallery,
                tooltip: "Pick Image from camera",
                child: Icon(Icons.camera_alt),
              )
            ],
          )
        ],
      ),
    );
  }
}


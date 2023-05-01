import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testing_nearby_connections/ChatRoom/ChatRoom.dart';
import 'package:uuid/uuid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: FirebaseOptions(
      //     apiKey: "AIzaSyCqZKFRY3cG9ElNNyyOjBCzXM2lmjj0k1k",
      //     appId: "1:953574642243:web:f4c36c79de6abcfc47baf6",
      //     messagingSenderId: "953574642243",
      //     projectId: "hopeless-romantics",
      //     storageBucket: "hopeless-romantics.appspot.com")
    );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List deviceAvailable = ["oyoyo"];

  var result = "";

  var uid = Uuid().v1();


  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  @override
  void initState() {
    askPermin();
    // Nearby().askBluetoothPermission();
    print("${deviceAvailable.length}");
    super.initState();
    sk();
    handlePresed();

        // WidgetsBinding.instance.addObserver(this);
  }

  void askPermin() async {
    // bool b = await Nearby().askLocationPermission();
    bool d = await Nearby().checkBluetoothPermission();
    debugPrint("This is the response we've got for bluetooth permissions");
  }

  void sk() async {
    bool b = await Nearby().enableLocationServices();
    debugPrint("This is the response we've got for location Services");
  }

  void handlePresed() async {
    try {
      print("CHECKING");
      BluetoothState bluetoothState = await FlutterBluePlus.instance.state.first;
      // BluetoothDevice? connectedDevice = connectedDevices.isNotEmpty ? connectedDevices.first : null;

    setState(() {
      result = bluetoothState.name.toString();    
    });
      print(bluetoothState);
      
    } catch (e) {
      debugPrint(
          e.toString());
    }
  }
  

  void handlePresedd() async {

     var gg = FirebaseFirestore.instance.collection("bluetooth").doc(uid).set({
      "uid": uid
     });

    var ff = await FirebaseFirestore.instance
      .collection("bluetooth").get();

    if(ff.docs.length <= 2){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ChatRoom(uid: uid)          
          )
        );
    }
  }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this);

  //   super.dispose();
  //   Future DOIT =
  //       FirebaseFirestore.instance.collection("genral").doc(uid).delete();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(children: [

        // Padding(padding: EdgeInsets.symmetric(vertical: 20))
          Flexible(child: Container(), flex: 2,),

        result == "on"? Center(
          child: TextButton(
            onPressed: () => handlePresedd(),
            child: Column(children: [
              
              Text("CONNECTED"),
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              Text("Go to Chat Room",),
            ],) 
          ),
        ):Center(
           child: Text("The Bluetooth is turned Off"),
        ),

        // Column(
        //   children: [
        //     for (var i = 0; i < deviceAvailable.length; i++)
        //       Container(
        //         child: Text(
        //           "${deviceAvailable[i]}",
        //           style: TextStyle(color: Colors.red, fontSize: 20),
        //         ),
        //       )
        //   ],
          Flexible(child: Container(), flex: 3,),
        // ),
      ]), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

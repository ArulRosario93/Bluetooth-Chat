import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testing_nearby_connections/ChatRoom/ChatController.dart';

class ChatRoom extends StatefulWidget{
  const ChatRoom({super.key, required this.uid});

  final uid;

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> with WidgetsBindingObserver{

    TextEditingController _message = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      //SET SOME DATA TO COMPLETE
      print("CAling From life cycle");
      await FirebaseFirestore.instance
          .collection("bluetooth").doc(widget.uid).delete();
      // final CollectionReference collectionRef =
      // FirebaseFirestore.instance.collection("message");

      //   final QuerySnapshot querySnapshot = await collectionRef.get();

      //   for (DocumentSnapshot docSnapshot in querySnapshot.docs) {
      //     await docSnapshot.reference.delete();
      //   }

      //   await collectionRef.doc().delete();
      //     .;
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
        print("CAling From life cycle");
        await FirebaseFirestore.instance
          .collection("bluetooth").doc(widget.uid).delete();

        // final CollectionReference collectionRef = FirebaseFirestore.instance.collection("message");

        // final QuerySnapshot querySnapshot = await collectionRef.get();

        // for (DocumentSnapshot docSnapshot in querySnapshot.docs) {
        //   await docSnapshot.reference.delete();
        // }

        // await collectionRef.doc().delete();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 20,),
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.symmetric(vertical: 35)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.centerLeft,
                  child: Text("User", style: GoogleFonts.alegreyaSansSc(textStyle: TextStyle(color: Color.fromARGB(255, 0, 77, 139), fontWeight: FontWeight.bold, fontSize: 30),),),
                ),
                Expanded(
                  
                  child: ChatController(uid:widget.uid),
                ),
                Container(
                  // width: 289,
                  decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: Colors.black,
                                    width: 0.5))),
                  child: TextField(
                          keyboardType: TextInputType.multiline,
                          style: GoogleFonts.alegreyaSansSc(
                              textStyle: TextStyle(
                                fontSize: 18,
                            color:Colors.black,
                          )),
                          maxLines: null,

                          // autofocus: autoFocus,

                          // onFieldSubmitted: (v) async {
                          //   DateTime now = DateTime.now();
                          //   if (_message.text.isEmpty) {
                          //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //       elevation: 1.0,
                          //       // shape: ,
                          //       backgroundColor: Colors.black,
                          //       content:
                          //           Text("Text Field is Blank like your Life"),
                          //     ));
                          //   } else {
                          //     await AuthMethods().SendMessge(_message.text, uid,
                          //         now.toString(), arg["Name"]);
                          //   }
                          //   setState(() {
                          //     _message.text = "";
                          //   });
                          //   setState(() {
                          //     autoFocus = true;
                          //   });
                          // },
                          controller: _message,
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.allow
                          // ],
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            filled: true,
                            // border: ,

                            suffixIcon: TextButton(
                              
                                onPressed: () async {
                                  DateTime now = DateTime.now();
                                  String text = _message.text;
                                  String ttt = text.trim();
                                  // print(object);
                                  if (ttt.isEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      elevation: 1.0,
                                      // shape: ,
                                      backgroundColor: Colors.transparent,
                                      content: Text(
                                          "Text Field is Blank"),
                                    ));
                                  } else {
                                    await FirebaseFirestore.instance.collection("message").add({
                                      "datePublished": now,
                                      "header": false,
                                      "uid": widget.uid,
                                      "value": ttt
                                    });

                                  }
                                  setState(() {
                                    _message.text = "";
                                  });
                                },

                                child: new RotationTransition(
                                  turns: new AlwaysStoppedAnimation(-50 / 360),
                                  child: Icon(
                                    const IconData(0xe571,
                                        fontFamily: 'MaterialIcons',
                                        matchTextDirection: true),
                                    color: Colors.black,
                                    size: 17.0,
                                  ),
                                )),
                            floatingLabelBehavior: FloatingLabelBehavior.always,

                            fillColor: Colors.white,
                            // hoverColor: Colors.transparent,
                            hintStyle: GoogleFonts.alegreyaSansSc(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18)),
                            border: InputBorder.none,
                            hintText: "Type Message..",
                            contentPadding:
                                EdgeInsets.only(left: 25, top: 20, bottom: 20),
                          ),
                        ),
                )
              ],
            ),
          )
        ],
      ),),);
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:testing_nearby_connections/ChatRoom/ChatListing.dart';

class ChatController extends StatelessWidget {
  const ChatController({super.key, required this.uid});

  final uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("message")
                .orderBy("datePublished", descending: false)
                // .limit(70)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              //   if (oldSnap == newSnap) {
              //     same = true;
              //   } else {
              //     same = false;
              //     oldSnap = data[i]["uid"];

              print("Calling");
              print("Calling");
              print("Calling");
            
              //   }
              int totalLEn = snapshot.data!.docs.length;

              // final setMessgaes = snapshot.data!.docs.reversed;

              // final gg = setMessgaes.reversed;

              if (totalLEn > 1) {
                
              return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ChatList(totalLEn: totalLEn, snap: snapshot.data!.docs, uid: uid),
                );
              }

              return Container(
                child: Text("Start Chatting"),
              );


                  // child: ChatController(
                  //     snap: snapshot.data!.docs,
                  //     theme: widget.theme,
                  //     totalLEn: totalLEn,
                  //     uid: widget.uid)
              //     }
              // )
              // Container(
              // color: Colors.pink,
              // height: 250,
              // child:
              // ListView.builder(
              //   itemCount: len,
              //   // controller: _scrollController,
              //   scrollDirection: Axis.vertical,
              //   physics: NeverScrollableScrollPhysics(),
              //   // shrinkWrap: true,
              //   // controller: _scrollController,
              //   itemBuilder: (context, i) {
              //     newSnap = data[i]["uid"];

              //     if (oldSnap == newSnap) {
              //       same = true;
              //     } else {
              //       same = false;
              //       oldSnap = data[i]["uid"];
              //     }

              //     return Container(
              //       child: Column(
              //         crossAxisAlignment: data[i]["uid"] != widget.uid
              //             ? CrossAxisAlignment.start
              //             : CrossAxisAlignment.end,
              //         children: [
              //           // for (var i = 0; i <= 5; i++)
              //           ChatContainer(
              //               snap: data[i],
              //               sayIt: same,
              //               uid: widget.uid,
              //               pic: widget.pic,
              //               Name: widget.Name)
              //         ],
              //       ),
              //     );

              //     // Container(
              //     //   child: Column(
              //     //     crossAxisAlignment: data[i]["uid"] != widget.uid
              //     //         ? CrossAxisAlignment.start
              //     //         : CrossAxisAlignment.end,
              //     //     children: [
              //     //       for (var i = 0; i <= 5; i++)
              //     //         ChatContainer(
              //     //             snap: data[i],
              //     //             sayIt: same,
              //     //             uid: widget.uid,
              //     //             pic: widget.pic,
              //     //             Name: widget.Name)
              //     //     ],
              //     //   ),
              //     // );
            });
  }
}
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:show_up_animation/show_up_animation.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key, required this.totalLEn, required this.snap, required this.uid});

  final totalLEn;
  final snap;
  final uid;

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {

    final ScrollController _scrollController = ScrollController();



  @override
  Widget build(BuildContext context) {
    
    Timer(
      Duration(milliseconds: 0),
      () => _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          )
        );

    return ListView.builder(
        // controller: _scrollController,
                controller: _scrollController,

        itemCount: widget.totalLEn,
        itemBuilder: ((context, index) {
          String oldSnap = "";
          String newSnap = "";
          String nextSnap = "";
          String preSnap = "";

          bool same;
          bool nexChaned;
          bool prevChanged;
          bool lastone;

          int getINT = index;

          // if (widget.totalLEn - 1 == getINT) {
          //   nextSnap = "";
          // } else {
          //   nextSnap = widget.snap[index + 1]["uid"];
          // }
          newSnap = widget.snap[index]["header"]? "itshead": widget.snap[index]["uid"];
          oldSnap = index - 1 < 0 ? "" : widget.snap[index - 1]["header"]? "head": widget.snap[index - 1]["uid"];

          // if (widget.snap[index]["header"]) {
            if (oldSnap == newSnap) {
              same = false;
              prevChanged = false;
            } else {
              prevChanged = true;
              same = true;
            }

            if (widget.totalLEn == getINT + 1) {
              nextSnap = "";
              lastone = true;
            } else {
              nextSnap = widget.snap[index + 1]["header"]? "": widget.snap[index + 1]["uid"];
              lastone = false;
            }

            if (newSnap == nextSnap) {
              nexChaned = false;
            } else {
              nexChaned = true;
            }

          return Column(
                  crossAxisAlignment: widget.snap[index]["uid"] == widget.uid
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                        ShowUpAnimation( 
                        delayStart: Duration(seconds: 0),
                        animationDuration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                        direction: Direction.vertical,
                        offset: widget.snap[index]["uid"] == widget.uid? 0.5: -0.5,
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 220),
                          margin: EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            border: widget.snap[index]["uid"] == widget.uid? Border.all(color: Color.fromARGB(255, 0, 255, 191)): Border.all(color: Color.fromARGB(255, 0, 0, 0)),
                            borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                          padding: EdgeInsets.symmetric(vertical: 7, horizontal: 12),
                          child: Text(widget.snap[index]["value"], style: GoogleFonts.hubballi(textStyle: TextStyle(color: Colors.black, fontSize: 18),),),
                          ),
                        )                      
                    ]);
        }));;
  }
}
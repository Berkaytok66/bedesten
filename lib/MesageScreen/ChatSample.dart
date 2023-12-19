import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';


///Sohbet balonlarının belirlendiği widgetlar
class ChatSample extends StatelessWidget {
  final MessageType type;
  final String message;
  const ChatSample({super.key, required this.type, required this.message});

  @override
  Widget build(BuildContext context) {
    if (type == MessageType.receive) {
      return Padding(
        padding: EdgeInsets.only(right: 80),
        child: ClipPath(
          clipper: UpperNipMessageClipper(MessageType.receive),//gönderilen mesajj
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
            ),
            child: Text(message, style: TextStyle(fontSize: 16,color: Colors.white)),
          ),
        ),
      );
    }else{
      return Container(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.only(top: 20, left: 80),
          child: ClipPath(
            clipper: LowerNipMessageClipper(MessageType.send),// Alınan mesaj

            child: Container(
              padding: EdgeInsets.only(left: 20, top: 10, bottom: 25, right: 20),
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Text(
                message,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      );
    }

  }
}
/*return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.only(right: 80),
          child: ClipPath(
            clipper: UpperNipMessageClipper(MessageType.receive),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFFE1E1E2),
              ),
              child: Text("Deneme Gelen Mesaj",
              style: TextStyle(
                fontSize: 16
              ),),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(top: 20,left: 80),
            child: ClipPath(
              clipper: LowerNipMessageClipper(MessageType.send),
              child: Container(
                padding: EdgeInsets.only(left: 20,top: 10,bottom: 25,right: 20),
                decoration: BoxDecoration(
                  color: Color(0xFF7165D6)
                ),
                child: Text("Deneme Giden Mesaj",style: TextStyle(color: Colors.white,fontSize: 16),),
              ),
            ),
          ),
        )
      ],
    );*/
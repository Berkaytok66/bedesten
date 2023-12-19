import 'package:bedesten/AppLocalizations/AppLocalizations.dart';
import 'package:bedesten/MesageScreen/ChatSample.dart';
import 'package:bedesten/MesageScreen/MesageModel/MesageModel.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';

class SmsScreenPage extends StatefulWidget {
  final String imgLogoIndex;
  final String NameIndex;

  const SmsScreenPage({Key? key, required this.imgLogoIndex, required this.NameIndex})
      : super(key: key);

  @override
  _SmsScreenPageState createState() => _SmsScreenPageState();
}

class _SmsScreenPageState extends State<SmsScreenPage> {
  List<ChatMessage> messages = [];
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String imgLogoindex = widget.imgLogoIndex;
    String Nameindex = widget.NameIndex;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          backgroundColor:Theme.of(context).scaffoldBackgroundColor,
          leadingWidth: 30,
          title: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(imgLogoindex),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    Nameindex,
                    style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black54,),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(top: 8, right: 15),
              child: Icon(
                Icons.more_vert,
                size: 30,
                color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black54,
              ),
            )
          ],
          iconTheme: IconThemeData(
            color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, // Replace with your color
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        padding: EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 80),
        itemBuilder: (context, index) => ChatSample(
          type: messages[index].type,
          message: messages[index].message,
        ),
      ),
      bottomSheet: Container(
        height: 65,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(blurRadius: 10, spreadRadius: 2, color: Colors.black12)
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(
                Icons.add,
                size: 30,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(
                Icons.emoji_emotions,
                color: Colors.amber,
                size: 30,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Container(
                alignment: Alignment.centerRight,
                width: MediaQuery.of(context).size.width / 1.6,
                child: TextFormField(
                  controller: messageController,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context).translate("MessagesMainPage.WriteYourMessage"),//Mesajınızı Yazın...
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    messages.add(ChatMessage(
                        type: MessageType.send, message: messageController.text));
                  });
                  messageController.clear();
                  var model = MesageModel(
                      k_name: widget.NameIndex, k_Image: widget.imgLogoIndex);
                  MesageModel.k_list.add(model);
                },
                icon: Icon(Icons.send),
                iconSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChatMessage {
  final MessageType type;
  final String message;

  ChatMessage({required this.type, required this.message});
}

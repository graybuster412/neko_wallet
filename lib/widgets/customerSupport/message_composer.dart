import 'package:flutter/material.dart';
import 'package:neko_wallet/extensions/hex_color.dart';

class MessageComposer extends StatelessWidget {
  MessageComposer({Key? key, this.onPressPhoto, required this.onPressSend})
      : super(key: key);

  final VoidCallback? onPressPhoto;

  final ValueChanged<String> onPressSend;

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        height: 70.0,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.photo),
                iconSize: 25.0,
                color: Colors.blueAccent.shade100,
                onPressed: this.onPressPhoto),
            Expanded(
                child: TextField(
              controller: _controller,
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 15,
                  color: HexColor.fromHex("#333333")),
              textCapitalization: TextCapitalization.sentences,
              cursorColor: Colors.black,
              decoration:
                  InputDecoration.collapsed(hintText: 'Send a message...'),
            )),
            IconButton(
              icon: Icon(Icons.send),
              iconSize: 25.0,
              color: Colors.blueAccent.shade100,
              onPressed: () {
                this.onPressSend(_controller.text);
              },
            )
          ],
        ));
  }
}

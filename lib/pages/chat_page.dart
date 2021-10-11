import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChatPage extends StatefulWidget {

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final _textControler = TextEditingController();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [

            Row(
              children: [
                Spacer(),
                CircleAvatar(
                  child: Text('Te', style: TextStyle(fontSize: 12),),
                  backgroundColor: Colors.blueAccent.shade100,
                  maxRadius: 16,
                ),
                Spacer()
              ],
            ),

            SizedBox(height: 5,),
            Text('Agustin Cola', style: TextStyle(color: Colors.black87, fontSize: 12),)
          ],
        ),
      ),

      body: Container(
        child: Column(
          children: [

            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (_, i) => Text('$i'),
                reverse: true,
              )
            ),

            Divider(height: 15, color: Colors.black,),

            //TODO caja de texto

            Container(
              color: Colors.white,
              child: _inputChat(),
            )

          ],
        ),
      ),
   );
  }

  Widget _inputChat() => SafeArea(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _textControler,
              onSubmitted: _handleSubmit,
              onChanged: (String texto){
                //TODO cuando postear
              },
              decoration: InputDecoration.collapsed(hintText: 'Enviar Mensaje'),
              focusNode: _focusNode,
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            child: Platform.isIOS 

            ? CupertinoButton(
              child: Text('Enviar'), 
              onPressed: (){}
            )

            : Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: IconButton(
                icon: Icon(Icons.send, color: Colors.blue.shade400,),
                onPressed: (){},
              ),
            )
          )

        ],
      ),
    ),
  );

  _handleSubmit(text){
    print(text);
    _focusNode.requestFocus();
    _textControler.clear();
  }

}
import 'dart:io';

import 'package:chat_app/widgets/chat_menssage_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChatPage extends StatefulWidget {

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin{

  final _textControler = TextEditingController();
  final _focusNode = FocusNode();

  final List<ChatMessage> _messages = [
    /*ChatMessage(text: 'Primer Mensaje', uid: '123',),
    ChatMessage(text: 'Segundo mensaje', uid: '15',),
    ChatMessage(text: 'Tercer mensaje', uid: '123',),
    ChatMessage(text: 'Cuarto mensaje', uid: '25',),*/
  ];

  bool _isWriting = false;

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
                itemBuilder: (_, i) => _messages[i],
                itemCount: _messages.length,
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
              onChanged: (String text){
                setState(() {
                  if(text.trim().length > 0) {
                    _isWriting = true;
                  }else{
                    _isWriting = false;
                  }
                });
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
              onPressed: _isWriting 
                  ? () => _handleSubmit(_textControler.text.trim())
                  : null,
            )

            : Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: IconTheme(
                data: IconThemeData(color: Colors.blue),
                child: IconButton(
                  icon: Icon(Icons.send),
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: _isWriting 
                  ? () => _handleSubmit(_textControler.text.trim())
                  : null,
                ),
              ),
            )
          )

        ],
      ),
    ),
  );

  _handleSubmit(String text){

    if(text.length == 0) return;

    _focusNode.requestFocus();
    _textControler.clear();

    final newMessage = ChatMessage(
      text: text, 
      uid: '123',
      animationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 800)
      ),
    );
    newMessage.animationController.forward();
    _messages.insert(0, newMessage);
    setState(() {
      _isWriting = false;
    });
  }

  @override
  void dispose() {
    //TODO off del socvket
    _messages.forEach((element) {
      element.animationController.dispose();
    });
    super.dispose();
  }

}
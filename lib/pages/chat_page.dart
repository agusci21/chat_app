import 'dart:io';

import 'package:chat_app/models/mensajes_response_model.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/widgets/chat_menssage_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ChatPage extends StatefulWidget {

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin{

  final _textControler = TextEditingController();
  final _focusNode = FocusNode();
  late ChatService chatService;
  late SocketService socketService;
  late AuthService authService;

  final List<ChatMessage> _messages = [];

  bool _isWriting = false;

  @override
  void initState() {
    super.initState();
    this.chatService = Provider.of<ChatService>(context, listen: false);
    this.socketService = Provider.of<SocketService>(context, listen: false);
    this.authService = Provider.of<AuthService>(context, listen: false);

    this.socketService.socket.on('mensaje-personal',_escucharMensaje);

    _cargarHistorial(this.chatService.usuarioPara.uid);
  }

  void _cargarHistorial(String usuarioId) async {

    List<Mensaje> chat = await this.chatService.getChat(usuarioId);

    final history = chat.map((m) => ChatMessage(
      text: m.mensaje,
      uid: m.de,
      animationController: AnimationController(
        vsync: this,
        duration: Duration(seconds: 0)
      )..forward(),
    ));
    setState(() {
      _messages.insertAll(0, history);
    });
  }

  void _escucharMensaje(payload) {
    ChatMessage message = ChatMessage(
      text: payload['mensaje'],
      uid: payload['de'],
      animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 400)),
    );
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {

    final usuarioPara = chatService.usuarioPara; 

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.1),
          width: double.infinity,
              child: Column(
                children: [
                  CircleAvatar(
                  child: Text(usuarioPara.nombre.substring(0,2), style: TextStyle(fontSize: 12),),
                  backgroundColor: Colors.blueAccent.shade100,
                  maxRadius: 16,
                  ),
                  Text(usuarioPara.nombre, style: TextStyle(color: Colors.black87, fontSize: 12),)
                ],
              ),
        ),
          
        
        /*Column(
          children: [

            Row(
              children: [
                Spacer(),
                CircleAvatar(
                  child: Text(usuarioPara.nombre.substring(0,2), style: TextStyle(fontSize: 12),),
                  backgroundColor: Colors.blueAccent.shade100,
                  maxRadius: 16,
                ),
                Spacer()
              ],
            ),

            SizedBox(height: 5,),
            Text('Agustin Cola', style: TextStyle(color: Colors.black87, fontSize: 12),)
          ],
        ),*/
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
      uid: authService.usuario.uid,
      animationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 800)
      ),
    );
    newMessage.animationController.forward();
    _messages.insert(0, newMessage);
    setState(() {_isWriting = false;});
    socketService.emit('mensaje-personal', {
      'de' : authService.usuario.uid,
      'para' : this.chatService.usuarioPara.uid,
      'mensaje' : text
    });
  }

  @override
  void dispose() {
    _messages.forEach((element) => element.animationController.dispose());
    this.socketService.socket.off('mensaje-personal');
    super.dispose();
  }

}
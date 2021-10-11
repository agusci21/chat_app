import 'package:chat_app/models/usuario_model.dart';
import 'package:flutter/material.dart';

class UsuariosPage extends StatefulWidget {



  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {

  final List<Usuario> usuarios = [

    Usuario(uid: '1', nombre: 'Agustin', email: 'test001@yopmail.com', online: true),
    Usuario(uid: '2', nombre: 'Sonia', email: 'test002@yopmail.com', online: false),
    Usuario(uid: '3', nombre: 'Gustavo', email: 'test003@yopmail.com', online: true),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Spacer(),
            Text('Mi Nombre', style: TextStyle(color: Colors.black87)),
            Spacer()
          ],
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.exit_to_app,
            color: Colors.black87,
          ),
          onPressed: (){},
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(Icons.check_circle, color: Colors.blue[400]),
            //child: Icon(Icons.offline_bolt, color: Colors.red,),
          )
        ],
      ),
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, i) => ListTile(
          title: Text(usuarios[i].nombre),
          leading: CircleAvatar(
            child: Text(usuarios[i].nombre.substring(0,2)),
          ),
          trailing: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: usuarios[i].online ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(100)
            ),
          ),
        ), 
        separatorBuilder: (_, i) => Divider(), 
        itemCount: usuarios.length,
      )
   );
  }
}
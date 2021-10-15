import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:chat_app/models/usuario_model.dart';

class UsuariosPage extends StatefulWidget {



  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  final List<Usuario> usuarios = [

    Usuario(uid: '1', nombre: 'Agustin', email: 'test001@yopmail.com', online: true),
    Usuario(uid: '2', nombre: 'Sonia', email: 'test002@yopmail.com', online: false),
    Usuario(uid: '3', nombre: 'Gustavo', email: 'test003@yopmail.com', online: true),

  ];

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Spacer(),
            Text(authService.usuario.nombre, style: TextStyle(color: Colors.black87)),
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
          onPressed: (){
            
            socketService.disconnect();
            AuthService.deleteToken();
            Navigator.pushReplacementNamed(context, 'login');

          },
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: socketService.serverStatus == ServerStatus.OnLine 
            ? Icon(Icons.check_circle, color: Colors.blue[400])
            : Icon(Icons.offline_bolt, color: Colors.red),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        child: _listViewUsuarios(),
        enablePullDown: true,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400]),
          waterDropColor: Colors.blue.shade400,
        ),
        onRefresh: _cargarUsuarios,
      )
   );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => _usuarioListTile(usuarios[i]), 
      separatorBuilder: (_, i) => Divider(color: Colors.black54,), 
      itemCount: usuarios.length,
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
        title: Text(usuario.nombre),
        subtitle: Text(usuario.email),
        leading: CircleAvatar(
          child: Text(usuario.nombre.substring(0,2)),
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: usuario.online ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(100)
          ),
        ),
        onTap: (){},
      );
  }
  _cargarUsuarios()async{
    await Future.delayed(Duration(seconds: 1));
    _refreshController.refreshCompleted();
  }
}
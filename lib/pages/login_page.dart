import 'package:chat_app/helpers/mostrar_alerta_helper.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/widgets/boton_azul_widget.dart';
import 'package:chat_app/widgets/custom_input_widget.dart';
import 'package:chat_app/widgets/label_widget.dart';
import 'package:chat_app/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo(titulo: 'Messanger',),
                _Form(),

                Labels(
                  ruta: 'register', 
                  texto: '¿No tienes Cuenta?',
                   textoBoton: 'Crea una ahora'
                ),
                
                Text('Terminos y condiciones de uso', style: TextStyle(fontWeight: FontWeight.w400),)
              ],
            ),
          ),
        ),
      )
   );
  }
}

class _Form extends StatefulWidget {
  _Form({Key? key}) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
   final authService = Provider.of<AuthService>(context);
   final socketService = Provider.of<SocketService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40,),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [

          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'E-mail',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),

          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Password',
            textController: passCtrl,
            isPassword: true,
          ),

          BotonAzul(
            color: authService.autenticando ? Colors.grey : Colors.blue,
            text: authService.autenticando ? 'Cargando' : 'Ingrese',
            onPressed:authService.autenticando ? null : () async {
              FocusScope.of(context).unfocus();
              final bool loginOk = await authService.login(emailCtrl.text.trim(), passCtrl.text.trim());
              if(loginOk){
                socketService.connect();
                Navigator.pushReplacementNamed(context, 'usuarios');
              }else{
                mostrarAlerta(context, 'Login incorrecto', 'Credenciales invalidas');
              }
            },
          )

        ],
      ),
    );
  }
}



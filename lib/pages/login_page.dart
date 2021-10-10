import 'package:chat_app/widgets/boton_azul_widget.dart';
import 'package:chat_app/widgets/custom_input_widget.dart';
import 'package:chat_app/widgets/label_widget.dart';
import 'package:chat_app/widgets/logo_widget.dart';
import 'package:flutter/material.dart';


class LoadingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Logo(),
            _Form(),
            Labels(),
            Text('Terminos y condiciones de uso', style: TextStyle(fontWeight: FontWeight.w400),)
          ],
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
            text: 'Ingrese',
            onPressed:(){
              print(emailCtrl.text);
              print(passCtrl.text);
            },
          )

        ],
      ),
    );
  }
}


//Exportar logo y labels
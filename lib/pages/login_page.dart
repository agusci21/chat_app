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
            _Logo(),
            _Form(),
            _Labels(),
            Text('Terminos y condiciones de uso', style: TextStyle(fontWeight: FontWeight.w400),)
          ],
        ),
      )
   );
  }
}

class _Logo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 50),
        width: 170,
        child: Column(
          children: [
            Image(image: AssetImage('assets/tag-logo.png')),

            SizedBox(height: 20,),

            Text('Messenger',style: TextStyle(fontSize: 30),),
          ],
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  _Form({Key? key}) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(),

          TextField(),

          ElevatedButton(
            onPressed: (){},
            child: Text(''),
          ),
        ],
      ),
    );
  }
}

class _Labels extends StatelessWidget {
  const _Labels({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          children: [
            Text('¿No Tienes Cuenta?', style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300)),
            SizedBox(height: 10),
            Text('Crea una ahora', style: TextStyle(color: Colors.blue[600], fontSize: 18, fontWeight: FontWeight.bold),)
          ],
      )
    );
  }
}
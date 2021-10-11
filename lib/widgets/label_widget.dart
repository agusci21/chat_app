import 'package:flutter/material.dart';

class Labels extends StatelessWidget {

  final String ruta;
  final String texto;
  final String textoBoton;

  const Labels({required this.ruta, required this.texto, required this.textoBoton});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          children: [
            Text(texto, style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300)),
            SizedBox(height: 10),
            GestureDetector(
              child: Text(
                textoBoton,
                style: TextStyle(color: Colors.blue[600], fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: (){
                Navigator.pushReplacementNamed(context, ruta);
              },
            )
          ],
      )
    );
  }
}

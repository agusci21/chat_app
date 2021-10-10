import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {

  final Function()? onPressed;
  final String text;

  const BotonAzul({Key? key, required this.onPressed, this.text = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
            height: 55,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10000)
            ),
            child: MaterialButton(
                onPressed: onPressed,
                elevation: 2,
                child: Text(text ,style: TextStyle(color: Colors.white, fontSize: 20),),
            ),
    );
  }
}


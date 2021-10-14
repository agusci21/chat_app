import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {

  final Function()? onPressed;
  final String text;
  final Color color;

  const BotonAzul({Key? key, required this.onPressed, this.text = '', this.color = Colors.blue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
            height: 55,
            width: double.infinity,
            decoration: BoxDecoration(
              color: color,
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


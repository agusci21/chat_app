import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.only(top: 5,left: 5,bottom: 5,right: 20),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: Offset(0,7),
                  blurRadius: 5
                )
              ],
              borderRadius: BorderRadius.circular(30),
              color: Colors.white
            ),
            child: TextField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.mail_outline),
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                hintText: 'E-Mail'
              ),
            ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:otptextfield/otptextfield.dart';

class ExamplePinEntry extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Pin Entry Example"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: OtpTextField(
            numberOfFields: 5,
            borderColor: Color(0xFF512DA8),
            onCodeChanged: (String value) {

            },
            onSubmit: (String verificationCode){
              //navigate to different screen code goes here
              showDialog(
                  context: context,
                  builder: (context){
                    return AlertDialog(
                      title: Text("Verification Code"),
                      content: Text('Code entered is $verificationCode'),
                    );
                  }
              );
            }, // end onSubmit
          ), // end PinEntryTextField()
        ), // end Padding()
      ), // end Container()
    );
  }
}
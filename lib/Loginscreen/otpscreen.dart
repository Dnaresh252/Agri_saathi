import 'dart:developer';

import 'package:agri_saathi/Loginscreen/loginscreen.dart';
import 'package:agri_saathi/appscreens/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Otpscreen extends StatefulWidget {
  String verificationid;
  Otpscreen({super.key,required this.verificationid});

  @override
  State<Otpscreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends State<Otpscreen> {
  TextEditingController otpcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: otpcontroller,
              keyboardType:TextInputType.number ,
              decoration: InputDecoration(
                  hintText: "Enter phone NUmber",
                  suffixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24)
                  )

              ),
            ),
          ),
          SizedBox(height: 30,),
          ElevatedButton(onPressed: () async {
            try{
             PhoneAuthCredential credential=await PhoneAuthProvider.credential(verificationId:widget.verificationid,
                 smsCode:  otpcontroller.text.toString());
             FirebaseAuth.instance.signInWithCredential(credential).then((onValue){
             Navigator.push(context, MaterialPageRoute(builder:(context)=>Homescreen() ));
             });

            }catch(ex)
            {
            log(ex.toString());
            }
          }, child:Text("otp") ),
        ],
      ) ,
    );
  }
}

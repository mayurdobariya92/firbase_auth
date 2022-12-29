import 'package:firbase_auth/dashbord.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:otp_text_field/otp_field.dart';

class phonenumber extends StatefulWidget {
  const phonenumber({Key? key}) : super(key: key);

  @override
  State<phonenumber> createState() => _phonenumberState();
}

class _phonenumberState extends State<phonenumber> {
  

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if(user!=null){

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return dashbord();
        },));
      });

    }
  }
  TextEditingController number = TextEditingController();
  TextEditingController otpp = TextEditingController();

  FirebaseAuth auth=FirebaseAuth.instance;

  String vid ="";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Phone otp auth"),),
      body: Column(
        children: [
          TextField(controller: number,),

          ElevatedButton(onPressed: () async {
            await FirebaseAuth.instance.verifyPhoneNumber(
              phoneNumber: '+91 ${number.text}',
              verificationCompleted: (PhoneAuthCredential credential) async {

                await auth.signInWithCredential(credential);
              },
              verificationFailed: (FirebaseAuthException e) {
                if(e.code=='invalid phone number')
                  {
                    print('The provide phone number is not valid');
                  }
              },
              codeSent: (String verificationId, int? resendToken) {
                vid=verificationId;
                setState(() {

                });
              },
              codeAutoRetrievalTimeout: (String verificationId) {},
            );
          }, child: Text(" Send Otp")),
          OtpTextField(numberOfFields: 6,
            borderColor: Color(0xFF512DA8),
            //set to true to show as box or false to show as dash
            showFieldAsBox: true,
            //runs when a code is typed in
            onCodeChanged: (String code) {

            },
            //runs when every textfield is filled
            onSubmit: (String verificationCode) async {
              String smsCode = verificationCode;
              PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: vid, smsCode: smsCode);

              // Sign the user in (or link) with the credential
              await auth.signInWithCredential(credential).then((value) {
                print(value);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return dashbord();
                },));
              });
            }, // end ),

          ),
          TextField(controller: otpp,),
          ElevatedButton(onPressed: () async {
            String smsCode = '${otpp.text}';
            PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: vid, smsCode: smsCode);
            await auth.signInWithCredential(credential).then((value) {
              print(value);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return dashbord();
              },));
            });
          }, child: Text("Verify Otp"))


        ],

      )
      
            
    );
  }
}


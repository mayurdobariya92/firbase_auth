import 'package:firbase_auth/dashbord.dart';
import 'package:firbase_auth/firebase_Cloud_database.dart';
import 'package:firbase_auth/firebase_realtime_database.dart';
import 'package:firbase_auth/phonenumber.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    
  );
  runApp(MaterialApp(home: clouddatabase(),));
}
class fireauth extends StatefulWidget {
  const fireauth({Key? key}) : super(key: key);

  @override
  State<fireauth> createState() => _fireauthState();
}

class _fireauthState extends State<fireauth> {

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if(user!=null)
      {
        print("login");
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return dashbord();
          },));
        });

      }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Email Authsign"),),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: () {
              signInWithGoogle().then((value)  {
                print(value);
                if(value!=null)
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return dashbord();
                    },));
                  }
              });
            }, child: Text("google sign")),
          ],
        ),
      ),
    );
  }


}

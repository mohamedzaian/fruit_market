import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fruit_market/screen/complete_info_screen.dart';
import 'package:fruit_market/screen/home_screen.dart';
import 'package:fruit_market/utils/main_color.dart';
import 'package:google_sign_in/google_sign_in.dart';



class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 166,
            width: 221,
            child: Image.asset('assets/images/PngItem_2746375.png'),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Fruit Market',
            style: TextStyle(
                color: mainColor, fontSize: 50, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 138,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: ()  async {
                   final UserCredential user = await signInWithGoogle();
                   if (user != null)
                     {
                       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){
                         return CompleteInfoScreen();
                       }), (route) => false);
                     }
                  },
                  style: ElevatedButton.styleFrom(foregroundColor: Colors.black,
                    backgroundColor: Colors.white
                  ),
                  child: Row(
                    children: [
                      Container(
                        child: Image.asset('assets/images/search (7).png'),
                        height: 26,
                        width: 26,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Login with')
                    ],
                  ),
                ),
                SizedBox(width: 15,),
                ElevatedButton(
                  onPressed: () {
                    signInWithFacebook();
                  },
                  style: ElevatedButton.styleFrom(foregroundColor: Colors.black,
                  backgroundColor: Colors.white),
                  child: Row(
                    children: [
                      Container(
                        child: Image.asset('assets/images/facebook (6).png'),
                        height: 26,
                        width: 26,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Login with')
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );

  }
  Future<UserCredential> signInWithGoogle(
      ) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
      scopes: ['email']
    ).signIn();

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
  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

}

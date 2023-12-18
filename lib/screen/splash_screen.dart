import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fruit_market/screen/home_screen.dart';
import 'package:fruit_market/screen/onboarding_screen.dart';
import 'package:fruit_market/utils/size_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  AnimationController? animation;
  Animation<double>? fadingAnimation;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 5),
        ()
        {
          if (FirebaseAuth.instance.currentUser == null) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return OnboardingScreen();
        }));
      }
          else
            {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){
                return HomeScreen();
              }), (route) => false);
            }
    }


    );
    super.initState();
    animation = AnimationController(vsync: this , duration: Duration(milliseconds: 1000));
    fadingAnimation = Tween<double>(begin: 0.2,end: 1).animate(animation!)..addListener(() {
      setState(() {
       if (animation!.isCompleted)
         {
           animation!.repeat(reverse: true);
         }

      });
    });
    animation!.forward();

  }
  @override
  void dispose() {
    animation!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xff69A03A),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Opacity(
            opacity: fadingAnimation!.value,
            child: Text(
              'Fruit Market',
              style: TextStyle(
                  color: Color(0xffFFFFFF),
                  fontSize: 50,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 57,),
          Opacity(
            opacity: fadingAnimation!.value,
              child: Image.asset('assets/images/734854.png'))

        ],
      ),
    );
  }
}

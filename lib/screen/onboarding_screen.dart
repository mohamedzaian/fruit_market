import 'package:flutter/material.dart';
import 'package:fruit_market/onbording_items/onbording_items.dart';
import 'package:fruit_market/screen/login_screen.dart';
import 'package:fruit_market/utils/custom_dot.dart';
import 'package:fruit_market/utils/main_color.dart';
import 'package:fruit_market/utils/size_config.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController? pageController;

  @override
  void initState() {
    super.initState();

    pageController = PageController(initialPage: 0)
      ..addListener(() {
        setState(() {

        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            child: PageView(
              controller: pageController,
              children: [
                OnboardingItems(
                    image: 'assets/images/Group 2804.png',
                    title: 'E Shopping',
                    subtitle: 'Explore  top organic fruits & grab them'),
                OnboardingItems(
                    image: 'assets/images/Group 2805.png',
                    title: 'Delivery on the way',
                    subtitle: 'Get your order by speed delivery'),
                OnboardingItems(
                    image: 'assets/images/Group 2806.png',
                    title: 'Delivery Arrived',
                    subtitle: 'Order is arrived at your Place'),
              ],
            ),
          ),
          Positioned(
            top: SizeConfig.defultSize! * 8,
            right: 31,
            child: Visibility(
              visible: pageController!.hasClients ? (pageController!.page == 2 ? false : true) : true,
              child: TextButton(
                  onPressed: () {
                    if (pageController!.page != 2)
                      {
                        pageController!.nextPage(duration: Duration(
                          milliseconds: 500
                        ), curve: Curves.easeIn);
                      }

                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(
                        color: mainColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ),
          Positioned(
            bottom: SizeConfig.defultSize! * 10,
            right: SizeConfig.defultSize! * 10,
            left: SizeConfig.defultSize! * 10,
            child: ElevatedButton(
                onPressed: () {
                  if (pageController!.page != 2)
                  {
                    pageController!.nextPage(duration: Duration(
                        milliseconds: 500
                    ), curve: Curves.easeIn);
                  }
                  else
                    {
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){
                        return LoginScreen();
                      }), (route) => false);
                    }

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                ),
                child: Text(
                  pageController!.hasClients ? (pageController!.page == 2 ? 'GetStart' : 'Next') : 'Next',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white),
                )),
          ),
          Positioned(
              bottom: SizeConfig.defultSize! * 18,
              right: 0,
              left: 0,
              child: CustomDotts(
                  dotindex:
                      pageController!.hasClients ? pageController!.page! : 0)
          )
        ],
      ),
    );
  }
}

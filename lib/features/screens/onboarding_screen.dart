import 'package:flutter/material.dart';
import 'package:learn_flutter/features/screens/home.dart';
import 'package:learn_flutter/features/screens/login_registration_page.dart';
import 'package:learn_flutter/utils/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen ({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[
          PageView(
              controller:_controller,
            children: [
              FirstPage(controller:_controller),
              SecondPage(controller:_controller),
            ]
          ),
          Positioned(top: 2*FontSizes.padding, left: FontSizes.padding,child: SmoothPageIndicator(controller: _controller, count:2, effect: WormEffect(),))



        ]

      )
    );
  }
}
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key, required this.image, required this.title,
  });

  final String image, title;

  @override
  Widget build(BuildContext context) {
    return
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            width: MediaQuery
                .sizeOf(context)
                .width * 0.8,
            image: AssetImage(image),
          ),
          SizedBox(
            width: 300,
            child: Text(title, style: FontStyles.subheading,
              textAlign: TextAlign.center,),
          )
        ],
      );
  }
}
class FirstPage extends StatelessWidget {
  const FirstPage({super.key, required this.controller});
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(child: OnboardingPage(image:'assets/images/onboarding/undraw_to-do-list_dzdz-Photoroom.png', title: 'The perfect app to track what to do today')),
          Positioned(
            bottom: FontSizes.padding,
            right: FontSizes.padding,
            child: ElevatedButton(onPressed: () {

              controller.animateToPage(1, duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
            },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AllColors.primaryAccent,
                  shape: CircleBorder()
              ),
              child: Icon(Icons.navigate_next, color: AllColors.background),

            ),
          )
      ]
      )
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key, required this.controller});
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children:[
          Center(child: OnboardingPage(image:'assets/images/onboarding/undraw_workspace_s6wf-Photoroom.png', title: "Get your work done more efficiently with Vaish's To Do")),
          Positioned(
              bottom: FontSizes.padding,
              left: FontSizes.padding,
              child: ElevatedButton(onPressed: () {
                controller.animateToPage(0, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);

              },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AllColors.primaryAccent,
                    shape: CircleBorder()
                ),
                child: Icon(Icons.navigate_before, color: AllColors.background),

              )
          ),
          Positioned(
              bottom: FontSizes.padding,
              right: FontSizes.padding,
              child: ElevatedButton(onPressed: () {
                completeOnboarding(context);

              },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AllColors.primaryAccent,
                    shape: CircleBorder()
                ),
                child: Icon(Icons.navigate_next, color: AllColors.background),

              )


          )


        ]

      )
    );
  }
}

Future<void> completeOnboarding(BuildContext context) async{
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('seenOnboarding', true);
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  LoginPage()));
}





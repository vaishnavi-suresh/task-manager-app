import 'package:learn_flutter/features/controllers/auth.dart';
import 'package:learn_flutter/features/screens/home.dart';
import 'package:learn_flutter/features/screens/login_registration_page.dart';
import 'package:learn_flutter/features/screens/onboarding_screen.dart';
import'package:flutter/material.dart';
import 'package:learn_flutter/features/controllers/onboarding_controller.dart';


class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  bool ? _seenOnboarding;
  late final LaunchController _launchController;
  late final VoidCallback _listener;

  @override
  initState(){
    super.initState();
    _launchController = LaunchController();
    _listener = () {setState(() {});};
    _launchController.addListener(_listener);
    _getLaunchStatus();
  }

  @override
  void dispose(){
    _launchController.removeListener(_listener);
    _launchController.dispose();
    super.dispose();

  }

  Future<void> _getLaunchStatus() async{
    await _launchController.isReady;
    final seen = _launchController.seenOnboarding;
    setState(() {
      _seenOnboarding = seen;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(_seenOnboarding==null){
      return Center(child: CircularProgressIndicator()); //REPLACE WITH SPLASH IN SOPHISTICATED VERSION
    }
    else if (_seenOnboarding == false){
      return OnboardingScreen();
    }
   return StreamBuilder(stream: Auth().authStateChanges, builder:(context,snapshot){
     if (snapshot.hasData){
       print(snapshot.data);
       return HomeScreen();
     } else{
       return LoginPage();
     }
   });
  }
}



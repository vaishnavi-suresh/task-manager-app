import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LaunchController extends ChangeNotifier{
  bool ? _seenOnboarding;
  bool? get seenOnboarding => _seenOnboarding;
  late final Future<void> _isReady;
  Future<void> get isReady => _isReady;


  LaunchController(){
    _isReady = _loadLaunchStatus();
  }
  Future<void> _loadLaunchStatus() async{
    final prefs = await SharedPreferences.getInstance();
    _seenOnboarding = prefs.getBool('seenOnboarding') ?? false;
    notifyListeners();
  }
  Future<void> completeOnboarding() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('seenOnboarding',true);
    _seenOnboarding = true;
    notifyListeners();


  }
}
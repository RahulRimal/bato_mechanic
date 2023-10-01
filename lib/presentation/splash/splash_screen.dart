import 'package:bato_mechanic/presentation/splash/splash_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  late SplashScreenViewModel _splashViewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _splashViewModel =
          Provider.of<SplashScreenViewModel>(context, listen: false);
      _splashViewModel.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amberAccent[200],
        body: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ));
  }
}

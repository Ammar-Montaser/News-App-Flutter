import 'package:articles_app/features/auth/presentation/pages/LoginScreen.dart';
import 'package:articles_app/features/auth/presentation/pages/SignUpScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: size.height * 0.33,
            // bottom: -30,
            child: Lottie.asset("assets/images/wave.json",
                width: size.width, alignment: Alignment.center),
          ),
          SafeArea(
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "BLOGGY",
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Where words come to life!",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Lottie.asset("assets/images/lottieWelcome.json",
                          width: size.width * 0.8),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        child: IconButton.filled(
                          iconSize: 80,
                          alignment: Alignment.center,
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context, LoginScreen.route(), (route) => false);
                          },
                          icon: Icon(Icons.arrow_circle_right),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

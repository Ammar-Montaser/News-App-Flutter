import 'package:articles_app/core/theme/app_pallete.dart';
import 'package:articles_app/features/auth/presentation/pages/SignUpScreen.dart';
import 'package:articles_app/features/auth/presentation/widgets/AuthFields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static route() => MaterialPageRoute(
        builder: (context) => SignUpScreen(),
      );
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Welcome Back...",
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    AuthFields(
                        hintText: "Email",
                        controller: emailController,
                        isObscureText: false),
                    SizedBox(
                      height: 20,
                    ),
                    AuthFields(
                      hintText: "Password",
                      controller: passwordController,
                      isObscureText: true,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 60,
                      width: size.width * 0.7,
                      child: ElevatedButton(
                        style: Theme.of(context)
                            .elevatedButtonTheme
                            .style!
                            .copyWith(
                              maximumSize: MaterialStatePropertyAll(
                                Size(100, 60),
                              ),
                            ),
                        onPressed: () {},
                        child: Text("SIGN IN"),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, LoginScreen.route());
                },
                child: RichText(
                  text: TextSpan(
                      text: "Don\'t have an account?",
                      style: Theme.of(context).textTheme.bodySmall,
                      children: [
                        TextSpan(
                            text: "  SIGN UP",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: LightTheme.brandingColor))
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

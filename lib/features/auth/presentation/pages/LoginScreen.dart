import 'package:articles_app/core/common/widgets/loader.dart';
import 'package:articles_app/core/theme/app_pallete.dart';
import 'package:articles_app/core/utils/snackbar.dart';
import 'package:articles_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:articles_app/features/auth/presentation/pages/SignUpScreen.dart';
import 'package:articles_app/features/auth/presentation/widgets/AuthFields.dart';
import 'package:articles_app/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static route() => MaterialPageRoute(
        builder: (context) => LoginScreen(),
      );
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var showPassword = true;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void tooglePassword() {
      setState(() {
        showPassword = !showPassword;
      });
    }

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "WELCOME BACK",
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Column(
                children: [
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthFailure) {
                        showSnackBar(context, state.message);
                      } else {
                        if (state is AuthSuccess) {
                          Navigator.pushAndRemoveUntil(
                              context, BlogPage.route(), (route) => false);
                        }
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return Loader();
                      }

                      return Form(
                        key: formKey,
                        child: Column(
                          children: [
                            AuthFields(
                              hintText: "Email",
                              controller: emailController,
                              isObscureText: false,
                              isPassword: false,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            AuthFields(
                              hintText: "Password",
                              controller: passwordController,
                              isObscureText: showPassword,
                              isPassword: true,
                              func: tooglePassword,
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
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    BlocProvider.of<AuthBloc>(context).add(
                                        Authlogin(emailController.text.trim(),
                                            passwordController.text.trim()));
                                  }
                                },
                                child: Text("SIGN IN"),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, SignUpScreen.route());
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
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:articles_app/core/common/widgets/loader.dart';
import 'package:articles_app/core/theme/app_pallete.dart';
import 'package:articles_app/core/utils/snackbar.dart';
import 'package:articles_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:articles_app/features/auth/presentation/pages/LoginScreen.dart';
import 'package:articles_app/features/auth/presentation/widgets/AuthFields.dart';
import 'package:articles_app/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static route() => MaterialPageRoute(
        builder: (context) => SignUpScreen(),
      );
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var showPassword = true;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
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
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    "Create A New Account",
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
                              hintText: "Name",
                              controller: nameController,
                              isObscureText: false,
                              isPassword: false,
                            ),
                            SizedBox(
                              height: 20,
                            ),
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
                                        AuthSignup(
                                            nameController.text.trim(),
                                            emailController.text.trim(),
                                            passwordController.text.trim()));
                                  }
                                },
                                child: Text("SIGN UP"),
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
                          text: "Already have an account?",
                          style: Theme.of(context).textTheme.bodySmall,
                          children: [
                            TextSpan(
                                text: "  SIGN IN",
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

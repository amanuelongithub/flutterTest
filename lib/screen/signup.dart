import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../main.dart';
import '../service/aut_methods.dart';
import '../utils/colors..dart';
import '../components/default_button.dart';
import 'home_screen.dart';
import 'package:get/get.dart';

class SignupPage extends StatefulWidget {
  final VoidCallback onClickedSignIn;
  const SignupPage({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(context),
        borderRadius: BorderRadius.circular(10));
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          children: [
            Form(
              child: Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      SizedBox(height: 60),
                      Center(
                        child: Column(
                          children: const [
                            Text(
                              "Create new",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 35),
                            ),
                            Text(
                              "Account",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 60),
                      TextFormField(
                        controller: usernameController,
                        showCursor: true,
                        cursorColor: Theme.of(context).primaryColor,
                        enableInteractiveSelection: true,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: "Username",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 126, 126, 126),
                              fontWeight: FontWeight.bold),
                          border: inputBorder,
                          suffixIcon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              FaIcon(
                                FontAwesomeIcons.user,
                                size: 20,
                                color: Color.fromARGB(255, 126, 126, 126),
                              ),
                            ],
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 126, 126, 126),
                                width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: emailController,
                        showCursor: true,
                        cursorColor: Theme.of(context).primaryColor,
                        enableInteractiveSelection: true,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 126, 126, 126),
                              fontWeight: FontWeight.bold),
                          border: inputBorder,
                          suffixIcon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                Icons.mail_outline,
                                // FontAwesomeIcons.,
                                size: 20,
                                color: Color.fromARGB(255, 126, 126, 126),
                              ),
                            ],
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 126, 126, 126),
                                width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: passwordController,
                        showCursor: true,
                        cursorColor: Theme.of(context).primaryColor,
                        enableInteractiveSelection: true,
                        textInputAction: TextInputAction.next,
                        // maxLength: 9,
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 126, 126, 126),
                              fontWeight: FontWeight.bold),
                          border: inputBorder,
                          suffixIcon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.lock_outline,
                                semanticLabel: "regular",
                                size: 20,
                                color: Color.fromARGB(255, 126, 126, 126),
                              ),
                            ],
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 126, 126, 126),
                                width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      DefaultButton(text: "Create", press: signUpUser),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: 30),
              child: RichText(
                  text: TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignIn,
                      text: 'Have Account?',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: AppColors.maincolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18))),
            )
          ],
        ),
      ),
    );
  }

  void signUpUser() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(color: AppColors.seccolor),
            ));

    String res = await AuthMethods().signUpUser(
        email: emailController.text.trim(),
        username: usernameController.text,
        password: passwordController.text.trim());
    if (res != "success") {
      Get.snackbar(res, "");
    }
    navigatorKey.currentState!.popUntil((rout) => rout.isFirst);
  }
}

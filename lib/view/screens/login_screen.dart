import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_4/controller/auth_controller.dart';
import 'package:task_4/view/screens/profile_screen.dart';
import 'package:task_4/view/screens/signup_screen.dart';
import 'package:task_4/view/screens/widgets/custom_ui.dart';
import 'package:task_4/view/screens/widgets/dialogbox.dart';

class LoginScreen extends StatefulWidget {
  bool? isFirstTime;
  LoginScreen({
    super.key,
    this.isFirstTime,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    widget.isFirstTime ??= false;
    if (widget.isFirstTime!) {
      Future.delayed(Duration.zero, () {
        ScaffoldMessenger.of(context).showSnackBar(CustomGui.customSnackbar(
            'Success',
            'Registeration Successful! Please verify your email & proceed to login.'));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    AuthController authController = Get.put(AuthController());

    return GetBuilder<AuthController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                height: 250.h,
                width: 380.w,
                child: Image.asset(
                  'assets/images/login_Illustration.png',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 167.h),
                height: 480.h,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(132, 83, 216, 0.387),
                      Color.fromRGBO(68, 70, 68, 0.302),
                    ],
                  ),
                  color: Color.fromARGB(255, 146, 110, 187),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 18.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30.h),
                    Text(
                      "Welcome Back!",
                      style: GoogleFonts.poppins(
                        fontSize: 33,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const Text(
                      "welcome back we missed you",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white54,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    CustomGui.customTextField(
                      hintText: 'Username',
                      controller: emailController,
                      iconImage: 'assets/images/name_icon.png',
                    ),
                    SizedBox(height: 15.h),
                    CustomGui.customPasswordTextField(
                      hintText: 'Password',
                      controller: passwordController,
                      iconImage: 'assets/images/password_icon.png',
                      isObscured: controller.isObscure,
                      authController: controller,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.white60),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                        width: double.infinity,
                        child: CustomGui.customButton1(
                            text: 'Sign In',
                            onPressed: () async {
                              authController.logOut();
                              if (emailController.text == "" ||
                                  passwordController.text == "") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    CustomGui.customSnackbar('Warning',
                                        'Please enter both email and password..'));
                              } else {
                                if (authController
                                    .isValidEmail(emailController.text)) {
                                  int isVerfied = await authController.login(
                                      emailController.text,
                                      passwordController.text);
                                  if (isVerfied == 0) {
                                    showDialog(
                                      context: context,
                                      builder: (context) =>
                                          EmailVerificationDialog(
                                              onResend: authController
                                                  .sendEmailVerfication),
                                    );
                                  } else if (isVerfied == 2) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        CustomGui.customSnackbar('Warning',
                                            'Please check your internet connection'));
                                  } else if (isVerfied == 4) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        CustomGui.customSnackbar('Warning',
                                            'Invalid email or password'));
                                  } else {
                                    Get.offAll(() => ProfileScreen());
                                  }
                                }
                              }
                            })),
                    SizedBox(height: 15.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account yet?',
                          style: TextStyle(fontSize: 10,color: Colors.white),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                            onTap: () {
                              Get.off(SignupScreen());
                            },
                            child: Text('Sign up instead',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.orange,
                                    fontWeight: FontWeight.w500))),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1.h,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.white,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: Text(
                            "Or continue with",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1.h,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white,
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomGui.socialButton(
                            text: '',
                            imagePath: 'assets/images/google_image.png',
                            onPressed: () async {
                              User? user = await authController.loginGoogle();
                              if (user != null) {
                                Get.to(() => ProfileScreen());
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    CustomGui.customSnackbar(
                                        'Warning', 'Login Failed!'));
                              }
                            }),
                        SizedBox(width: 10.w),
                        CustomGui.socialButton(
                            text: '',
                            imagePath: 'assets/images/apple_image.png',
                            onPressed: () {}),
                        SizedBox(width: 10.w),
                        CustomGui.socialButton(
                            text: '',
                            imagePath: 'assets/images/facebook_image.png',
                            onPressed: () {}),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.h),
                height: 250.h,
                width: 380.w,
                child: Image.asset(
                  'assets/images/bg_image.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

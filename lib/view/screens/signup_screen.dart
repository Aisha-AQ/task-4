import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_4/controller/auth_controller.dart';
import 'package:task_4/view/screens/login_screen.dart';
import 'package:task_4/view/screens/profile_screen.dart';
import 'package:task_4/view/screens/widgets/custom_ui.dart';
import 'package:task_4/view/screens/widgets/dialogbox.dart';

class SignupScreen extends StatefulWidget {
  bool? isFirstTime;
  SignupScreen({
    super.key,
    this.isFirstTime,
  });

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<String> selectedGender = ValueNotifier<String>("Male");

    final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();
    AuthController authController = Get.put(AuthController());

    return GetBuilder<AuthController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                height: 170.h,
                width: 350.w,
                child: Padding(
                  padding: EdgeInsets.only(left: 100.h),
                  child: Image.asset(
                    'assets/images/sign_up_ilustration.png',
                    fit: BoxFit.scaleDown,
                  ),
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
                      "Get Started Free!",
                      style: GoogleFonts.poppins(
                        fontSize: 33,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const Text(
                      "Free Forever. No Credit Card Required",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white54,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    CustomGui.customTextField(
                      hintText: 'Email',
                      controller: emailController,
                      iconImage: 'assets/images/name_icon.png',
                    ),
                    SizedBox(height: 15.h),
                    CustomGui.customTextField(
                      hintText: 'Username',
                      controller: usernameController,
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
                    SizedBox(height: 10.h),
                    CustomGui.genderRadio(selectedGender),
                    SizedBox(height: 15.h),
                    SizedBox(
                        width: double.infinity,
                        child: CustomGui.customButton1(
                            text: 'Sign Up',
                            onPressed: () async {
                              try {
                                if (!CustomGui.emailRegex
                                    .hasMatch(emailController.text)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      CustomGui.customSnackbar('Warning',
                                          'Please enter a valid email.'));
                                } else if (passwordController.text.length <=
                                    7) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      CustomGui.customSnackbar('Warning',
                                          'Password must be at least 8 characters long!'));
                                } else if (emailController.text.isNotEmpty ||
                                    passwordController.text.isNotEmpty ||
                                    selectedGender.value.isNotEmpty ||
                                    usernameController.text.isNotEmpty) {
                                  authController
                                      .signUp(emailController.text,
                                          passwordController.text)
                                      .then((_) {
                                    authController.addUserToDatabase(
                                      usernameController.text,
                                      emailController.text,
                                      selectedGender.value,
                                    );
                                  });
                                  Get.offAll(() => LoginScreen(
                                        isFirstTime: true,
                                      ));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      CustomGui.customSnackbar('Warning',
                                          'Please fill in all the required fields!'));
                                }
                              } on FirebaseException catch (e) {
                                Get.snackbar("Error", "$e");
                              }
                            })),
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
                              User? user =
                                  await authController.signInWithGoogle();
                              if (user != null) {
                                Get.off(ProfileScreen());
                              } else {
                                print('Google sign-in canceled or failed.');
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

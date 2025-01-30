import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_4/controller/auth_controller.dart';

class CustomGui {
  static Widget customButton(String text, Function() onPressed) {
    return Container(
        height: 45.h,
        width: 280.w,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            elevation: 3, 
            padding:
                EdgeInsets.symmetric(horizontal: 50, vertical: 10), 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0), 
            ),
          ),
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ));
  }

  static Widget customFormField(String labelText, String validatorText,
      bool isPasswordType, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.black),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Color(0x000000),
          ),
        ),
      ),
      obscureText: isPasswordType,
      enableSuggestions: !isPasswordType,
      autocorrect: !isPasswordType,
      keyboardType: isPasswordType
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
      validator: (value) {
        if (value == null) {
          return validatorText;
        }
        return null;
      },
    );
  }

  static Widget textField(TextEditingController controller, String text) {
    return SizedBox(
        height: 45.h,
        width: 280.w,
        child: TextFormField(
          controller: controller,
          style: TextStyle(
              color: Colors.deepOrange.shade900,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none),
          decoration: InputDecoration(
            labelText: text,
            labelStyle: TextStyle(
              fontSize: 16,
              color: Colors.blueGrey,
            ),
            floatingLabelStyle: TextStyle(
              color: Colors.deepOrange,
            ),
            hintText: 'Enter your $text',
            hintStyle: TextStyle(
                color: Colors.deepOrange.shade300,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blueGrey,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.deepOrange,
                width: 2,
              ),
            ),
          ),
        ));
  }

  static Widget genderRadio(ValueNotifier<String> selectedGender) {
    return ValueListenableBuilder<String>(
      valueListenable: selectedGender,
      builder: (context, value, child) {
        return Row(
          children: [
            Radio<String>(
              value: "Male",
              groupValue: value,
              onChanged: (newValue) {
                selectedGender.value = newValue!;
              },
            ),
            Text("Male",style: TextStyle(color: Colors.white),),
            Radio<String>(
              value: "Female",
              groupValue: value,
              onChanged: (newValue) {
                selectedGender.value = newValue!;
              },
            ),
            Text("Female",style: TextStyle(color: Colors.white),),
            Radio<String>(
              value: "Other",
              groupValue: value,
              onChanged: (newValue) {
                selectedGender.value = newValue!;
              },
            ),
            Text("Other",style: TextStyle(color: Colors.white),),
          ],
        );
      },
    );
  }

  static final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static Widget primaryButton(String name, Function()? onPressed,
      {bool isDisabled = false}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDisabled ? Colors.blueGrey : Colors.deepOrange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        name,
        style: isDisabled
            ? TextStyle(color: Colors.deepOrange)
            : TextStyle(color: Colors.deepOrange.shade500),
      ),
    );
  }

  static Widget secondaryButton(String name, Function()? onPressed,
      {bool isDisabled = false}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDisabled ? Colors.blueGrey : Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
            side: BorderSide(color: Colors.deepOrange, width: 2)),
      ),
      child: Text(
        name,
        style: isDisabled
            ? TextStyle(color: Colors.deepOrange)
            : TextStyle(color: Colors.deepOrange),
      ),
    );
  }

  static Widget textButton(String name, Function()? onPressed,
      {bool isDisabled = false}) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Colors.deepOrange.shade900,
        backgroundColor: Colors.deepOrange.shade100,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: Text(
        name,
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static Widget customTextField(
      {required String hintText,
      required TextEditingController controller,
      required String iconImage}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(255, 255, 255, 0.287),
            const Color.fromRGBO(68, 70, 68, 0.302),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              iconImage,
              width: 24.w,
              height: 24.h,
            ),
          ),
          border: InputBorder.none, 
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          hintStyle: const TextStyle(color: Colors.white54),
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  static Widget customPasswordTextField(
      {required String hintText,
      required TextEditingController controller,
      required String iconImage,
      required bool isObscured,
      required AuthController? authController}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(255, 255, 255, 0.287),
            const Color.fromRGBO(68, 70, 68, 0.302),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: TextFormField(
        obscureText: isObscured,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              iconImage,
              width: 24.w,
              height: 24.h,
            ),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              authController!.isObscure
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: Colors.white70,
            ),
            onPressed: () {
              authController.toggleIsObscure();
            },
          ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          hintStyle: const TextStyle(color: Colors.white54),
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  static Widget customButton1(
      {required String text, required Function()? onPressed}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(176, 55, 236, 0.846),
            Color.fromRGBO(231, 128, 32, 0.89),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  static Widget socialButton({
    required String text,
    required String imagePath,
    required Function() onPressed,
  }) {
    return Container(
      width: 50.w,
      height: 34.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(255, 255, 255, 0.407),
            Color.fromRGBO(68, 70, 68, 0.409),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 28.w,
            height: 24.h,
          ),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
  static SnackBar customSnackbar(String title, String message) {
  return SnackBar(
    content: Row(
      children: [
        const Icon(Icons.warning_amber_outlined, color: Color.fromRGBO(176, 55, 236, 0.846),), 
         SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    ),
    backgroundColor: const Color.fromARGB(255, 204, 172, 216), 
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    margin: const EdgeInsets.all(16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 3),
  );
}
}

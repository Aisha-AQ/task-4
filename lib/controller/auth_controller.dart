import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_4/model/user_data_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  bool isNotAuthorised = false;
  bool invalidEmailFormat = false;
  UserDataModel? userModel;
  bool isObscure = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<void> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Sign up failed: $e');
    }
  }

  void toggleIsObscure() {
    isObscure = !isObscure;
    update();
  }

  Future<int> login(email, password) async {
    try {
      var user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      isNotAuthorised = false;
      bool userExists = await fetchingUserDataFromFireStore();

      if (userExists) {
        await FirebaseAuth.instance.currentUser?.reload();
        userModel!.emailVerified =
            FirebaseAuth.instance.currentUser?.emailVerified ?? false;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          'emailVerified': userModel!.emailVerified,
        });
        if (!(userModel!.emailVerified!)) {
          return 0;
        } else {
          update();
          return 1;
        }
      }
      return 3;
    } on FirebaseAuthException catch (e) {
      isNotAuthorised = true;
      if (e.code == 'invalid-credential') {
        return 4;
      } else {
        update();
        return 2;
      }
    }
  }
  Future<void> updatePassword(String newPassword) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updatePassword(newPassword);
      await FirebaseAuth.instance.signOut(); 
    } else {
      print("No user is signed in.");
    }
  } catch (e) {
    print("Error updating password: $e");
  }
}
  void logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      userModel = null;
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  Future<void> addUserToDatabase(
    String username,
    String email,
    String gender,
  ) async {
    final userID = FirebaseAuth.instance.currentUser;
    final docRef =
        FirebaseFirestore.instance.collection("users").doc(userID!.uid);
    final userDataModel = UserDataModel(
        name: username,
        email: email,
        gender: gender,
        id: userID.uid,
        emailVerified: false);
    await docRef.set(userDataModel.toMap());
    sendEmailVerfication();
  }

  Future<void> sendEmailVerfication() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  Future<bool> fetchingUserDataFromFireStore() async {
    final userId = FirebaseAuth.instance.currentUser;
    try {
      DocumentSnapshot docRef = await FirebaseFirestore.instance
          .collection("users")
          .doc(userId!.uid)
          .get();

      if (docRef.exists) {
        UserDataModel userData = UserDataModel.fromDocumentSnapshot(docRef);
        userModel = userData;
        update();
        return true;
      } else {
        Get.snackbar("Error", "User not found.");
        return false;
      }
    } on FirebaseException catch (e) {
      Get.snackbar("Error", "$e");
      return false;
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('Error: $e');
    }
  }

  bool isValidEmail(String email) {
    final emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    invalidEmailFormat = !emailRegExp.hasMatch(email);
    update();
    return emailRegExp.hasMatch(email);
  }

  Future<User?> signInWithGoogle() async {
    try {
      if (_googleSignIn.currentUser != null) {
        await _googleSignIn.disconnect();
        await FirebaseAuth.instance.signOut();
      }
      await _googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        await saveUserToFirestore(user);
      }
      userModel = UserDataModel(
          id: user!.uid,
          name: user.displayName ?? "No Name",
          email: user.email,
          emailVerified: true,
          gender: 'Female');

      return userCredential.user;
    } catch (e) {
      print('Error during Google sign-in: $e');
      return null;
    }
  }

  Future<void> saveUserToFirestore(User user) async {
    try {
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);

      DocumentSnapshot doc = await userRef.get();

      if (!doc.exists) {
        await userRef.set({
          'uid': user.uid,
          'name': user.displayName ?? "No Name",
          'email': user.email,
          'emailVerified': true,
          'gender': 'Female'
        });
      }
    } catch (e) {
      print("Error saving user to Firestore: $e");
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    userModel = null;
    await _auth.signOut();
  }

  Future<User?> loginGoogle() async {
    if (_googleSignIn.currentUser != null) {
      await _googleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();
    }
    await _googleSignIn.signOut();
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser == null) {
      return null;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final User? user = userCredential.user;

    if (user != null) {
      await saveUserToFirestore(user);
    }
    userModel = UserDataModel(
        id: user!.uid,
        name: user.displayName ?? "No Name",
        email: user.email,
        emailVerified: true,
        gender: 'Female');
    return user;
  }
}

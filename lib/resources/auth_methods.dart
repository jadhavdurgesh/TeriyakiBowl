import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:teriyaki_bowl_app/models/user_model.dart' as model;
import 'package:teriyaki_bowl_app/views/splash_screen.dart';

import '../utils/utils.dart';
import '../views/login_screen.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  // signing up the user
  Future<String> signUpUser(
      {required String email,
      required String fullName,
      required String mobile,
      required String password}) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty || fullName.isNotEmpty || mobile.isNotEmpty) {
        // register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        // add user to the database
        model.User user = model.User(
          uid: cred.user!.uid,
          email: email,
          fullName: fullName,
          password: password,
          mobile: mobile,
          favourite: [],
          ratings: [],
          orders: [],
          address: [],
        );

        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());

        await _firestore
            .collection('cart')
            .doc(cred.user!.uid)
            .set({"uid": cred.user!.uid, "items": [], "cart_amount": 0.00});

        await _firestore.collection('orders').doc(cred.user!.uid).set({
          "uid": cred.user!.uid,
          "orders": [],
          "unreviewed": [],
          "reviews": []
        });

        res = 'success';
      } else {
        res = 'Please enter all the details';
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  // logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'Some error occurred';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        res = 'success';
      } else {
        res = 'Please enter all the fields';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Updating user-email or password
  Future<void> updateUserInfo({
    required String fullName,
    required String mobile,
    required context,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'full_name': fullName,
        'mobile': mobile,
      }, SetOptions(merge: true));
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  // Changing Password
  Future<void> changeAuthPassword({email, password, newPassword, context}) async {
    User currentUser = _auth.currentUser!;
    final cred = EmailAuthProvider.credential(email: email, password: password);

    try {
      await currentUser.reauthenticateWithCredential(cred).then((value) {
        currentUser.updatePassword(newPassword);
      }).then((value) async {

        await AuthMethods().updatePassword(newPassword: newPassword, context: context);

        showSnackBar("Password updated", context);

      });
    } catch (e) {
        showSnackBar(e.toString(), context);
    }

  }

  Future<void> updatePassword({
    required String newPassword,
    required context,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'password': newPassword
      }, SetOptions(merge: true));
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  // PasswordReset
  Future<void> passwordReset(String email, context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  // signing out the user
  Future<void> signOut(context) async {
    await _auth.signOut().then((value) {
      Get.offAll(() => const LoginScreen());
    }).onError((error, stackTrace) {
      showSnackBar(error.toString(), context);
    });
  }
}

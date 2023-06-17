import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teriyaki_bowl_app/models/user_model.dart' as model;

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

        await _firestore
            .collection('orders')
            .doc(cred.user!.uid)
            .set({"uid": cred.user!.uid, "orders": []});

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

  // signing out the user
  Future<void> signOut() async {
    await _auth.signOut();
  }
}

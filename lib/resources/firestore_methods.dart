import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:teriyaki_bowl_app/utils/utils.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final curUser = FirebaseAuth.instance.currentUser!.uid;

  Future<void> makeFavourite(String uid, String iid, List favourite) async {
    try {
      if (favourite.contains(iid)) {
        await _firestore.collection('users').doc(curUser).update({
          'favourite': FieldValue.arrayRemove([iid]),
        });
      } else {
        await _firestore.collection('users').doc(curUser).update({
          'favourite': FieldValue.arrayUnion([iid]),
        });
      }
    } catch (e) {}
  }
  
  Future<void> updateOrder ({required int totalOrder}) async {
    try{
      await _firestore.collection('commons').doc('orders').update({
        'totalOrder': totalOrder
      });
    }catch(e){}
  }

  Future<void> saveOrder({
    required String oid,
    required int orderStatus,
    required bool paymentCompleted,
    required bool isCOD,
    required double orderTotal,
    required double discount,
    required String? couponCode,
    required cart,
    required String orderTime,
    required context
}) async {

    try {
      await _firestore.collection('orders').doc(curUser).set({
        'uid': curUser,
        'orders': FieldValue.arrayUnion([oid]),
        oid : {
          'oid': oid,
          'order_status': orderStatus,
          'payment_completed': paymentCompleted,
          'is_cod': isCOD,
          'order_total': orderTotal,
          'discount': discount,
          'coupon_code': couponCode,
          'cart': cart,
          'order_time': orderTime,
        }
      }, SetOptions(merge: true));

    } catch (e) {
      showSnackBar(e.toString(), context);
    }

  }

  Future<void> resetCart({required context}) async {
    try {
      await _firestore.collection('cart').doc(curUser).set({
        'uid': curUser,
        'cart_amount': 0.00,
        'items': [],
      }, SetOptions(merge: false));
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }


  Future<void> addToCart(
      {required String iid,
      required String itemName,
      required int quantity,
      required double itemPrice,
      required double totalPrice,
      required String itemImage,
      required context,
      required double cartAmount}) async {
    try {
      await _firestore.collection('cart').doc(curUser).set({
        'uid': curUser,
        'cart_amount': cartAmount,
        'items': FieldValue.arrayUnion([iid]),
        iid: {
          'iid': iid,
          'item_name': itemName,
          'item_image': itemImage,
          'quantity': quantity,
          'item_price': itemPrice,
          'total_price': totalPrice
        }
      }, SetOptions(merge: true));
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  Future<void> updateToCart(
      {required String iid,
      required String itemName,
      required int quantity,
      required double itemPrice,
      required double totalPrice,
      required String itemImage,
      required context,
      required double cartAmount}) async {
    try {
      await _firestore.collection('cart').doc(curUser).update({
        iid: {
          'iid': iid,
          'item_name': itemName,
          'item_image': itemImage,
          'quantity': quantity,
          'item_price': itemPrice,
          'total_price': totalPrice
        },
        'cart_amount': cartAmount
      });
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  Future<void> deleteCart(
      {required iid, required context, required double cartAmount}) async {
    try {
      await _firestore.collection('cart').doc(curUser).update({
        iid: FieldValue.delete(),
        'items': FieldValue.arrayRemove([iid]),
        'cart_amount': cartAmount
      });
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }
}

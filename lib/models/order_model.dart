import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String oid;
  final String uid;
  final String orderStatus;
  final bool paymentCompleted;
  final bool paymentMethod;
  final double orderTotal;
  final double orderTax;
  final double deliveryCharge;
  final double discount;
  final String? couponCode;
  final List items;
  final String address;
  final String orderTime;

  Order({
    required this.oid,
    required this.uid,
    required this.orderStatus,
    required this.paymentCompleted,
    required this.paymentMethod,
    required this.orderTotal,
    required this.orderTax,
    required this.deliveryCharge,
    required this.discount,
    required this.couponCode,
    required this.items,
    required this.address,
    required this.orderTime,
  });

  Map<String, dynamic> toJson() => {
    'oid' : oid,
    'uid' : uid,
    'order_status' : orderStatus,
    'payment_completed' : paymentCompleted,
    'payment_method' : paymentMethod,
    'order_total' : orderTotal,
    'order_tax' : orderTax,
    'delivery_charge' : deliveryCharge,
    'discount' : discount,
    'coupon_code' : couponCode,
    'items' : items,
    'address' : address,
    'order_time' : orderTime,
  };

  static Order fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;

    return Order(
      oid: snapshot['oid'],
      uid: snapshot['uid'],
      orderStatus: snapshot['order_status'],
      paymentCompleted: snapshot['payment_completed'],
      paymentMethod: snapshot['payment_method'],
      orderTotal: snapshot['order_total'],
      orderTax: snapshot['order_tax'],
      deliveryCharge: snapshot['delivery_charge'],
      discount: snapshot['discount'],
      couponCode: snapshot['coupon_code'],
      items: snapshot['items'],
      address: snapshot['address'],
      orderTime: snapshot['order_time'],
    );
  }
}

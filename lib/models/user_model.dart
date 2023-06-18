import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teriyaki_bowl_app/models/address_model.dart';

class User {
  final String uid;
  final String email;
  final String fullName;
  final String mobile;
  final String password;
  final List favourite;
  final List ratings;
  final List orders;
  final List<Address> address;

  User({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.mobile,
    required this.password,
    required this.favourite,
    required this.ratings,
    required this.orders,
    required this.address,
  });

  Map<String, dynamic> toJson() => {
    'uid' : uid,
    'email' : email,
    'full_name' : fullName,
    'mobile' : mobile,
    'password' : password,
    'favourite' : favourite,
    'ratings' : ratings,
    'orders' : orders,
    'address' : address,
  };

  static User fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      uid: snapshot['uid'],
      email: snapshot['email'],
      fullName: snapshot['fullName'],
      mobile: snapshot['mobile'],
      password: snapshot['password'],
      favourite: snapshot['favourite'],
      ratings: snapshot['ratings'],
      orders: snapshot['orders'],
      address: snapshot['address'],
    );
  }

}
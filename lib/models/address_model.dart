import 'package:cloud_firestore/cloud_firestore.dart';

class Address {
  final String uid;
  final String houseNumber;
  final String locality;
  final String city;
  final String state;
  final String zipcode;
  final String mobile;

  Address({
    required this.uid,
    required this.houseNumber,
    required this.locality,
    required this.city,
    required this.state,
    required this.zipcode,
    required this.mobile,
  });

  Map<String, dynamic> toJson() => {
    'uid' : uid,
    'house_number' : houseNumber,
    'locality' : locality,
    'city' : city,
    'state' : state,
    'zipcode' : zipcode,
    'mobile' : mobile,
  };

  static Address fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;

    return Address(
      uid: snapshot['uid'],
      houseNumber: snapshot['house_number'],
      locality: snapshot['locality'],
      city: snapshot['city'],
      state: snapshot['state'],
      zipcode: snapshot['zipcode'],
      mobile: snapshot['mobile'],
    );
  }
}

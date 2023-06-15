import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  final String iid;
  final String itemName;
  final String itemSubCategory;
  final double itemPrice;
  final int prepTime;
  final String itemDescription;
  final int totalOrder;

  Item({
    required this.iid,
    required this.itemName,
    required this.itemSubCategory,
    required this.itemPrice,
    required this.prepTime,
    required this.itemDescription,
    required this.totalOrder,
  });

  Map<String, dynamic> toJson() => {
    'iid' : iid,
    'item_name' : itemName,
    'item_sub_category' : itemSubCategory,
    'item_price' : itemPrice,
    'prep_time' : prepTime,
    'item_description' : itemDescription,
    'total_order' : totalOrder,
  };

  static Item fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;

    return Item(
      iid: snapshot['iid'],
      itemName: snapshot['item_name'],
      itemSubCategory: snapshot['item_sub_category'],
      itemPrice: snapshot['item_price'],
      prepTime: snapshot['prep_time'],
      itemDescription: snapshot['item_description'],
      totalOrder: snapshot['total_order'],
    );
  }
}

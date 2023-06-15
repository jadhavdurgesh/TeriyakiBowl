import 'package:flutter/foundation.dart';
import 'package:teriyaki_bowl_app/resources/auth_methods.dart';

import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:invastro/src/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/network/api_service.dart';

class Auth with ChangeNotifier {
  UserModel? user;
  String? token;
  String? commRegImagePicturePath;
  String? logoImagePicturePath;
  String? storeTermsImagePicturePath;

  Map<String, dynamic> storeRegisterData = {};

  bool get isAuth => user != null && token != null;
  String? imagePath;

  void setImagePath(String? path, {bool notify = true}) {
    imagePath = path;
    if (notify) {
      notifyListeners();
    }
  }

  void setCommRegImagePicturePath(String? imagePath) {
    commRegImagePicturePath = imagePath;
    notifyListeners();
  }

  void setLogoImagePicturePath(String? imagePath) {
    logoImagePicturePath = imagePath;
    notifyListeners();
  }

  void setStoreTermsImagePicturePath(String? imagePath) {
    storeTermsImagePicturePath = imagePath;
    notifyListeners();
  }

  void resetUser() {
    user = null;
    token = null;
    notifyListeners();
  }

  Future<void> setUser(
    Map<String, dynamic> data, {
    bool notify = true,
    bool store = false,
  }) async {
    user = UserModel.fromJson(data);
    if (notify) {
      notifyListeners();
    }
    if (store) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', json.encode(data));
      await prefs.setString('token', token!);
    }
  }

  void setToken(String token) {
    this.token = token;
    ApiService.setToken(token);
    notifyListeners();
  }

  void clearNotificationsCount() {
    user?.notificationCount = 0;
    notifyListeners();
  }

  void resetUserForLogOut() {
    user = null;
    token = null;
    commRegImagePicturePath = null;
    logoImagePicturePath = null;
    storeTermsImagePicturePath = null;
  }
}

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:invastro/src/features/auth/data/models/user_model.dart';

import '../constants/string_manager.dart';
import 'cash_helper.dart';

/// CacheManager = persistent storage
/// A class to manage cache data,
/// such as token , profile,settings,theme(Dark,light), onboarding status, user role, and language code.
/// It uses the CacheHelper to get and set data in the cache.

final class CacheManager {
  final CacheHelper _cacheHelper;

  CacheManager(this._cacheHelper);

  bool isOnboarded = false;
  String langCode = "ar";
  UserModel? currentUser;
  String? _token;
  String? _refreshToken;

  String? get token => _token;

  String? get refreshToken => _refreshToken;

  bool get isLoggedIn => currentUser != null;

  /// Call this after a successful login or profile fetch
  Future<void> startSession({
    required String token,
    required Map<String, dynamic> userJson,
    String? refreshToken,
  }) async {
    _token = token;
    currentUser = UserModel.fromJson(userJson);
    await _cacheHelper.saveSecureData(
      key: StringManager.tokenKey,
      value: token,
    );
    await _cacheHelper.saveData(
      key: StringManager.userKey,
      value: jsonEncode(userJson),
    );
    if (refreshToken != null) {
      _refreshToken = refreshToken;
      await _cacheHelper.saveSecureData(
        key: StringManager.refreshTokenKey,
        value: refreshToken,
      );
    }
  }

  /// Call this on logout or when the session is invalidated
  Future<void> clearSession() async {
    _token = null;
    _refreshToken = null;
    currentUser = null;
    await _cacheHelper.removeSecureData(key: StringManager.tokenKey);
    await _cacheHelper.removeSecureData(key: StringManager.refreshTokenKey);
    await _cacheHelper.removeData(key: StringManager.userKey);
  }

  /// Call this on app startup to load cached data into memory
  Future<void> getCachedData() async {
    try {
      _token = await _cacheHelper.getSecureData(key: StringManager.tokenKey);
      _refreshToken = await _cacheHelper.getSecureData(
        key: StringManager.refreshTokenKey,
      );
      final userJson = await _cacheHelper.getData(key: StringManager.userKey);
      if (userJson != null) {
        currentUser = UserModel.fromJson(jsonDecode(userJson));
      }
      langCode = await _cacheHelper.getData(key: StringManager.langKey) ?? "ar";
      isOnboarded =
          await _cacheHelper.getData(key: StringManager.onBoardingKey) ?? false;
    } catch (e) {
      debugPrint('Error loading cached data: $e');
    }
  }

  /// other if needed methods to update specific parts of the session without overwriting everything
  Future<void> saveToken(String newToken) async {
    _token = newToken;
    await _cacheHelper.saveSecureData(
      key: StringManager.tokenKey,
      value: newToken,
    );
  }

  Future<void> saveRefreshToken(String newToken) async {
    _refreshToken = newToken;
    await _cacheHelper.saveSecureData(
      key: StringManager.refreshTokenKey,
      value: newToken,
    );
  }

  // Future<void> saveProfile(Map<String,dynamic> userJson) async {
  //   _currentUser = User.fromJson(userJson);
  //   await _cacheHelper.saveData(key: StringManager.userKey, value: jsonEncode(userJson));
  // }
  //
  // Future<String?> getCachedToken() async {
  //   return await _cacheHelper.getSecureData(key: StringManager.tokenKey);
  // }
  //
  // String? getCachedProfile() {
  //   return _cacheHelper.getData(key: StringManager.userKey);
  // }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseLocal {
  DatabaseLocal._privateConstructor();

  static final DatabaseLocal _instance = DatabaseLocal._privateConstructor();

  static DatabaseLocal get instance => _instance;

  Future<void> saveRefeshToken(String refeshToken) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("refeshToken", refeshToken);
    log("SUCCESS");
  }


  Future<String?> getRefeshToken() async {
    await Future.delayed(Duration(seconds: 3));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('refeshToken');
  }

  Future<void> setJwtToken(String accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken);
  }

  Future<void> removeJwtToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('refeshToken');
  }
}

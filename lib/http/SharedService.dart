import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/Login.dart';
/*
class SharedService {

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("login_details") != null ? true : false;
  }

  static Future<LoginResponseModel> loginDetails() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("login_details" != null 
    ? LoginResponseModel.fromJson(
      jsonDecode(
        prefs.getString("login_details"),
        ),
    )
    : null;
  }

  static Future<void> setLoginDetails (LoginResponseModel respondeModel) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("login_details", responseModel != null ? jsonEncode(responseModel.toJson(),) : null;
  }

  static Future<void> logout(BuildContext context) async {
    await setLoginDetails(null);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login())); 
  }

}*/
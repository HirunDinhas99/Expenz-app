import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  //Store the userName and password using shared preferences
  static Future<void> storeUserDetails({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    try {
      //check if the password and confirm password are the same
      if (password != confirmPassword) {
        //show a snackbar with the error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Password and Confirm Password do not match"),
          ),
        );
        return;
      }
      //Store the username and email in shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);
      await prefs.setString('email', email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User Details stored successfully"),
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<bool> checkUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString('username');
    return userName != null;
  }
}

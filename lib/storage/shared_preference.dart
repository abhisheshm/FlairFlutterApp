import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getUserId() async{
  final prefs = await SharedPreferences.getInstance();
  final String? userId = prefs.getString('userId');
  return userId;
}

Future setUserId(String userId) async{
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('userId', userId);
}

Future removeUserId() async{
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('userId');
}

Future<String?> getUserName() async{
  final prefs = await SharedPreferences.getInstance();
  final String? userName = prefs.getString('userName');
  return userName;
}

Future setUserName(String userName) async{
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('userName', userName);
}

Future removeUserName() async{
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('userName');
}
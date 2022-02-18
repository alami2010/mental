import 'package:shared_preferences/shared_preferences.dart';

class SPHelper {
  static late SharedPreferences prefs;

  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future writeUserType(String type) async {
    prefs.setString("type", type);
  }

  Future readUserType(String type) async {
    return prefs.getString('action');
  }
}

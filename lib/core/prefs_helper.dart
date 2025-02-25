import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper {
  static late SharedPreferences prefs   ;
static init()async{
prefs= await SharedPreferences.getInstance();

}
static setTheme(bool isDark){
  prefs.setBool("theme",isDark );
}
  static getTheme(){
  return prefs.getBool("theme")??false;
  }


  static setOnboarding(bool value)async{
    await prefs.setBool("onboarding", value);

  }
  static Future<bool> getBool()async{
    bool isFirst= prefs.getBool("onboarding")??true;

    return isFirst;
  }
}
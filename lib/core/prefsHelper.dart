
// class prefhelper {
//   static late SharedPreferences prefs;
//   static String key = "mostRecently";
//
//   static Future<void> init() async {
//     prefs = await SharedPreferences.getInstance();
//   }
//   static setOnboarding(bool value)async{
//     await prefs.setBool("onboarding", value);
//
//   }
//   static Future<bool> getBool()async{
//     bool isFirst= prefs.getBool("onboarding")??false;
//
//     return isFirst;
//   }
//
//
//
// }
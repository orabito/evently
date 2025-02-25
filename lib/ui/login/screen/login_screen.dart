import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/core/assets_manager.dart';
import 'package:event_planning_app/core/color_manager.dart';
import 'package:event_planning_app/core/constans.dart';
import 'package:event_planning_app/core/google_auth.dart';
import 'package:event_planning_app/core/reusable_componets/custom_button.dart';
import 'package:event_planning_app/core/reusable_componets/custom_field.dart';
import 'package:event_planning_app/core/reusable_componets/firestore_handler.dart';
import 'package:event_planning_app/core/strings_manager.dart';
import 'package:event_planning_app/models/user_model.dart';
import 'package:event_planning_app/ui/forget_password/screen/forget_password_screen.dart';
import 'package:event_planning_app/ui/register/screen/register_screen.dart';
import 'package:event_planning_app/ui/start_screen/widget/toggle_language.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import '../../../core/dialog_utils.dart';
import '../../../core/firebase_Auth_codes.dart';
import '../../home/screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Gap(16),
                Image.asset(AssetsManager.Logo2),
                Gap(24),
                CustomField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return StringsManager.enter_your_email.tr();
                      } else if (!RegExp(emailRegex).hasMatch(value)) {
                        return StringsManager.enter_valid_email.tr();
                      }
                      return null;
                    },
                    keyboard: TextInputType.emailAddress,
                    hint: StringsManager.email.tr(),
                    prefix: AssetsManager.email,
                    controller: emailController),
                Gap(16),
                CustomField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return StringsManager.enterYourPass.tr();
                      } else if (!RegExp(passRegex).hasMatch(value)) {}
                      return null;
                    },
                    keyboard: TextInputType.visiblePassword,
                    hint: StringsManager.password.tr(),
                    isObscure: true,
                    prefix: AssetsManager.lock,
                    controller: passwordController),
                Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(ForgetPasswordScreen.routeName);
                    },
                    child: Text(
                      StringsManager.forget_password.tr(),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: ColorManager.lightPrimary,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                          decorationColor: ColorManager.lightPrimary),
                    ),
                  ),
                ),
                Gap(16),
                Container(
                    width: double.infinity,
                    child: CustomButton(
                        text: StringsManager.login.tr(),
                        onPressed: () {
                          singIn();

                          setState(() {});
                        })),
                Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringsManager.dont_have_account.tr(),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: 16
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(RegisterScreen.routeName);
                      },
                      child: Text(
                        StringsManager.createAccount.tr(),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: ColorManager.lightPrimary,
                            decoration: TextDecoration.underline,
                            decorationColor: ColorManager.lightPrimary),
                      ),
                    )
                  ],
                ),
                Gap(16),
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Divider(),
                    )),
                    Text(
                      StringsManager.or.tr(),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: ColorManager.lightPrimary,
                          ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Divider(),
                    )),
                  ],
                ),
                Gap(16),
                OutlinedButton(
                    onPressed: ()  {
                      singInWithGoogle();
                    },
                    style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.all(14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),),
                        side: BorderSide(
                            color: ColorManager.lightPrimary, width: 2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AssetsManager.google),
                        Gap(10),
                        Text(StringsManager.login_with_google.tr()),
                      ],
                    )),
                Gap(16),
                ToggleLanguage(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  singIn() async {
    if (formKey.currentState!.validate()) {
      try {
        DialogUtils.showLoadingDialog(context);
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        Navigator.pop(context);
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        if (e.code == FirebaseAuthCodes.userNotFound) {
          DialogUtils.showMassageError(
            context: context,
            massage: StringsManager.noUserFound.tr(),
            positiveBtnTitle: StringsManager.ok.tr(),
            positiveBtnClick: () => Navigator.pop(context),
          );
        } else if (e.code == FirebaseAuthCodes.wrongPass) {
          DialogUtils.showMassageError(
            context: context,
            massage: StringsManager.wrongPassword.tr(),
            positiveBtnTitle: StringsManager.ok.tr(),
            positiveBtnClick: () => Navigator.pop(context),
          );
        } else if (e.code == FirebaseAuthCodes.noInternet) {
          DialogUtils.showMassageError(
            context: context,
            massage: StringsManager.noInternet.tr(),
            positiveBtnTitle: StringsManager.ok.tr(),
            positiveBtnClick: () => Navigator.pop(context),
          );
        }
      } catch (e) {
        Navigator.pop(context);
        DialogUtils.showMassageError(
          context: context,
          massage: e.toString().tr(),
          positiveBtnTitle: StringsManager.ok.tr(),
          positiveBtnClick: () => Navigator.pop(context),
        );
      }
    }

  }
  singInWithGoogle() async {
    DialogUtils.showLoadingDialog(context);
try{
  var userCredentialGoogle=await GoogleAuth.signInWithGoogle();
  if(userCredentialGoogle.user?.uid!=null){
    var list =await FirestoreHandler.getMyWishlist(userCredentialGoogle.user!.uid);
 var   idOfEvent=list.map((e) =>e.eventId! ,).toList();
    var user=UserModel(

      favorite:idOfEvent !=null?idOfEvent:[] ,
          name: userCredentialGoogle.user?.displayName.toString(),
          id:userCredentialGoogle.user?.uid.toString() ,
          email: userCredentialGoogle.user?.email.toString(),

    );
    FirestoreHandler.AddUser(user);
    Navigator.pop(context);
    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    return;
  }
}catch(e){
  DialogUtils.showToast(e.toString(), context);
  Navigator.pop(context);
}
  }
}

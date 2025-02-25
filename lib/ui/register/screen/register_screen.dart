import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/core/assets_manager.dart';
import 'package:event_planning_app/core/color_manager.dart';
import 'package:event_planning_app/core/constans.dart';
import 'package:event_planning_app/core/dialog_utils.dart';
import 'package:event_planning_app/core/firebase_Auth_codes.dart';
import 'package:event_planning_app/core/reusable_componets/custom_button.dart';
import 'package:event_planning_app/core/reusable_componets/custom_field.dart';
import 'package:event_planning_app/core/reusable_componets/firestore_handler.dart';
import 'package:event_planning_app/core/strings_manager.dart';
import 'package:event_planning_app/models/user_model.dart';
import 'package:event_planning_app/ui/start_screen/widget/toggle_language.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../home/screen/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String routeName = "RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController rePasswordController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringsManager.register.tr()),
      ),
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
                      if (value!.isEmpty) {
                        return StringsManager.enterYourName.tr();
                      } else if (RegExp(nameRegex).hasMatch(value)) {
                        return StringsManager.enterValidName.tr();
                      } else {
                        return null;
                      }
                    },
                    keyboard: TextInputType.name,
                    hint: StringsManager.name.tr(),
                    prefix: AssetsManager.person,
                    controller: nameController),
                Gap(16),
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
                Gap(16),
                CustomField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return StringsManager.enterYourRePass.tr();
                    } else if (value != passwordController.text) {
                      return StringsManager.enterValidRePass.tr();
                    }

                    return null;
                  },
                  keyboard: TextInputType.visiblePassword,
                  hint: StringsManager.password.tr(),
                  prefix: AssetsManager.lock,
                  controller: rePasswordController,
                  isObscure: true,
                ),
                Gap(16),
                Container(
                    width: double.infinity,
                    child: CustomButton(
                        text: StringsManager.createAccount.tr(),
                        onPressed: () {
                          createAccount();
                        })),
                Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringsManager.already_have_account.tr(),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        StringsManager.login.tr(),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: ColorManager.lightPrimary,
                            decoration: TextDecoration.underline,
                            decorationColor: ColorManager.lightPrimary),
                      ),
                    )
                  ],
                ),
                ToggleLanguage(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  createAccount() async {
    if (formKey.currentState!.validate()) {
      try {
        DialogUtils.showLoadingDialog(context);
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      await  FirestoreHandler.AddUser(UserModel(
            email: emailController.text,
            id: credential.user!.uid,
            name: nameController.text,
      favorite: []),
          );
        Navigator.pop(context);
        Navigator.of(context)
            .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        if (e.code == FirebaseAuthCodes.weakPass) {
          DialogUtils.showMassageError(
            context: context,
            massage: StringsManager.weakPassword.tr(),
            positiveBtnTitle: StringsManager.ok.tr(),
            positiveBtnClick: () => Navigator.pop(context),
          );
        } else if (e.code == FirebaseAuthCodes.emailAlreadyInUse) {
          DialogUtils.showMassageError(
            context: context,
            massage: StringsManager.emailAlreadyExists.tr(),
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
        } else if (e.code == FirebaseAuthCodes.invalidEmail) {}
      } catch (e) {
        Navigator.pop(context);
        DialogUtils.showMassageError(
          context: context,
          massage: e.toString(),
          positiveBtnTitle: StringsManager.ok.tr(),
          positiveBtnClick: () => Navigator.pop(context),
        );
      }
    }
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/core/assets_manager.dart';
import 'package:event_planning_app/core/dialog_utils.dart';
import 'package:event_planning_app/core/reusable_componets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../core/constans.dart';
import '../../../core/firebase_Auth_codes.dart';
import '../../../core/reusable_componets/custom_field.dart';
import '../../../core/strings_manager.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  static const String routeName = "ForgetPasswordScreen";

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late TextEditingController emailController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringsManager.forget_password.tr()),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SvgPicture.asset(AssetsManager.changeSetting),
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
                Gap(24),
                CustomButton(
                    text: StringsManager.resetPass.tr(),
                    onPressed: () {
                      forgetPass();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  forgetPass() async {
    if (formKey.currentState!.validate()) {
      try {
        DialogUtils.showLoadingDialog(context);
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text);
        Navigator.pop(context);

        DialogUtils.showToast(StringsManager.emailSent.tr(), context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        if (e.code == FirebaseAuthCodes.userNotFound) {
          DialogUtils.showMassageError(
            context: context,
            massage: StringsManager.noUserFound.tr(),
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

        // TODO
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

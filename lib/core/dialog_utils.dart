import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/core/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';

class DialogUtils {
  static showLoadingDialog(
    BuildContext context,
  )
  {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              StringsManager.loading.tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Gap(15),
            CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            )
          ],
        ),
      ),
    );
  }

  static showMassageError(
      {required BuildContext context,
      required String massage,
      required String positiveBtnTitle,
      required void Function() positiveBtnClick,
      String? negativeBtnTitle,
      void Function()? negativeBtnClick})
  {
    showDialog
      (
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
          massage.tr(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          TextButton(
              onPressed: positiveBtnClick,
              child: Text(
                positiveBtnTitle,
                style: Theme.of(context).textTheme.titleMedium,
              )),
          if (negativeBtnTitle != null)
            TextButton(
                onPressed: negativeBtnClick,
                child: Text(
                  negativeBtnTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                )),
        ],
      ),
    );
  }
  static showToast(String massage,BuildContext context){
    Fluttertoast.showToast(
        msg: massage,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor:Theme.of(context).colorScheme.onSecondaryContainer,
        textColor: Theme.of(context).colorScheme.onPrimary,
        fontSize: 16.0
    );
  }


}

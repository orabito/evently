import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../core/strings_manager.dart';

class LanguageShowModalBottomSheetWidget extends StatelessWidget {
  const LanguageShowModalBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.locale.languageCode == "en"
                    ? StringsManager.english.tr()
                    : StringsManager.arabic.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Icon(
                Icons.check,
                color: Theme.of(context).colorScheme.primary,
                size: 40,
              )
            ],
          ),
          Gap(30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  if (context.locale.countryCode == "ar" ||
                      context.locale.languageCode != "en") {
                    context.setLocale(Locale("en"));
                  } else {
                    context.setLocale(Locale("ar"));
                  }
                },
                child: Text(
                  context.locale.languageCode != "en"
                      ? StringsManager.english.tr()
                      : StringsManager.arabic.tr(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../core/assets_manager.dart';

class ToggleButton extends StatefulWidget {
  const ToggleButton({super.key});

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool isArabic=false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          20,
        ),
        border: Border.all(width: 4,
            color: Theme.of(context).colorScheme.primary),),
      child: Row(
        children: [
          InkWell(
            onTap:
            () {
              setState(() {
                isArabic=false;
              });
            },
            child: CircleAvatar(
              backgroundColor:!isArabic?
              Theme.of(context).colorScheme.primary:Colors.transparent,
              child:
              SvgPicture.asset(
                AssetsManager.englishIcon,
                height: 30,
                width: 30,
              ),
            ),
          ),
          Gap(14),
          InkWell(onTap: () {
            setState(() {
              isArabic=true;
            });
          },
            child: CircleAvatar(
              radius: 20,
              backgroundColor:isArabic?
              Theme.of(context).colorScheme.primary:Colors.transparent,
              child:
              SvgPicture.asset(
                AssetsManager.arabicIcon,
                height: 30,
                width: 30,
              ),

            ),
          ),
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../ui/create_event/screen/pick_location_screen.dart';
import '../strings_manager.dart';

class OutlineButtonWidget extends StatelessWidget {
   OutlineButtonWidget({super.key,required this.Onpressed,required this.icon,required this. child,this.iconForward});

 final  void Function()Onpressed;
  final IconData icon;
  final IconData? iconForward;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(onPressed: () {
      Onpressed();
    },
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        side: BorderSide(

            color: Theme
                .of(context)
                .colorScheme
                .primary, width: 2),
      ),

      child: Row(

        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme
                    .of(context)
                    .colorScheme
                    .primary),

            child: Icon(
                icon,
                size: 32,
                color: Theme
                    .of(context)
                    .colorScheme
                    .onPrimary),
          ),
          Gap(10),
          Expanded(
            child: child,
          ),
          Icon(iconForward,
              size: 32, color: Theme.of(context).colorScheme.primary),
        ],
      ),)
    ;
  }
}

import 'package:event_planning_app/core/color_manager.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key,required this.text,required this.onPressed});
final String text;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

        style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),

            ),),
        onPressed:onPressed ,
        child: Text(text,style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: ColorManager.darkSecondary
        ),));
  }
}

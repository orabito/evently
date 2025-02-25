import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class OnboardingWidget extends StatelessWidget {
  OnboardingWidget({super.key, required this.image, required this.title,required this.textBody});

  String image;
  String title;
  String textBody;

  @override
  Widget build(BuildContext context) {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Gap(24),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Gap(24),
        Text(
         textBody,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontSize: 20
          ),
        ),
      ],
    );
  }
}

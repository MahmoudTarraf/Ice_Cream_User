// ignore_for_file: prefer_const_constructors

import 'package:achievement_view/achievement_view.dart';
import 'package:flutter/material.dart';

void swipeToDeleteMessage({
  required BuildContext context,
  required String thisTitle,
  required String thisSubtitle,
}) {
  AchievementView(
    alignment: Alignment.center,
    color: Colors.red,
    title: thisTitle,
    subTitle: thisSubtitle,
    textStyleSubTitle: const TextStyle(
      fontSize: 12,
    ),
    isCircle: true,
    listener: (status) {},
    onTap: () {
      FocusScope.of(context).unfocus();
    },
  ).show(context);
}

void addToCartMessage(
  BuildContext context,
  String title,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.white,
      content: Text(
        '$title Added to the Cart',
        style: const TextStyle(
          fontSize: 20,
          color: Colors.pink,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.8,
        ),
      ),
    ),
  );
}

void cartErrorCountMessage(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      duration: Duration(seconds: 2),
      backgroundColor: Colors.white,
      content: Text(
        'IceCream Count must be greater than 0.',
        style: TextStyle(
          fontSize: 20,
          color: Colors.pink,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.8,
        ),
      ),
    ),
  );
}

void errorOperationNumber({
  required BuildContext context,
  required String thisTitle,
  required String thisSubtitle,
}) {
  AchievementView(
    duration: const Duration(seconds: 4),
    alignment: Alignment.center,
    color: Colors.red,
    title: thisTitle,
    subTitle: thisSubtitle,
    textStyleSubTitle: const TextStyle(
      fontSize: 12,
    ),
    isCircle: true,
    listener: (status) {},
    onTap: () {
      FocusScope.of(context).unfocus();
    },
  ).show(context);
}

void showSuccess(BuildContext context, String thisTitle, String thisSubtitle) {
  AchievementView(
    alignment: Alignment.center,
    color: Colors.green,
    title: thisTitle,
    subTitle: thisSubtitle,
    textStyleSubTitle: const TextStyle(
      fontSize: 12,
    ),
    isCircle: true,
    listener: (status) {},
    onTap: () {
      FocusScope.of(context).unfocus();
    },
  ).show(context);
}

void showError(BuildContext context, String thisTitle, String thisSubtitle) {
  AchievementView(
    alignment: Alignment.center,
    color: Colors.red,
    title: thisTitle,
    subTitle: '$thisSubtitle !',
    textStyleSubTitle: const TextStyle(
      fontSize: 12,
    ),
    isCircle: true,
    listener: (status) {},
    onTap: () {
      FocusScope.of(context).unfocus();
    },
  ).show(context);
}

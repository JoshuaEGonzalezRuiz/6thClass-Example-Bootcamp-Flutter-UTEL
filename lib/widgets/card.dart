import 'package:flutter/material.dart';

Widget cardTemplate(Widget body, BuildContext context) {
  return Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.primary.withOpacity(0.25),
      border: Border.all(),
      borderRadius: BorderRadius.all(Radius.circular(20))
    ),
    child: body
  );
}
import "package:flutter/material.dart";

notification({
  required BuildContext context,
  required String message,
  required Color backgroundColor,
  required Color textColor,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: textColor,
        ),
      ),
    ),
  );
}

void sendNotificaton(
  BuildContext context,
  String message,
) // async =>
{
  notification(
    context: context,
    message: message,
    backgroundColor: Colors.grey[100]!,
    textColor: Colors.black,
  );
}

void sendErrorNotification({
  required BuildContext context,
  required String message,
}) //async =>
{
  notification(
    context: context,
    message: message,
    backgroundColor: Colors.red,
    textColor: Colors.white,
  );
}

void sendSuccessNotification({
  required BuildContext context,
  required String message,
}) //async =>
{
  notification(
    context: context,
    message: message,
    backgroundColor: Colors.green,
    textColor: Colors.white,
  );
}

import "package:flutter/material.dart";
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'message_constant.dart';

AppLocalizations? translate(BuildContext context) =>
    AppLocalizations.of(context);

String pleaseEnterField(BuildContext context, String errorMessage) {
  final Map<String, dynamic> messages = {
    constEmailInput: translate(context)!.email_input,
    constPasswordInput: translate(context)!.password_input,
    constNameInput: translate(context)!.name_input,
    'constAddress': translate(context)!.address_input,
  };

  String message = messages[errorMessage]?? "";


  return translate(context)!.pleaseEnterField(message.toLowerCase()) ?? "";
}

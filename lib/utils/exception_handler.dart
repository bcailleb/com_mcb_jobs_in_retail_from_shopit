import 'package:com_mcb_jobs_in_retail_from_shopit/utils/translate.dart';
import 'package:flutter/cupertino.dart';

import 'logger.dart';
import 'message_constant.dart';
import 'notifications.dart';

class MessageHandler {
  static const String staticClassName = 'MessageHandler';

  static String translateNotFound({
    required BuildContext context,
    required String message,
  }) {
    String returnValue = message;
    if (message == '') {
      returnValue = '${translate(context)!.translate_not_found}  $message';
      criticalError("$staticClassName: translate_not_found   $returnValue");
    }
    return returnValue;
  }

  static void authErrorAndException({
    required BuildContext context,
    required String errorMessage,
  }) {
    String message;

    final Map<String, dynamic> messages = {
      constSomethingWrong: translate(context)!.something_wrong,
      constUserNotFound: translate(context)!.user_not_found,
      constWrongPassword: translate(context)!.wrong_password,
      constInvalidEmail: translate(context)!.invalid_email,
      constBadEmail: translate(context)!.invalid_email,
      constOperationNotAllowed: translate(context)!.operation_not_allowed,
      constWeakPassword: translate(context)!.weak_password,
      constNetworkRequestFailed: translate(context)!.network_request_failed,
      constFillFields: translate(context)!.fill_fields,
    };
    message = messages[errorMessage] ?? errorMessage;

    sendErrorNotification(
      context: context,
      message: translateNotFound(context: context,message: message,),
    );
  }

  static void cardAndProductMessage(String result, BuildContext context) {
    String message;

    final Map<String, dynamic> messages = {
      constSomethingWrong: translate(context)!.something_wrong,
      constUserNotFound: translate(context)!.user_not_found,
      constWrongPassword: translate(context)!.wrong_password,
      constInvalidEmail: translate(context)!.invalid_email,
      constOperationNotAllowed: translate(context)!.operation_not_allowed,
      constWeakPassword: translate(context)!.weak_password,
      constNetworkRequestFailed: translate(context)!.network_request_failed,
      constFillFields: translate(context)!.fill_fields,
    };
    message = messages[result];

    if (message == '') {
      message = 'Non trouvé $result';
    }

    sendErrorNotification(
      context: context,
      message: translateNotFound(context: context,message: message,),
    );
  }
}

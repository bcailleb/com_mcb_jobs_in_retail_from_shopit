import "package:logger/logger.dart";
//  info("$runtimeType: logInWithCredentials");
final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 80,
    colors: false,
    printEmojis: false,
    printTime: false,
  ),
);

void info(
  String message, {
  Map<String, dynamic> data = const {},
}) async =>
    logger.i("Info: $message: $data");

void warn(
  String message, {
  Map<String, dynamic> data = const {},
}) async =>
    logger.w("Warn: $message: $data");

void error(
  String message, {
  Map<String, dynamic> data = const {},
}) async =>
    logger.e("Error: $message: $data");

void criticalError( // TO DO AJOUTER l'ecriture en Base
  String message, {
  Map<String, dynamic> data = const {},
}) async =>
    logger.e("Critical Error: $message: $data");

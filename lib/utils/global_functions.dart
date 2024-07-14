import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'navigation_service.dart';

void showToast({
  Color? textColor,
  Color? backgroundColor,
  required String message,
  required BuildContext context,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 3,
    backgroundColor: backgroundColor,
    textColor: Colors.white,
    fontSize: 15.00,
  );
}

final double kWidth =
    MediaQuery.of(NavigationService.navigatorKey.currentContext!).size.width;
final double kHeight =
    MediaQuery.of(NavigationService.navigatorKey.currentContext!).size.height;

void handleDioException(DioException e) {
  e.response == null
      ? showToast(
          message: "Connection Error\nPlease check your internet connection",
          context: NavigationService.navigatorKey.currentContext!,
        )
      : e.response!.statusCode == 500
          ? showToast(
              message: "Internal Server Error",
              context: NavigationService.navigatorKey.currentContext!,
            )
          : e.response != null &&
                  e.response?.data != null &&
                  e.response?.data != '' &&
                  e.response!.statusCode != 400 &&
                  e.response!.statusCode != 401
              ? showToast(
                  message: e.response?.data["results"].toString() ??
                      e.response?.data,
                  context: NavigationService.navigatorKey.currentContext!,
                )
              : showToast(
                  message:
                      "Connection Error\nSomething went wrong! Please try again",
                  context: NavigationService.navigatorKey.currentContext!,
                );
}

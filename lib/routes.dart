import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './route_handlers.dart';

class Routes {
  static String root = "/";

  static String questions = "/questions";

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });

    router.define(root, handler: rootHandler);

    router.define(questions, handler: questionHandler);
  }
}

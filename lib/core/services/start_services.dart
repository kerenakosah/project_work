import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectwork/index.dart';

class InitServices {
  InitServices._();

  static final InitServices instance = InitServices._();

  initServices() async {
    await createDataLayer();
  }

  // data layer
  Future<void> createDataLayer() async {
    Get.lazyPut(() => ThemeController());
    Get.lazyPut(() => UserController());
  }
}

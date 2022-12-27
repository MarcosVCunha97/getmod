
const String bindingTemplate = """
import 'package:get/get.dart';
import '../controllers/[PAGE_NAME_SNAKE]_controller.dart';

class [PAGE_NAME]Binding implements Bindings {

  @override
  void dependencies() {
    Get.put<[PAGE_NAME]Controller>([PAGE_NAME]Controller());
  }
}
""";

const String controllerTemplate = """
import 'package:get/get.dart';

class [PAGE_NAME]Controller extends GetxController {}
""";

const String pageTemplate = """
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/[PAGE_NAME_SNAKE]_controller.dart';

class [PAGE_NAME]Page extends GetView<[PAGE_NAME]Controller>{

  const [PAGE_NAME]Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('[PAGE_NAME]Page'),
        centerTitle: true,
      ),
    );
  }
}
""";
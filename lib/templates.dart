
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

class [PAGE_NAME]Controller extends GetxController with LoadingMixin {

  @override
  void onInit(){
    super.onInit();
    if(loadParameters()){
      fetchData(showLoading: true);
    }
  }

  bool loadParameters(){
    try {
      // parameter1 = Get.find<Type>('parameter1');
      // parameter2 = Get.find<Type>('parameter2');
      return true;
    } catch (_) {
      return false;
    }
  }

  void fetchData({bool showLoading=false}){
    if(showLoading){
      showLoadingWhileRunning(() => _fetchData());
    }else{
      _fetchData();
    }
  }

  Future _fetchData() async {}
}
""";

const String pageTemplate = """
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/[PAGE_NAME_SNAKE]_controller.dart';

class [PAGE_NAME]Page extends GetView<[PAGE_NAME]Controller>{

  const [PAGE_NAME]Page({super.key});

  static Future to() async {
    // Get.delete<Type>(tag: 'parameter1');
    // Get.delete<Type>(tag: 'parameter2');
    
    // Get.put<Type>(parameter1, tag: 'parameter1');
    // Get.put<Type>(parameter2, tag: 'parameter2');
  }

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
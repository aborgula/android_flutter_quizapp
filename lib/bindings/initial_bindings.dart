import 'package:get/get.dart';
import 'package:hci/controllers/question_paper/data_uploader.dart';
import 'package:hci/controllers/theme_controller.dart';
import '../controllers/auth_controller.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies(){
    Get.put(ThemeController());
    Get.put(DataUploader());
    Get.put(AuthController(), permanent: true);

  }
}
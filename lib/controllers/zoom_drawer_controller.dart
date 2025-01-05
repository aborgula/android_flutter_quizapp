import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hci/controllers/auth_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class MyZoomDrawerController extends GetxController{

  final zoomDrawerController = ZoomDrawerController();
  Rxn<User?> user = Rxn();

  @override
  void onReady(){
    user.value = Get.find<AuthController>().getUser();
    super.onReady();
  }

  void toogleDrawer(){
      zoomDrawerController.toggle?.call();
      update();
  }


  void email(){
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path:'info@dbestech.com'
    );
    _launch(emailLaunchUri.toString());
  }


  Future<void>_launch(String url)async{
      if( !await launch(url)){
        throw 'could not launch $url';
      }
  }
}
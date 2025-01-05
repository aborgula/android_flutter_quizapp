import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import 'bindings/initial_bindings.dart';
import 'controllers/question_paper/question_paper_controller.dart';
import 'controllers/shake_detector.dart';
import 'services/firebase_storage_service.dart';
import 'controllers/theme_controller.dart';
import 'routes/app_routes.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  AwesomeNotifications().initialize(
     null,
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Colors.blue,
        ledColor: Colors.white,
        importance: NotificationImportance.High,
        channelShowBadge: true,
      ),
    ],
    debug: true,
  );


  Get.put(FirebaseStorageService());
  Get.put(QuizPaperController());
  Get.put(ShakeDetectorController());
  InitialBindings().dependencies();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Get.find<ThemeController>().lightTheme,
      darkTheme: Get.find<ThemeController>().darkTheme,
      themeMode: ThemeMode.system,
      getPages: AppRoutes.routes(),
    );
  }
}





/**
 import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hci/bindings/initial_bindings.dart';
import 'package:hci/configs/themes/app_dark_theme.dart';
import 'package:hci/controllers/question_paper/data_uploader.dart';
import 'package:hci/controllers/theme_controller.dart';
import 'package:hci/data_uploader_screen.dart';
import 'package:hci/firebase_options.dart';
import 'package:get/get.dart';
import 'package:hci/routes/app_routes.dart';
import 'package:hci/screens/introduction/introduction.dart';
import 'package:hci/screens/splash/splash_screen.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:hci/services/firebase_storage_service.dart';
import 'configs/themes/app_light_theme.dart';


void main() async {


  AwesomeNotifications().initialize(
    '/Users/ala/Desktop/hci/assets/images/icon',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Colors.red,
        ledColor: Colors.white,
        importance: NotificationImportance.High,
        channelShowBadge: true,
      ),
    ],
    debug: true,
  );

  await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });


   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(); // Dodaj "await" tutaj

   Get.put(FirebaseStorageService());
   InitialBindings().dependencies();
   Get.put(DataUploader());

   runApp(MyApp());
 }


 class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return GetMaterialApp(
      theme: Get.find<ThemeController>().lightTheme,
      getPages: AppRoutes.routes(),
    );
  }
}


**/
import 'package:hci/controllers/question_paper/question_paper_controller.dart';
import 'package:hci/controllers/question_paper/questions_controller.dart';
import 'package:hci/controllers/zoom_drawer_controller.dart';
import 'package:hci/screens/home/home_screen.dart';
import 'package:hci/screens/introduction/introduction.dart';
import 'package:hci/screens/login/login_screen.dart';
import 'package:hci/screens/login/register_screen.dart';
import 'package:hci/screens/menu/awards_screen.dart';
import 'package:hci/screens/menu/liked_screen.dart';
import 'package:hci/screens/menu/streak_screen.dart';
import 'package:hci/screens/question/answer_check_screen.dart';
import 'package:hci/screens/question/question_screen.dart';
import 'package:hci/screens/question/result_screen.dart';
import 'package:hci/screens/question/test_overview_screen.dart';
import '../data_uploader_screen.dart';
import '../screens/menu/score_screen.dart';
import '../screens/splash/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes{
  static List<GetPage> routes()=> [
    GetPage(name: "/", page:() => const SplashScreen()),
    GetPage(name: "/introduction", page: () => const AppIntroductionScreen()),
    GetPage(
      name: "/home",
      page: () => const HomeScreen(),
      binding: BindingsBuilder((){
        Get.put(QuizPaperController());
        Get.put(MyZoomDrawerController());
      })),
    GetPage(name: LoginScreen.routeName,
        page: ()=>LoginScreen()
    ),
    GetPage(
      name: "/register",
      page: ()=> RegisterScreen()
    ),
    GetPage(name: "/questionsScreen",
        page: ()=>QuestionsScreen(),
      binding: BindingsBuilder((){
        Get.put<QuestionsController>(QuestionsController());
      })
    ),
    GetPage(
      name: TestOverviewScreen.routeName,
      page: ()=>const TestOverviewScreen()
    ),
    GetPage(
      name: ResultScreen.routeName,
      page: ()=>const ResultScreen()
    ),
    GetPage(
        name: AnswerCheckScreen.routeName,
        page: ()=>const AnswerCheckScreen()
    ),
    GetPage(
        name: ScoreScreen.routeName,
        page: ()=>const ScoreScreen()
    ),
    GetPage(
        name: StreakScrean.routeName,
        page: ()=>const StreakScrean()
    ),
    GetPage(
        name: LikedScreen.routeName,
        page: ()=>const LikedScreen()
    ),
    GetPage(
      name: '/upload',
      page: () => DataUploaderScreen(),
    ),
    GetPage(
      name: AwardsScreen.routeName,
      page: () => AwardsScreen(),
    )

  ];
}
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import 'package:hci/configs/themes/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hci/controllers/question_paper/question_paper_controller.dart';
import 'package:hci/screens/login/login_screen.dart';
import '../firebase_ref/references.dart';
import '../widgets/dialogs/dialogue_widget.dart';

class AuthController extends GetxController {


  @override
  void onReady() {
    initAuth();
    super.onReady();
  }

  late FirebaseAuth _auth;

  final _user = Rxn<User>();
  late Stream<User?> _authStateChanges;
  var loggedInUserData = {}.obs;

  void initAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    _auth = FirebaseAuth.instance;
    _authStateChanges = _auth.authStateChanges();
    _authStateChanges.listen((User? user) {
      _user.value = user;
    });
    navigateToIntroduction();
  }

  var isLogged = false.obs;

  Future<void> loginWithLoginAndPassword({required String login, required String password}) async {
    try {

      var querySnapshot = await userRF.where('login', isEqualTo: login).get();

      print(login);
      if (querySnapshot.docs.isNotEmpty) {
        var userData = querySnapshot.docs.first.data();
        var userDocRef = querySnapshot.docs.first.reference;

        if (userData['password'] == password) {
          isLogged.value = true;

          loggedInUserData.value = userData;
          await _updateStreak(userDocRef, userData);

          Get.defaultDialog(
            title: "Hello!",
            middleText: "Shake your device to get random quiz!",
            textConfirm: "OK",
            confirmTextColor: customScaffoldColor(Get.context!),
            onConfirm: () {
              Get.back();
              Get.offAllNamed("/home");
            },
          );

        } else {
          Get.snackbar("Login Error", "Incorrect password.");
        }
      } else {
        Get.snackbar("Login Error", "No user found with this login.");
      }
    } catch (e) {
      Get.snackbar("Login Error", e.toString());
    }
  }


  Future<void> registerWithEmailAndPassword({
    required String email,
    required String login,
    required String password,
  }) async {
    try {

      var emailExists = await userRF.where('email', isEqualTo: email).get();
      var loginExists = await userRF.where('login', isEqualTo: login).get();

      if (emailExists.docs.isNotEmpty) {
        Get.snackbar("Register Error", "Given e-mail is already in use.");
        return;
      }

      if (loginExists.docs.isNotEmpty) {
        Get.snackbar("Register Error", "Given login is already in use.");
        return;
      }

      String userId = FirebaseFirestore.instance.collection('users').doc().id;

      var batch = FirebaseFirestore.instance.batch();
      var userDoc = userRF.doc(userId);

      batch.set(userDoc, {
        'email': email,
        'login': login,
        'password': password,
        'score': 0,
        'streak': 0,
        'lastLogin': DateTime.now().toIso8601String(),
        'favorites': [],
        '100procent': 0,
        'awards' : []
      });

      await batch.commit();

      Get.offAllNamed("/login");

    } catch (e) {
      Get.snackbar("Register Error", e.toString());
    }
  }


  Future<void> _updateStreak(DocumentReference userDocRef, Map<String, dynamic> userData) async {
    try {
      DateTime now = DateTime.now();
      DateTime lastLogin = DateTime.parse(userData['lastLogin']);
      int streak = userData['streak'] ?? 0;
      List<dynamic> currentAwards = userData['awards'] ?? [];


      if (now.year != lastLogin.year || now.month != lastLogin.month || now.day != lastLogin.day) {

       int diff = DateTime(now.year, now.month, now.day)
        .difference(DateTime(lastLogin.year, lastLogin.month, lastLogin.day))
        .inDays;

        if (diff == 1) {
          streak++;
        } else if (diff > 1) {
          streak = 0;
        }

        await userDocRef.update({
          'lastLogin': now.toIso8601String(),
          'streak': streak,
        });

        loggedInUserData.update('lastLogin', (_) => now.toIso8601String(), ifAbsent: () => now.toIso8601String());
        loggedInUserData.update('streak', (_) => streak, ifAbsent: () => streak);
      }

      if (streak == 5 && !currentAwards.contains(4)) {
        currentAwards.add(4);
      }
      if (streak == 10 && !currentAwards.contains(6)) {
        currentAwards.add(6);
      }
      if (streak == 15 && !currentAwards.contains(7)) {
        currentAwards.add(7);
      }

      await userDocRef.update({
        'awards': currentAwards,
      });

      loggedInUserData.update('awards', (_) => currentAwards, ifAbsent: () => currentAwards);

      print("Updated streak: $streak");
      print("Updated awards: $currentAwards");
    } catch (e) {
      print("Error updating streak: $e");
    }
  }



  Future<void> incrementUser100Percent() async {
    try {
      String login = loggedInUserData['login'];

      var querySnapshot = await userRF.where('login', isEqualTo: login).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference userDoc = querySnapshot.docs.first.reference;

        var snapshot = await userDoc.get();
        Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;

        int current100Percent = userData['100procent'] ?? 0;
        List<dynamic> currentAwards = List<dynamic>.from(userData['awards'] ?? []);


        current100Percent += 1;


        if (current100Percent == 1 && !currentAwards.contains(1)) {
          currentAwards.add(1);
        }
        if (current100Percent == 3 && !currentAwards.contains(3)) {
          currentAwards.add(3);
        }
        if (current100Percent == 5 && !currentAwards.contains(5)) {
          currentAwards.add(5);
        }
        if (current100Percent == 8 && !currentAwards.contains(5)) {
          currentAwards.add(11);
        }

        await userDoc.update({
          '100procent': current100Percent,
          'awards': currentAwards,
        });

        // Aktualizacja w lokalnych danych użytkownika
        loggedInUserData.update('100procent', (_) => current100Percent, ifAbsent: () => current100Percent);
        loggedInUserData.update('awards', (_) => currentAwards, ifAbsent: () => currentAwards);

        print("Updated 100% count: $current100Percent");
        print("Updated awards: $currentAwards");
      }
    } catch (e) {
      print("Error updating 100% count: $e");
    }
  }


  void navigateToIntroduction() {
    Get.offAllNamed("/introduction");
  }

  void navigateToLoginPage() {
    Get.toNamed(LoginScreen.routeName);
  }

  bool isLoggedIn() {
    return isLogged.value;
  }

  User? getUser() {
    _user.value = _auth.currentUser;
    return _user.value;
  }

  void showLoginAlertDialogue(){
    Get.dialog(Dialogs.questionStartDialogue(onTap: (){
      Get.back();
      navigateToLoginPage();
    }),
        barrierDismissible: false
    );
  }

  Future<int> getUserScore() async {
    try {
      String login = loggedInUserData['login'];

      var querySnapshot = await userRF.where('login', isEqualTo: login).get();

      if (querySnapshot.docs.isNotEmpty) {
        var userDoc = querySnapshot.docs.first;
        return userDoc.data()?['score'] ?? 0;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  Future<int> getUserStreak() async {
    try {
      String login = loggedInUserData['login'];
      var querySnapshot = await userRF.where('login', isEqualTo: login).get();

      if (querySnapshot.docs.isNotEmpty) {
        var userDoc = querySnapshot.docs.first;
        return userDoc.data()?['streak'] ?? 0;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  Future<void> updateUserScore(int points) async {
    try {
      String login = loggedInUserData['login'];

      var querySnapshot = await userRF.where('login', isEqualTo: login).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference userDoc = querySnapshot.docs.first.reference;
        var snapshot = await userDoc.get();

        Map<String, dynamic>? userData = snapshot.data() as Map<String, dynamic>?;

        int currentScore = userData?['score'] ?? 0;
        int newScore = currentScore + points;

        List<dynamic> currentAwards = List<dynamic>.from(userData?['awards'] ?? []);

        if (newScore >= 200 && !currentAwards.contains(8)) {
          currentAwards.add(8);
        }
        if (newScore >= 600 && !currentAwards.contains(9)) {
          currentAwards.add(9);
        }
        if (newScore >= 1000 && !currentAwards.contains(10)) {
          currentAwards.add(10);
        }
        if (newScore >= 1300 && !currentAwards.contains(10)) {
          currentAwards.add(15);
        }

        await userDoc.update({
          'score': newScore,
          'awards': currentAwards,
        });

        // Aktualizacja lokalnych danych użytkownika
        loggedInUserData.update('score', (_) => newScore, ifAbsent: () => newScore);
        loggedInUserData.update('awards', (_) => currentAwards, ifAbsent: () => currentAwards);

        print("Updated score: $newScore");
        print("Updated awards: $currentAwards");
      }
    } catch (e) {
      Get.snackbar("Error", "Unable to update points");
    }
  }


  Future<void> toggleFavoriteQuiz(String quizId) async {
    try {
      String login = loggedInUserData['login'];

      var querySnapshot = await userRF.where('login', isEqualTo: login).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference userDoc = querySnapshot.docs.first.reference;

        var snapshot = await userDoc.get();
        Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;

        List<dynamic> favorites = List<dynamic>.from(userData['favorites'] ?? []);
        List<dynamic> currentAwards = List<dynamic>.from(userData['awards'] ?? []);

        if (favorites.contains(quizId)) {
          favorites.remove(quizId);
        } else {
          favorites.add(quizId);
        }

        if (favorites.length >= 3 && !currentAwards.contains(2)) {
          currentAwards.add(2);
        }

        await userDoc.update({
          'favorites': favorites,
          'awards': currentAwards,
        });

        loggedInUserData.update('favorites', (_) => favorites, ifAbsent: () => favorites);
        loggedInUserData.update('awards', (_) => currentAwards, ifAbsent: () => currentAwards);

        print("Updated favorites: $favorites");
        print("Updated awards: $currentAwards");

        Get.find<QuizPaperController>().filterFavoritePapers();
      }
    } catch (e) {
      print("Error toggling favorite quiz: $e");
    }
  }


  bool isQuizFavorite(String quizId) {
    List<dynamic> favorites = loggedInUserData['favorites'] ?? [];
    return favorites.contains(quizId);
  }


  Future<void> testScheduleNotification() async {
    try {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          title: "Hey! Remember about Quola!",
          body: "Log in to app and don't lose your streak.",
          notificationLayout: NotificationLayout.Default,
        ),
        schedule: NotificationCalendar(
          hour: DateTime.now().hour,
          minute: DateTime.now().minute + 1,
          second: 0,
          millisecond: 0,
          repeats: true,
        ),
      );
      print("Notification scheduled successfully.");
    } catch (e) {
      print("Error scheduling notification: $e");
    }
  }

  Future<void> scheduleNotification() async {
    try {
      final DateTime scheduledTime = DateTime.now().add(Duration(hours: 12));

      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          title: "Hey! Remember about Quala!",
          body: "Log in to app and don't lose your streak.",
          notificationLayout: NotificationLayout.Default,
        ),
        schedule: NotificationCalendar(
          hour: scheduledTime.hour,
          minute: scheduledTime.minute,
          second: 0,
          millisecond: 0,
          day: scheduledTime.day,
          month: scheduledTime.month,
          year: scheduledTime.year,
          repeats: false,
        ),
      );
      print("Notification scheduled successfully.");
    } catch (e) {
      print("Error scheduling notification: $e");
    }
  }
}
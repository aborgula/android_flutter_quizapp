import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hci/controllers/auth_controller.dart';
import 'package:hci/models/question_paper_model.dart';
import 'package:hci/firebase_ref/references.dart';
import 'package:hci/screens/question/question_screen.dart';
import '../../services/firebase_storage_service.dart';

class QuizPaperController extends GetxController{

  final allPapers =<QuestionPaperModel>[].obs;
  final allPaperImages =<String>[].obs;
  final favoritePapers = <QuestionPaperModel>[].obs;

  @override
  void onReady(){
      getAllPapers();
      super.onReady();
  }

   Future<void>getAllPapers() async{
    try{
      QuerySnapshot<Map<String, dynamic>> data = await questionPaperRF.get();
      final paperList = data.docs
          .map((paper) => QuestionPaperModel.fromSnapshot(paper))
          .toList();
      allPapers.assignAll(paperList);


      for(var paper in paperList){
        final imgUrl =
          await Get.find<FirebaseStorageService>().getImage(paper.title);
        allPaperImages.add(imgUrl!);//to potrzebne idk czemu
        paper.imageUrl = imgUrl;
        //print(paper.questionsCount);
      }

      allPapers.assignAll(paperList);
      filterFavoritePapers();

    }catch(e){
      print(e);
    }
  }

  void filterFavoritePapers() {
    final AuthController authController = Get.find<AuthController>();
    final favoriteIds = authController.loggedInUserData['favorites'] ?? [];
    print('here');
  print(favoriteIds);

    favoritePapers.assignAll(
      allPapers.where((paper) => favoriteIds.contains(paper.id)).toList(),
    );
  }

  void removeFavorite(String quizId) {
    final AuthController authController = Get.find<AuthController>();
    favoritePapers.removeWhere((quiz) => quiz.id == quizId);

    authController.toggleFavoriteQuiz(quizId);
  }



  void navigateToQuestions({required QuestionPaperModel paper, bool tryAgain=false}){
    AuthController _authController = Get.find();

    if(_authController.isLogged.value){ //change
      if(tryAgain){
        Get.back();
        Get.toNamed(QuestionsScreen.routeName,
        arguments: paper,
        preventDuplicates: false);
      }else{
        Get.toNamed(QuestionsScreen.routeName, arguments: paper);
      }
    }else{
      print('The title is ${paper.title}');
      _authController.showLoginAlertDialogue();
      //Get.toNamed();
    }
  }

  void handleShake() {
    if (allPapers.isNotEmpty) {
      final int randomIndex = Random().nextInt(allPapers.length);
      final questionPaper = allPapers[randomIndex];

      Get.snackbar(
        "${questionPaper.title}",
        "You got the quiz: ${questionPaper.title}",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
        backgroundColor: Colors.pink.withOpacity(0.5),
        colorText: Colors.white,
      );

      navigateToQuestions(paper: questionPaper);

    } else {
      print("No quizzez available.");
    }
  }

}



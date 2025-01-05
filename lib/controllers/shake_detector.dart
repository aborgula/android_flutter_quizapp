import 'dart:async';
import 'dart:math';
import 'package:get/get.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:hci/controllers/question_paper/question_paper_controller.dart';

class ShakeDetectorController extends GetxController {
  final QuizPaperController quizPaperController = Get.find<QuizPaperController>();

  final double shakeThreshold = 13.0; // Sensitivity
  late StreamSubscription _accelerometerSubscription;
  double lastX = 0.0, lastY = 0.0, lastZ = 0.0;

  @override
  void onInit() {
    super.onInit();
    _startListening();
  }

  @override
  void onClose() {
    _accelerometerSubscription.cancel();
    super.onClose();
  }

  void _startListening() {
    _accelerometerSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
      final double dx = event.x - lastX;
      final double dy = event.y - lastY;
      final double dz = event.z - lastZ;

      final double acceleration = sqrt(dx * dx + dy * dy + dz * dz);

      if (acceleration > shakeThreshold) {
        _onShakeDetected();
      }

      lastX = event.x;
      lastY = event.y;
      lastZ = event.z;
    });
  }

  void _onShakeDetected() {
    quizPaperController.handleShake();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';

class AwardCard extends StatelessWidget {
  final String imagePath;
  final String description;
  final int id;

  const AwardCard({
    Key? key,
    required this.id,
    required this.imagePath,
    this.description = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final bool hasAward = authController.loggedInUserData['awards']?.contains(id) ?? false;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Stack(
        alignment: Alignment.center, // Wyrównanie zawartości w `Stack`
        children: [
          // Główna zawartość karty (nagroda)
          Column(
            mainAxisAlignment: MainAxisAlignment.center, // Wyśrodkowanie
            children: [
              // Obrazek
              Flexible(
                flex: 6,
                child: Image.asset(
                  imagePath,
                  height: 55,
                  width: 55,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 6),
              // Opis tylko jeśli użytkownik ma nagrodę
              if (hasAward)
                Flexible(
                  flex: 2,
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
              const SizedBox(height: 2),
            ],
          ),
          // Szare pokrycie z pytajnikiem, jeśli użytkownik nie ma nagrody
          if (!hasAward)
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(
                  Icons.help_outline,
                  size: 48,
                  color: Colors.yellow,
                ),
              ),
            ),
        ],
      ),
    );
  }
}



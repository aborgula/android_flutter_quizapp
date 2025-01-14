import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hci/configs/themes/app_colors.dart';
import 'package:hci/configs/themes/ui_parameters.dart';
import 'package:hci/widgets/questions/answer_card.dart';

class QuestionNumberCard extends StatelessWidget {
  const QuestionNumberCard({Key? key,
  required this.index,
    required this.status,
    required this.onTap
  }) : super(key: key);

  final int index;
  final AnswerStatus? status;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Color _backgroundColor = Theme.of(context).primaryColor;
    switch(status){
      case AnswerStatus.answered:
          _backgroundColor: Get.isDarkMode?
              Theme.of(context).cardColor:Theme.of(context).primaryColor;
        break;
      case AnswerStatus.correct:
              _backgroundColor = correctAnswerColor;
        break;
      case AnswerStatus.wrong:
              _backgroundColor = wrongAnswerColor;
        break;
      case AnswerStatus.notanswered:
              _backgroundColor = Get.isDarkMode?
                  Colors.red.withOpacity(0.5):
                  Theme.of(context).primaryColor.withOpacity(0.1);
        break;
      default:
        _backgroundColor = Theme.of(context).primaryColor.withOpacity(0.1);
    }

    return InkWell(
      borderRadius: UIParameters.cardBorderRadius,
      onTap: onTap,
      child: Ink(
        child: Center(
          child: Text(
            '$index',
            style: TextStyle(
              color: status == AnswerStatus.notanswered?
                  Theme.of(context).primaryColor
                  :null
            ) ,
          )
        ),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: UIParameters.cardBorderRadius
        ),
      ),
    );
  }
}

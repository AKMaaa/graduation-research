import 'package:flutter/material.dart';
import 'package:flutter_application/src/parts/top_bar.dart';


class AnswerPage extends StatelessWidget {
  final String quizNumber;
  final String title;
  final String imgPath;
  final String text;
  final String question;

  const AnswerPage({
    Key? key,
    required this.quizNumber,
    required this.title,
    required this.imgPath,
    required this.text,
    required this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 問題の詳細を表示する UI をここに実装
    return Scaffold(
      appBar: CustomAppBarBack(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // ここに問題の詳細を表示するウィジェットを追加
          ],
        ),
      ),
    );
  }
}

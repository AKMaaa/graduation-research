import 'package:flutter/material.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "AI Snapshots",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              "近年話題になったAIに関連した時事問題を解いてみよう😆",
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffBDBDBD)),
            ),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                //decoration
                labelText: '問題を検索する',
                labelStyle: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffBDBDBD),
                ),
                hintText: 'キーワードを入力してください',
                hintStyle: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffBDBDBD),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xffBDBDBDB),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Color(0xffF2F6FF),
              ),
              onSubmitted: (String value) {
                // Search Processing
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application/src/quiz-list.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});
  @override
  Widget build(BuildContext context) {
    // 科目名とページをマッピングする辞書
    final Map<String, Widget Function(BuildContext)> subjectPages = {
      '国語': (context) => LanguagePage(),
      '数学': (context) => MathPage(),
      '科学': (context) => SciencePage(),
      '社会': (context) => SocietyPage(),
    };
    // 科目名に基づいてページにナビゲートするメソッド
    void navigateToSubject(String subject) {
      final pageBuilder = subjectPages[subject];
      if (pageBuilder != null) {
        Navigator.push(context, MaterialPageRoute(builder: pageBuilder));
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 0, right: 20.0, bottom: 20.0, left: 20.0),
        child: SingleChildScrollView(
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
              SizedBox(height: 40.0),
              Text(
                "科目別で探す",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12.0),
              Row(
                children: [
                  Expanded(
                    child: SubjectCard(
                      title: "国語",
                      imgPath: "lib/src/assets/img/language.png",
                      progress: 28,
                      total: 45,
                      onTap: () => navigateToSubject('国語'),
                    ),
                  ),
                  Expanded(
                    child: SubjectCard(
                      title: "数学",
                      imgPath: "lib/src/assets/img/math.png",
                      progress: 10,
                      total: 45,
                      onTap: () => navigateToSubject('数学'),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: SubjectCard(
                      title: "科学",
                      imgPath: "lib/src/assets/img/science.png",
                      progress: 5,
                      total: 45,
                      onTap: () => navigateToSubject('科学'),
                    ),
                  ),
                  Expanded(
                    child: SubjectCard(
                      title: "数学",
                      imgPath: "lib/src/assets/img/society.png",
                      progress: 43,
                      total: 45,
                      onTap: () => navigateToSubject('数学'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubjectCard extends StatelessWidget {
  final String title;
  final String imgPath;
  final int progress;
  final int total;
  final Function() onTap;

  const SubjectCard({
    required this.title,
    required this.imgPath,
    required this.progress,
    required this.total,
    required this.onTap,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Color(0xffffffff),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xffffffff),
            border: Border.all(
              color: Color(0xffEDEDED),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.0),
                Image.asset(
                  imgPath,
                  width: 50,
                  height: 50,
                ),
                SizedBox(height: 8.0),
                LinearProgressIndicator(
                  value: progress / total,
                  backgroundColor: Color(0xff6D7278),
                  color: Color(0xff9AE600),
                  minHeight: 5,
                  borderRadius: BorderRadius.circular(100.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  '$progress / $total 終了',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff6D7278),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

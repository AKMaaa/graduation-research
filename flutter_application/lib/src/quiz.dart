import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/src/quiz-list.dart';
import 'package:flutter_application/src/answer.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({Key? key}) : super(key: key);

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
                "今日の1問",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance.collection('quiz').get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("エラーが発生しました"));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("クイズがありません"));
                  }

                  var sortedDocs = snapshot.data!.docs;
                  sortedDocs.sort(
                      (a, b) => int.parse(a.id).compareTo(int.parse(b.id)));

                  var quizData = sortedDocs[17];

                  return QuizCard(
                    title: quizData['title'],
                    quiz_number: quizData['number'],
                    imgPath: quizData['imageURL'],
                    elsitags: List<String>.from(
                        quizData['elsiTag']), // Firestoreから配列を取得
                    techtags: List<String>.from(
                        quizData['techTag']), // Firestoreから配列を取得
                    text: quizData['text'],
                    question: quizData['question'],
                    // データに応じて他のプロパティも設定
                  );
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
                      title: "社会",
                      imgPath: "lib/src/assets/img/society.png",
                      progress: 43,
                      total: 45,
                      onTap: () => navigateToSubject('社会'),
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

class QuizCard extends StatelessWidget {
  final String title;
  final String quiz_number;
  final List<dynamic> elsitags; // elsitagの配列
  final List<dynamic> techtags; // techtagの配列
  final String imgPath;
  final String text;
  final String question;
  // final int progress; // progressとtotalの値はFirestoreのデータ構造に依存します
  // final int total;   // もしFirestoreにこれらのフィールドがあれば、引数に追加してください

  const QuizCard({
    required this.title,
    required this.quiz_number,
    required this.elsitags, // elsitagの配列を受け取る
    required this.techtags, // techtagの配列を受け取る
    required this.imgPath, // imageのpath
    required this.text, // 社会事例のtext
    required this.question,

    // required this.progress,
    // required this.total,
    Key? key,
  }) : super(key: key);

  Widget buildImage(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0), // 画像の角の丸み
      child: Image.network(
        imagePath,
        width: 90.0, // 画像の幅を調整
        height: 90.0, // 画像の高さを調整
        fit: BoxFit.cover, // 画像をクロップして拡大表示
      ),
    );
  }

  void navigateToAnswerPage(BuildContext context) {
    // `AnswerPage` is a placeholder for your actual question details page.
    // Replace with the actual page class and pass the necessary arguments.
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnswerPage(
          quizNumber: quiz_number,
          title: title,
          imgPath: imgPath,
          text: text,
          question: question,
        ),
      ),
    );
  }

  void showQuizDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0.0,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          actions: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                decoration: BoxDecoration(
                  color: Colors.orange[300], // 戻るボタンの背景色
                  borderRadius: BorderRadius.circular(100), // 角の丸み
                ),
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.white), // アイコンを白色に設定
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ),
            ),
          ],
          title: Text(
            'No.$quiz_number $title',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          contentPadding:
              EdgeInsets.only(left: 24, right: 24, top: 10, bottom: 0),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SizedBox(height: 10),
                buildImage(imgPath),
                SizedBox(height: 10),
                Text('$text',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff404040),
                    )),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xffE8E8E8),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.quiz), // Replace with your quiz icon
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '$question',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff161616),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: ElevatedButton(
                    child: Text(
                      'この問題に挑戦する',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(0, 12, 0, 15),
                      backgroundColor: Colors.orange[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 1.0, // 影の大きさ
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog first
                      navigateToAnswerPage(context);
                    },
                  ),
                ),
                // ... add more widgets if needed
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // タグ行を構築する関数
    Widget buildTagRow(List<dynamic> tags, IconData icon) {
      // タグリストからウィジェットリストを構築
      List<Widget> tagWidgets = tags
          .map((tag) => Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                margin: EdgeInsets.only(right: 0.0),
                decoration: BoxDecoration(
                  color: Colors.white, // タグの背景色
                  borderRadius: BorderRadius.circular(20.0), // タグのボーダーの丸み
                  border: Border.all(
                    color: Color(0xffFDC08E),
                    width: 2.0,
                  ),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    fontSize: 12.0, // タグのフォントサイズ
                    color: Color(0xffFDC08E),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ))
          .toList();

      // タグとアイコンをWrapで横並びに表示
      return Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 5.0, // 横のスペース
        children: [
          Icon(icon, size: 16.0), // アイコンサイズ
          ...tagWidgets, // 展開されたタグリスト
        ],
      );
    }

    Widget buildTitleBar(String quizNumber, String title) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.orange[300], // タイトルバーの背景色
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // エレメントを左右に分ける
          children: [
            // クイズ番号とタイトルを含む左側のコンテナ
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "No.$quizNumber",
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(text: " "), // スペースを追加
                    TextSpan(
                      text: title,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // 編集アイコンを含む右側のコンテナ
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(
                Icons.favorite,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    }

    // double screenWidth = MediaQuery.of(context).size.width;
    // Firestoreのデータに基づいてカードUIを構築
    return InkWell(
      onTap: () => showQuizDialog(context),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(0xffEDEDED), width: 1), // ボーダーを追加
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Color(0xffffffff),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTitleBar(quiz_number, title), // タイトルバーを追加
            Padding(
              padding: EdgeInsets.all(16.0),
              child: IntrinsicHeight(
                // 子ウィジェットの高さを合わせる
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 18),
                          buildTagRow(
                              elsitags, Icons.lightbulb_outline), // elsitagを表示
                          SizedBox(height: 8.0),
                          buildTagRow(techtags, Icons.computer), // techtagを表示
                        ],
                      ),
                    ),
                    buildImage(imgPath), // 画像を表示
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

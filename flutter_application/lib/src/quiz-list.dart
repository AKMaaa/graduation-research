import 'package:flutter/material.dart';
import 'package:flutter_application/src/parts/top_bar.dart';
import 'package:flutter_application/src/quiz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  late Future<List<QuizCard>> _quizCards;

  @override
  void initState() {
    super.initState();
    _quizCards = _loadQuizCards();
  }

  Future<List<QuizCard>> _loadQuizCards() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('quiz')
        .where('subject', isEqualTo: '国語')
        .get();

    var sortedDocs = snapshot.docs;
    sortedDocs.sort((a, b) {
      int numA = int.tryParse(a['number']) ?? 0;
      int numB = int.tryParse(b['number']) ?? 0;
      return numA.compareTo(numB);
    });

    return sortedDocs.map((doc) {
      var data = doc.data();
      return QuizCard(
        title: data['title'],
        quiz_number: data['number'],
        imgPath: data['imageURL'],
        elsitags: List<String>.from(data['elsiTag']),
        techtags: List<String>.from(data['techTag']),
        text: data['text'],
        question: data['question'],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarBack(),
      body: FutureBuilder<List<QuizCard>>(
        future: _quizCards,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return Center(child: Text('エラーが発生しました'));
          }

          // QuizCardにマージンを追加
          return ListView(
            children: snapshot.data!.map((quizCard) {
              return Padding(
                padding: EdgeInsets.fromLTRB(20,0,20,8),
                child: quizCard,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class MathPage extends StatefulWidget {
  @override
  _MathPageState createState() => _MathPageState();
}

class _MathPageState extends State<MathPage> {
  late Future<List<QuizCard>> _quizCards;

  @override
  void initState() {
    super.initState();
    _quizCards = _loadQuizCards();
  }

  Future<List<QuizCard>> _loadQuizCards() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('quiz')
        .where('subject', isEqualTo: '数学')
        .get();

    var sortedDocs = snapshot.docs;
    sortedDocs.sort((a, b) {
      int numA = int.tryParse(a['number']) ?? 0;
      int numB = int.tryParse(b['number']) ?? 0;
      return numA.compareTo(numB);
    });

    return sortedDocs.map((doc) {
      var data = doc.data();
      return QuizCard(
        title: data['title'],
        quiz_number: data['number'],
        imgPath: data['imageURL'],
        elsitags: List<String>.from(data['elsiTag']),
        techtags: List<String>.from(data['techTag']),
        text: data['text'],
        question: data['question'],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarBack(),
      body: FutureBuilder<List<QuizCard>>(
        future: _quizCards,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return Center(child: Text('エラーが発生しました'));
          }

          // QuizCardにマージンを追加
          return ListView(
            children: snapshot.data!.map((quizCard) {
              return Padding(
                padding: EdgeInsets.fromLTRB(20,0,20,8),
                child: quizCard,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class SciencePage extends StatefulWidget {
  @override
  _SciencePageState createState() => _SciencePageState();
}

class _SciencePageState extends State<SciencePage> {
  late Future<List<QuizCard>> _quizCards;

  @override
  void initState() {
    super.initState();
    _quizCards = _loadQuizCards();
  }

  Future<List<QuizCard>> _loadQuizCards() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('quiz')
        .where('subject', isEqualTo: '科学')
        .get();

    var sortedDocs = snapshot.docs;
    sortedDocs.sort((a, b) {
      int numA = int.tryParse(a['number']) ?? 0;
      int numB = int.tryParse(b['number']) ?? 0;
      return numA.compareTo(numB);
    });

    return sortedDocs.map((doc) {
      var data = doc.data();
      return QuizCard(
        title: data['title'],
        quiz_number: data['number'],
        imgPath: data['imageURL'],
        elsitags: List<String>.from(data['elsiTag']),
        techtags: List<String>.from(data['techTag']),
        text: data['text'],
        question: data['question'],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarBack(),
      body: FutureBuilder<List<QuizCard>>(
        future: _quizCards,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return Center(child: Text('エラーが発生しました'));
          }

          // QuizCardにマージンを追加
          return ListView(
            children: snapshot.data!.map((quizCard) {
              return Padding(
                padding: EdgeInsets.fromLTRB(20,0,20,8),
                child: quizCard,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class SocietyPage extends StatefulWidget {
  @override
  _SocietyPageState createState() => _SocietyPageState();
}

class _SocietyPageState extends State<SocietyPage> {
  late Future<List<QuizCard>> _quizCards;

  @override
  void initState() {
    super.initState();
    _quizCards = _loadQuizCards();
  }

  Future<List<QuizCard>> _loadQuizCards() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('quiz')
        .where('subject', isEqualTo: '社会')
        .get();

    var sortedDocs = snapshot.docs;
    sortedDocs.sort((a, b) {
      int numA = int.tryParse(a['number']) ?? 0;
      int numB = int.tryParse(b['number']) ?? 0;
      return numA.compareTo(numB);
    });

    return sortedDocs.map((doc) {
      var data = doc.data();
      return QuizCard(
        title: data['title'],
        quiz_number: data['number'],
        imgPath: data['imageURL'],
        elsitags: List<String>.from(data['elsiTag']),
        techtags: List<String>.from(data['techTag']),
        text: data['text'],
        question: data['question'],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarBack(),
      body: FutureBuilder<List<QuizCard>>(
        future: _quizCards,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return Center(child: Text('エラーが発生しました'));
          }

          // QuizCardにマージンを追加
          return ListView(
            children: snapshot.data!.map((quizCard) {
              return Padding(
                padding: EdgeInsets.fromLTRB(20,0,20,8),
                child: quizCard,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

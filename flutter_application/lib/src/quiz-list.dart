import 'package:flutter/material.dart';
import 'package:flutter_application/src/parts/top_bar.dart';
import 'package:flutter_application/src/parts/bottom_bar.dart';
import 'package:flutter_application/src/parts/ui-parts.dart';
import 'package:flutter_application/src/quiz.dart';
import 'package:flutter_application/src/add.dart';
import 'package:flutter_application/src/ai.dart';
import 'package:flutter_application/src/profile.dart';

class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  int myCurrentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarBack(),
      body: Center(
        child: Text('国語のコンテンツがここに表示されます'),
      ),
    );
  }
}

class MathPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Text('数学のコンテンツがここに表示されます'),
      ),
    );
  }
}

class SciencePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Text('科学のコンテンツがここに表示されます'),
      ),
    );
  }
}

class SocietyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Text('社会のコンテンツがここに表示されます'),
      ),
    );
  }
}

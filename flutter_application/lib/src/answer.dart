import 'package:flutter/material.dart';
import 'package:flutter_application/src/parts/top_bar.dart';

class AnswerPage extends StatefulWidget {
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
  _AnswerPageState createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  final TextEditingController _controller = TextEditingController();
  List<String> _submittedTexts = [];

  void _handleSubmit() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _submittedTexts.insert(0, _controller.text);
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: CustomAppBarBack(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "No.${widget.quizNumber} ${widget.title}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0), // 画像の角を丸める
                  child: Image.network(widget.imgPath),
                ),
                SizedBox(height: 16),
                Text(widget.text, style: TextStyle(fontSize: 14)),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xffE8E8E8),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.quiz), // クイズアイコン
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          widget.question,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff161616),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.22,
            maxChildSize: 0.8,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                padding: const EdgeInsets.all(16.0), // 全体にPaddingを追加
                decoration: BoxDecoration(
                  color: Colors.white, // 背景色を白く設定
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black26)],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 12),
                    Container(
                      width: 30,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: _submittedTexts.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              _submittedTexts[index],
                              style:
                                  TextStyle(fontSize: 14, color: Colors.blue),
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: "ここに考えたことを入力してください。",
                              border: OutlineInputBorder(),
                            ),
                            onSubmitted: (_) => _handleSubmit(),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        ElevatedButton(
                          onPressed: _handleSubmit,
                          child: Text('送信'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

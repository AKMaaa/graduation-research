import 'package:flutter/material.dart';
import 'package:flutter_application/src/parts/top_bar.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

// Add this import statement at the top of the file to resolve the error.

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
  double _minChildSize = 0.15;
  String debug_text = "debug 1549";

  // print("$debug_text $keyboardHeight $screenHeight $newMinChildSize");

  @override
  void initState() {
    super.initState();
    var keyboardVisibilityController = KeyboardVisibilityController();

    keyboardVisibilityController.onChange.listen((bool visible) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
          double screenHeight = MediaQuery.of(context).size.height;
          double newMinChildSize;

          if (keyboardHeight > 0) {
            // newMinChildSize = (keyboardHeight / screenHeight).clamp(_minChildSize, 0.93);
            newMinChildSize = 0.15;
          } else {
            newMinChildSize = 0.28;
          }

          print("$debug_text $keyboardHeight $screenHeight $newMinChildSize");
          setState(() {
            _minChildSize = newMinChildSize;
          });
        }
      });
    });
  }

  void _handleSubmit() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _submittedTexts.add(_controller.text);
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                  child: Image.network(
                    widget.imgPath,
                    width: MediaQuery.of(context).size.width * 1, // 画像のサイズを調整
                  ),
                ),
                SizedBox(height: 16),
                Text(widget.text, style: TextStyle(fontSize: 14)),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xffE8E8E8), // チャットの部分の背景色
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
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: ElevatedButton(
                    child: Text(
                      'この問題を終了する',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      padding: EdgeInsets.fromLTRB(10, 12, 10, 15),
                      backgroundColor: Colors.orange[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 1.0, // 影の大きさ
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: _minChildSize,
            minChildSize: _minChildSize,
            maxChildSize: 0.93,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  // boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black26)],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    Container(
                      width: 100,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: _submittedTexts.length,
                        itemBuilder: (context, index) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: Offset(0, 2), // 影の位置を変更
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 7.0),
                              margin: EdgeInsets.only(top: 15.0),
                              child: Text(
                                _submittedTexts[index],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 0,
                        right: 0,
                        // top: 0,
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                hintText: "考えたことを入力する",
                                hintStyle: TextStyle(
                                  color: Color(0xffFDC08E),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w800,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide: BorderSide(
                                      color: Color(0xfffdc08e), width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide: BorderSide(
                                      color: Colors.orange[300]!, width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide: BorderSide(
                                      color: Colors.green, width: 2.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 20.0,
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w800,
                              ),
                              onSubmitted: (_) => _handleSubmit(),
                            ),
                          ),
                          Container(
                            width: 50,
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            decoration: BoxDecoration(
                              color: Color(0xfffdc08e), // 背景色を赤に設定
                              borderRadius:
                                  BorderRadius.circular(100), // 角を丸くする
                            ),
                            child: IconButton(
                              icon: Icon(Icons.send),
                              color: Colors.white,
                              onPressed: _handleSubmit,
                            ),
                          ),
                        ],
                      ), //), 追加
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
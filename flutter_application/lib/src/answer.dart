import 'package:flutter/material.dart';
import 'package:flutter_application/src/parts/top_bar.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_application/src/answer-list.dart';
import 'package:flutter_application/src/message_model.dart';

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
  List<Message> _submittedTexts = [];
  double _minChildSize = 0.15;

  @override
  void initState() {
    super.initState();
    var keyboardVisibilityController = KeyboardVisibilityController();

    keyboardVisibilityController.onChange.listen((bool visible) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
          // double screenHeight = MediaQuery.of(context).size.height;
          double newMinChildSize;

          if (keyboardHeight > 0) {
            // newMinChildSize = (keyboardHeight / screenHeight).clamp(_minChildSize, 0.93);
            newMinChildSize = 0.15;
          } else {
            newMinChildSize = 0.28;
          }

          setState(() {
            _minChildSize = newMinChildSize;
          });
        }
      });
    });
  }

  void _handleSubmit() {
    if (_controller.text.isNotEmpty) {
      final text = _controller.text;
      final type = _isURL(text) ? MessageType.url : MessageType.text;

      print(
          'Submitted text: $text, Detected as URL: ${_isURL(text)}'); // デバッグ用の出力

      setState(() {
        _submittedTexts.add(Message(type: type, content: text));
        _controller.clear();
      });
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _submittedTexts
            .add(Message(type: MessageType.image, content: image.path));
      });
    }
  }

  //画像拡大表示のヘルパーメソッド
  void _showImageDialog(String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.all(26), // ダイアログの周りのパディングを削除
          child: Container(
            margin: EdgeInsets.all(0), // コンテナのマージンを削除
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0), // 角丸の設定（必要に応じて）
              child: Image.file(
                File(imagePath),
                fit: BoxFit.cover, // 画像のフィットモード
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(Uri.encodeFull(urlString));
    if (await canLaunchUrl(url)) {
      try {
        await launchUrl(url);
      } catch (e) {
        print('URL launch error: $e');
      }
    } else {
      print('Could not launch $url');
    }
  }

  bool _isURL(String text) {
    final Uri? uri = Uri.tryParse(text);
    if (uri == null) return false;
    return uri.scheme == 'http' || uri.scheme == 'https';
  }

  Future<bool> _onWillPop() async {
    return (await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('警告'),
            content: Text('本当に前の画面に戻りますか？'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('いいえ'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('はい'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
                        '回答を終了する',
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AnswerListPage(messages: _submittedTexts),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: _minChildSize,
              minChildSize: _minChildSize,
              maxChildSize: 0.93,
              builder:
                  (BuildContext context, ScrollController scrollController) {
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
                        margin: EdgeInsets.fromLTRB(0,0,0,0),
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
                            final message = _submittedTexts[index];
                            switch (message.type) {
                              case MessageType.text:
                                return Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                        vertical: 5.0), // ここを調整
                                    margin: EdgeInsets.only(
                                        top: 10.0,
                                        left: 10.0,
                                        right: 10.0,
                                        bottom: 10.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white, // 背景色
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
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
                                    child: Text(
                                      message.content,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                );
                              case MessageType.image:
                                return Container(
                                  height: 300.0,
                                  margin: EdgeInsets.only(
                                      top: 10.0,
                                      left: 10.0,
                                      right: 10.0,
                                      bottom: 10.0),
                                  child: GestureDetector(
                                    onTap: () => _showImageDialog(
                                        message.content), // ここを追加
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          15.0), // 画像の角を丸める
                                      child: Image.file(
                                        File(message.content),
                                        fit: BoxFit.cover, // ここを変更
                                      ),
                                    ),
                                  ),
                                );
                              case MessageType.url:
                                return Padding(
                                  padding: const EdgeInsets.all(8.0), // 余白を追加
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white, // 背景色を白に設定
                                      borderRadius:
                                          BorderRadius.circular(10.0), // 角を丸める
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: Offset(0, 2), // 影の位置を変更
                                        ),
                                      ],
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        print(
                                            'URL Tapped: ${message.content}'); // タップ時にコンソールに出力
                                        _launchURL(message.content);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(
                                            10.0), // 内側の余白を追加
                                        child: Row(
                                          mainAxisSize:
                                              MainAxisSize.min, // 行のサイズを内容に合わせる
                                          children: [
                                            Icon(Icons.link,
                                                color: Colors.blue), // リンクアイコン
                                            SizedBox(
                                                width: 8.0), // アイコンとテキストの間隔
                                            Expanded(
                                              child: Text(
                                                message.content,
                                                style: TextStyle(
                                                  fontSize:
                                                      20.0, // フォントサイズを大きくする
                                                  color: Colors.blue,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                                overflow: TextOverflow
                                                    .ellipsis, // 長いテキストを省略
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );

                              default:
                                return SizedBox.shrink();
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 0,
                          right: 0,
                          // top: 10,
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _controller,
                                decoration: InputDecoration(
                                  hintText: "考えたことを入力する",
                                  prefixIcon: IconButton(
                                    icon: Icon(Icons.photo_camera),
                                    onPressed: _pickImage,
                                  ),
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
      ),
    );
  }
}

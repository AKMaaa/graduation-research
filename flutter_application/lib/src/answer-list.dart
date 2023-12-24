import 'package:flutter/material.dart';
import 'package:flutter_application/src/parts/top_bar.dart';
import 'package:flutter_application/src/message_model.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AnswerListPage extends StatefulWidget {
  final List<Message> messages;
  final String quizId;

  AnswerListPage({Key? key, required this.messages, required this.quizId})
      : super(key: key);

  @override
  _AnswerListPageState createState() => _AnswerListPageState();
}

class _AnswerListPageState extends State<AnswerListPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  bool _isPublicSelected = true;

  // abs data
  List<Message> messages = [
    Message(type: MessageType.text, content: 'text'),
    Message(type: MessageType.image, content: 'imagePath'),
    Message(type: MessageType.url, content: 'https://example.com'),
  ];

  MessageType? selectedType;

  void _showFullImageDialog(String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0), // ここでも角丸を適用
            child: Image.file(File(imagePath)),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Message> filteredMessages = selectedType == null
        ? widget.messages
        : widget.messages.where((msg) => msg.type == selectedType).toList();

    return Scaffold(
      appBar: CustomAppBarBack(),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            margin: EdgeInsets.only(bottom: 15),
            color: Colors.white,
            child: DropdownButton<MessageType>(
              hint: Text("絞り込み"),
              value: selectedType,
              onChanged: (MessageType? newValue) {
                setState(() {
                  selectedType = newValue;
                });
              },
              items: [
                DropdownMenuItem(
                  value: null, // 全て表示
                  child: Row(
                    children: [
                      Icon(Icons.all_inclusive), // 全部アイコン
                      SizedBox(width: 8),
                      Text("all"),
                    ],
                  ),
                ),
                ...MessageType.values.map((MessageType type) {
                  return DropdownMenuItem<MessageType>(
                    value: type,
                    child: Row(
                      children: [
                        _getIconForMessageType(type), // アイコン
                        SizedBox(width: 8),
                        Text(type.toString().split('.').last), // テキスト
                      ],
                    ),
                  );
                }).toList(),
              ],
              isExpanded: true,
              underline: Container(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredMessages.length,
              itemBuilder: (context, index) {
                final message = filteredMessages[index];

                switch (message.type) {
                  case MessageType.text:
                    // テキストの場合
                    return ListTile(
                      title: Text(message.content),
                      leading: _buildCheckbox(message),
                    );
                  case MessageType.image:
                    // 画像の場合
                    return ListTile(
                      title: GestureDetector(
                        onTap: () => _showFullImageDialog(message.content),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0), // 角丸の設定
                          child: Image.file(
                            File(message.content),
                            height: 200.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      leading: _buildCheckbox(message),
                    );
                  case MessageType.url:
                    // URLの場合
                    return ListTile(
                      title: InkWell(
                        child: Text(
                          message.content,
                          style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                        ),
                        onTap: () => _launchURL(message.content),
                      ),
                      leading: _buildCheckbox(message),
                    );
                  default:
                    return SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Icon _getIconForMessageType(MessageType type) {
    switch (type) {
      case MessageType.text:
        return Icon(Icons.text_fields); // テキストアイコン
      case MessageType.image:
        return Icon(Icons.photo); // 写真アイコン
      case MessageType.url:
        return Icon(Icons.link); // URLアイコン
      default:
        return Icon(Icons.error); // デフォルトアイコン
    }
  }

  Widget _buildCheckbox(Message message) {
    return Checkbox(
      value: message.isSelected,
      onChanged: (bool? value) {
        setState(() {
          message.isSelected = value!;
        });
      },
    );
  }

  Future<void> _launchURL(String urlString) async {
    if (await canLaunchUrl(Uri.parse(urlString))) {
      await launchUrl(Uri.parse(urlString));
    } else {
      throw 'Could not launch $urlString';
    }
  }

  Widget _buildBottomBar() {
    return BottomAppBar(
      elevation: 0.0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Toggle buttons
            _buildToggleIcon(
              icon: Icons.person,
              text: "個人",
              isSelected: !_isPublicSelected,
              isLeft: true,
              onTap: () => setState(() => _isPublicSelected = false),
            ),
            _buildToggleIcon(
              icon: Icons.public,
              text: "全体",
              isSelected: _isPublicSelected,
              isLeft: false,
              onTap: () => setState(() => _isPublicSelected = true),
            ),
            SizedBox(width: 10),
            // Save button
            ElevatedButton.icon(
              icon: Icon(Icons.save, color: Color(0xffFDC08E)),
              label: Text(
                "保存",
                style: TextStyle(color: Color(0xffFDC08E)),
              ),
              onPressed: () {
                if (_isPublicSelected) {
                  _saveToFirestore();
                } else {
                  _saveToFirestore();
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white, // Button background color
                onPrimary:
                    Color(0xffFDC08E), // Ripple color (effect color on press)
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Color(0xffFDC08E)), // Border color
                ),
                elevation: 0, // Removes shadow
              ),
            )
          ],
        ),
      ),
      color: Color(0xffFFFFFF),
    );
  }

  Widget _buildToggleIcon({
    required IconData icon,
    required String text,
    required bool isSelected,
    required bool isLeft,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () {
          onTap();
          setState(() {
            _isPublicSelected = isLeft ? false : true;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 250),
          height: 40,
          decoration: BoxDecoration(
            color: isSelected ? Color(0xffFDC08E) : Colors.transparent,
            borderRadius: isLeft
                ? BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
            border: Border.all(
              color: Color(0xffFDC08E),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                color: isSelected ? Colors.white : Color(0xffFDC08E),
              ),
              SizedBox(width: 4),
              Text(
                text,
                style: TextStyle(
                  color: isSelected ? Colors.white : Color(0xffFDC08E),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveToFirestore() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    var quizId = widget.quizId;
    print("Quiz ID : $quizId");

    var selectedMessages =
        widget.messages.where((msg) => msg.isSelected).toList();

    DocumentReference docRef;
    String storagePath;

    if (_isPublicSelected) {
      docRef = _firestore.collection('quiz').doc(quizId);
      storagePath = 'quiz/all/$quizId/';
    } else {
      docRef = _firestore
          .collection('users')
          .doc(user.uid)
          .collection('quiz')
          .doc(quizId);
      storagePath = 'quiz/personal/${user.email}/$quizId/';
    }

    var docSnapshot = await docRef.get();
    var batch = _firestore.batch();

    if(!docSnapshot.exists) {
        batch.set(docRef, {"answers" : []});
    }

    for (var message in selectedMessages) {
      if (message.type == MessageType.image) {
        // Upload image to Storage
        var imagePath =
            '$storagePath${DateTime.now().millisecondsSinceEpoch}.png';
        var file = File(message.content);
        var uploadTask = _storage.ref(imagePath).putFile(file);
        var taskSnapshot = await uploadTask;
        var downloadUrl = await taskSnapshot.ref.getDownloadURL();

        // Save URL to Firestore
        batch.update(docRef, {
          "answers": FieldValue.arrayUnion([downloadUrl])
        });
      } else {
        // Save text or URL to Firestore
        batch.update(docRef, {
          "answers": FieldValue.arrayUnion([message.content])
        });
      }
    }

    await batch.commit();
  }
}

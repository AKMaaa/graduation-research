import 'package:flutter/material.dart';
import 'package:flutter_application/src/parts/top_bar.dart';
import 'package:flutter_application/src/message_model.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class AnswerListPage extends StatefulWidget {
  final List<Message> messages;

  AnswerListPage({Key? key, required this.messages}) : super(key: key);

  @override
  _AnswerListPageState createState() => _AnswerListPageState();
}

class _AnswerListPageState extends State<AnswerListPage> {
  // abs data
  List<Message> messages = [
    Message(type: MessageType.text, content: 'テキストメッセージ'),
    Message(type: MessageType.image, content: '画像のパス'),
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
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            color: Colors.grey[200],
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
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application/src/parts/ui-parts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:math';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 入力したメールアドレス・パスワード
  String _email = '';
  String _password = '';

  // ユーザー登録ボタンのonPressedメソッド
  Future<void> _registerUser() async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password);
      final User? user = userCredential.user;

      if (user != null) {

                // Firebase StorageからダウンロードURLを取得
        String imageName = 'profileImg${Random().nextInt(28) + 1}.png';
        String imageUrl = await FirebaseStorage.instance
            .ref('profile/$imageName')
            .getDownloadURL();


        // Firestoreにユーザー情報を保存
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'created_at': FieldValue.serverTimestamp(),
          'email': user.email,
          'name': 'your name',
          'profileImageURL': imageUrl,
          'uid': user.uid,
        });

        print("ユーザ登録しました ${user.email}, ${user.uid}");
        // 登録成功後の処理（例：ログイン画面に戻る）
      }
    } catch (e) {
      print(e);
      // エラー処理
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // 1行目 メールアドレス入力用テキストフィールド
              TextFormField(
                decoration: const InputDecoration(labelText: 'メールアドレス'),
                onChanged: (String value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              // 2行目 パスワード入力用テキストフィールド
              TextFormField(
                decoration: const InputDecoration(labelText: 'パスワード'),
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              // 3行目 ユーザ登録ボタン
              ElevatedButton(
                child: const Text('ユーザ登録'),
                onPressed: _registerUser,
              ),
              // 4行目 ログインボタン
              ElevatedButton(
                child: const Text('ログイン'),
                onPressed: () async {
                  try {
                    // メール/パスワードでログイン
                    final User? user = (await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: _email, password: _password))
                        .user;
                    if (user != null) {
                      print("ログインしました　${user.email} , ${user.uid}");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('ログインしました')),
                      );
                      // ログイン成功後にMyBottomNavBarに遷移
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyBottomNavBar()),
                      );
                    }
                  } catch (e) {
                    // パスワードまたはメールアドレスが間違っている場合のエラーメッセージを表示
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('パスワード、または、メールアドレスが間違っています')),
                    );
                    print(e);
                  }
                },
              ),
              // 5行目 パスワードリセット登録ボタン
              ElevatedButton(
                  child: const Text('パスワードリセット'),
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: _email);
                      print("パスワードリセット用のメールを送信しました");
                    } catch (e) {
                      print(e);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

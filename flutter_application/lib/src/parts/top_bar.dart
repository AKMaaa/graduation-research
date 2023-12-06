import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text("エラーが発生しました");
        }
        if (!snapshot.hasData) {
          return Text("ユーザーデータがありません");
        }

        var userDocument = snapshot.data;
        var profileImageUrl = userDocument?['profileImageURL'] ??
            'https://t3.ftcdn.net/jpg/05/05/44/78/360_F_505447855_pI5F0LDCyNfZ2rzNowBoBuQ9IgT3EQQ7.jpg'; // デフォルトの画像URL

        return PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight + 20.0),
          child: AppBar(
            scrolledUnderElevation: 0.0,
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Icon(Icons.menu),
            ),
            centerTitle: true,
            actions: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 25.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(profileImageUrl),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 20.0);
}

class CustomAppBarBack extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text("エラーが発生しました");
        }
        if (!snapshot.hasData) {
          return Text("ユーザーデータがありません");
        }

        var userDocument = snapshot.data;
        var profileImageUrl = userDocument?['profileImageURL'] ??
            'https://t3.ftcdn.net/jpg/05/05/44/78/360_F_505447855_pI5F0LDCyNfZ2rzNowBoBuQ9IgT3EQQ7.jpg'; // デフォルトの画像URL

        return PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight + 20.0),
          child: AppBar(
            scrolledUnderElevation: 0.0,
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop(); // 現在のページから一つ前に戻る
                },
              ),
            ),
            centerTitle: true,
            actions: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 25.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(profileImageUrl),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 20.0);
}
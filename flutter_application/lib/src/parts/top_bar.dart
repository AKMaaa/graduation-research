import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight + 20.0),
      child: Container(
        // margin: EdgeInsets.only(top: 40.0),
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
                backgroundImage: NetworkImage(
                    'https://t3.ftcdn.net/jpg/05/05/44/78/360_F_505447855_pI5F0LDCyNfZ2rzNowBoBuQ9IgT3EQQ7.jpg'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 20.0);
}

class CustomAppBarBack extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight + 20.0),
      child: Container(
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
                backgroundImage: NetworkImage(
                    'https://t3.ftcdn.net/jpg/05/05/44/78/360_F_505447855_pI5F0LDCyNfZ2rzNowBoBuQ9IgT3EQQ7.jpg'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 20.0);
}

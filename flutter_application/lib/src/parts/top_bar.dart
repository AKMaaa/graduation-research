import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight + 20.0),
      child: Padding(
        padding: EdgeInsets.only(top: 40.0),
        child: AppBar(
          leading: Icon(Icons.menu),
          backgroundColor: Colors.white,
          centerTitle: true,
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://pbs.twimg.com/profile_images/1476938674612805637/Z9-fGmey_400x400.jpg'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 20.0); // 更新された高さ
}

import 'package:flutter/material.dart';


class UserProductListItem extends StatelessWidget {

  final String title;
  final String imageUrl;

  UserProductListItem(this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {

    print("title: ${title}, url: ${imageUrl}");

    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              onPressed: () {

              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () {

              },
            ),
          ],
        ),
      ),
    );
  }
}








import 'package:flutter/material.dart';

class AppBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(Icons.library_books, color: Colors.black),
          Icon(Icons.search, color: Theme.of(context).primaryColor),
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(60),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 4,
                      blurRadius: 6,
                      offset: Offset(0, 1),
                      color: Theme.of(context).primaryColor.withOpacity(0.2))
                ]),
            child: IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
          Icon(Icons.notifications, color: Colors.black),
          Icon(Icons.message, color: Colors.black),
        ],
      ),
    );
  }
}

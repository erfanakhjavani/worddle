

import 'package:flutter/material.dart';

void ShowDialog(BuildContext context){

     showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit App'),
        content: const Text('Do you really want to exit?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // بستن دیالوگ
              Navigator.of(context).pop(); // بستن صفحه فعلی
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
}

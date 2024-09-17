import 'package:flutter/material.dart';

//! Function to display a confirmation dialog for exiting the app
void showMyDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Exit App'), //* Dialog title
      content: const Text('Do you really want to exit?'), //* Dialog content
      actions: <Widget>[
        //! "No" button to dismiss the dialog without exiting
        TextButton(
          onPressed: () => Navigator.of(context).pop(), //* Close the dialog
          child: const Text('No'),
        ),
        //! "Yes" button to close both the dialog and the current screen
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); //* Close the dialog
            Navigator.of(context).pop(); //* Close the current screen
          },
          child: const Text('Yes'),
        ),
      ],
    ),
  );
}

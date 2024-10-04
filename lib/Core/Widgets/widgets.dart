import 'package:flutter/material.dart';
import 'package:get/get.dart';

//! Function to display a confirmation dialog for exiting the app
void showMyDialog({
  required BuildContext context,
  required Function()  accept,
  Function()? cancel,
  String? title,
  String? content,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title:  Text(title ??'Exit App'.tr,
      style: Get.textTheme.headlineSmall,
      ), //* Dialog title
      content:  Text(content ??'Do you really want to exit?'.tr,
        style: Get.textTheme.bodyLarge,
      ), //* Dialog content
      actions: <Widget>[
        //! "No" button to dismiss the dialog without exiting
        TextButton(
          onPressed: (){
            Navigator.pop(context);
            cancel;
          },
          child: Text('No'.tr,
          style: Get.textTheme.bodyMedium,
          ),
        ),
        //! "Yes" button to close both the dialog and the current screen
        TextButton(
          onPressed: accept,
          child:  Text('Yes'.tr,
            style: Get.textTheme.bodyMedium,
          ),
        ),
      ],
    ),
  );
}

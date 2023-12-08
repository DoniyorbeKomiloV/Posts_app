import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<T?> customCupertinoModalPopup<T>(
  BuildContext context, {
  String title = '',
  String actionTitleOne = '',
  String actionTitleTwo = '',
  required void Function() actionOne,
  required void Function() actionTwo,
}) async =>
    showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
        title: Text(title),
        actions: [
          CupertinoActionSheetAction(
            onPressed: actionOne,
            child: Text(actionTitleOne),
          ),
          CupertinoActionSheetAction(
            onPressed: actionTwo,
            child: Text(actionTitleTwo),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );

typedef WidgetScrollBuilder = Widget Function(
  BuildContext context,
  ScrollController? controller,
);

Future<T?> customModalBottomSheet<T>({
  required BuildContext context,
  required WidgetScrollBuilder builder,
  bool isScrollControlled = false,
}) async =>
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
        minHeight: MediaQuery.of(context).size.height * 0.2,
      ),
      builder: (_) {
        if (isScrollControlled) {
          return DraggableScrollableSheet(
            initialChildSize: 1,
            minChildSize: 0.5,
            expand: false,
            snap: true,
            builder: (context, controller) => builder(context, controller),
          );
        } else {
          return builder(context, null);
        }
      },
    );

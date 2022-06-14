// 例外・エラーモーダルUI
import 'package:flutter/material.dart';

class ErrorModal extends StatelessWidget {
  const ErrorModal({
    required this.error_message,
    Key? key,
  }) : super(key: key);

  final String error_message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "エラー",
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            error_message,
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  width: 100,
                  height: 35,
                  child: TextButton(
                    style: ElevatedButton.styleFrom(
                      onPrimary: Color.fromARGB(255, 66, 140, 224),
                    ),
                    child: Text(
                      'OK',
                      style: TextStyle(fontSize: 17),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

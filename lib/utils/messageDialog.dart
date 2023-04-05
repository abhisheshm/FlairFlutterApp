import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogMessage extends StatelessWidget {
  const DialogMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Alert Message'),
          content: const Text('Something went wrong !',style: TextStyle(color: Colors.red),),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
      child: const Text('Show Dialog'),
    );
  }
}

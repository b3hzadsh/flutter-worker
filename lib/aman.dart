import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'hiveSetup.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: Hive.box('myBox').listenable() ,
              builder: (_, Box box, widget) => ListView.builder(
                itemCount: Hive.box('myBox').length,
                itemBuilder: (_, index) => Text(
                  Hive.box('myBox').get(index).toString(),
                ),
              ),
                // (
                //   valueListenable: Hive.box('myBox').listenable(),
                //    {
                //     return Text(box.get('darkMode').toString());
                //   },
                // ),
              
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Box bb = getIt<Box>();
                bb.put(bb.length + 1, DateTime.now().millisecondsSinceEpoch);
              },
              child: Text("remove all stuff"),
            ),
        ],
      ),
    );
  }
}

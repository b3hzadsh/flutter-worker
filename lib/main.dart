// import 'dart:io';
import 'aman.dart';
import 'dart:async';
import 'hiveSetup.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import 'package:hive/hive.dart' show Box, Hive;
import 'package:path_provider/path_provider.dart';


Future<Box> HiveSetup() async{
  var DirectoryN = await getApplicationDocumentsDirectory();
  Hive.init(DirectoryN.path);
  return  Hive.openBox("myBox");
}
Future<void> printHello() async{
    // setup();
    Box bb = getIt<Box>();
    bb.put(bb.length + 1, DateTime.now().millisecondsSinceEpoch);
    //   try {
    //     final result = await InternetAddress.lookup('example.com');
    //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    //         Box bb = getIt<Box>();
    //         bb.put(bb.length + 1, DateTime.now().millisecondsSinceEpoch);
    //     }
    //   } on SocketException catch (_) {
    //         Box bb = getIt<Box>();
    //         bb.put(bb.length + 1, 444);
    //   }
    // box.put(box.keys.length + 1, now.millisecondsSinceEpoch.toString());
}
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    print("Native called background task: ${DateTime.now().millisecondsSinceEpoch.toString()}"); //simpleTask will be emitted here.
    printHello();
    return Future.value(true);
  });
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   Workmanager().initialize(
    callbackDispatcher, // The top level function, aka callbackDispatcher
    isInDebugMode: true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );
  Workmanager().registerPeriodicTask("1", "simpleTask", 
    frequency: Duration(minutes: 15)
    ); //Android only (see below)
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('app_icon');
//     final InitializationSettings initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid,
//     );
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: (s){},
//     );
  await setup();
//   await Executor().warmUp(log: true);
//   Executor().execute(fun1: printHello);
//   Hive.openBox("myBox");
//   printHello(0);
//   final int helloAlarmID = 0;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsPage()));
              },
              child: Text("show the values"),
            ),
            ElevatedButton(
              onPressed: () {
                getIt<Box>().clear();
              },
              child: Text("remove all stuff"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}

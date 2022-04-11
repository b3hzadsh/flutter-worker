import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  // getIt.registerSingleton<YDirectory>(theDirectory);
  MyHive theHive= new MyHive();
  await theHive._init();
  Box myBox = await theHive.hiveOpendBox();
  getIt.registerSingleton<Box>(myBox);
}

Future<void> secondSetup() async {


}
class YDirectory {
  String? path ;

  Future _init() async {
    var DirectoryN = await getApplicationDocumentsDirectory();
    path = DirectoryN.path ;
  }
}

class MyHive {

  Future _init() async {
    YDirectory theDirectory = YDirectory();
    await theDirectory._init();
    log(theDirectory.path! + " the dir was");
    Hive.init(theDirectory.path!);
  }

  Future<Box> hiveOpendBox() async {
    await _init();
    return await Hive.openBox("myBox");
  }
}
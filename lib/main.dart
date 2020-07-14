import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
            alignment: Alignment.center,
            child: RaisedButton(
              child: Text('Click Me'),
              onPressed: () async {
                List<AssetPathEntity> albums =
                    await PhotoManager.getAssetPathList();

                // this will crash the app
                List<AssetEntity> medias = await albums[0]
                    .getAssetListRange(start: 0, end: albums[0].assetCount);
              },
            )),
      ),
    );
  }
}

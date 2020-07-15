import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var result = await PhotoManager.requestPermission();
  if (result)
    runApp(MyApp());
  else
    PhotoManager.openSetting();
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<int> _thumb;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: Scaffold(
        body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _thumb != null ? Image.memory(_thumb) : Container(),
                RaisedButton(
                  child: Text('Load Thumbnail'),
                  onPressed: () async {
                    List<AssetPathEntity> albums =
                        await PhotoManager.getAssetPathList();

                    List<AssetEntity> medias = await albums[0]
                        .getAssetListRange(start: 0, end: albums[0].assetCount);

                    // returns full size on first load
                    _thumb =
                        await medias[1].thumbDataWithSize(ThumbOption(50, 50));

                    setState(() {});
                  },
                ),
              ],
            )),
      ),
    );
  }
}

class ThumbOption extends LoadOption {
  ThumbOption(int width, int height) : super(width, height, quality: 75);
}

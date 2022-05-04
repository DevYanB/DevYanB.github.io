import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'globals.dart' as globals;
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Album 571',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePageState(),
    );
  }
}

enum ImageSourceType { gallery, camera }

var photoList = [];

class HomePageState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePage();
  }
}

class HomePage extends State<HomePageState> with WidgetsBindingObserver {
  // Tap to enter picking image view
  void getPhoto(BuildContext context, var type) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ImageFromGalleryEx(type)),
    ).then((value) => setState(() {}));
  }

  // Tap to enter full screen image view
  void fullScreenImage(BuildContext context, var path) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => FullScreenState(path)));
  }

  @override
  Widget build(BuildContext context) {
    //Grid view
    Widget gridSection = GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      padding: const EdgeInsets.all(10),
      children: <Widget>[
        for (var imagePath in photoList)
          GestureDetector(
            onTap: () {
              fullScreenImage(context, imagePath);
            },
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(10.0), //add border radius here
              clipBehavior: Clip.hardEdge,
              child: Image.file(
                File(imagePath),
                fit: BoxFit.cover,
              ), //add image location here
            ),
          ),
      ], //from edge only
      // children: [
      //   // iterate through all the image paths saved in photoList
      //   // for each path - set up fullScreenImage display, and a 'child' ClipRRect widget that
      //   // will hold as ITS child, an Image (given its path)
      //   // ...
      // ],
    );

    // Our two buttons - one for gallery imgs, one for camera...
    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MaterialButton(
          color: Colors.blue,
          child: const Text(
            "Add from Gallery",
            style:
                TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            getPhoto(context, ImageSourceType.gallery);
          },
        ),

        // ADD the button for camera capture, similar to the above [use the 'enum'!]
        // ...
        MaterialButton(
          color: Colors.blue,
          child: const Text(
            "Add from Camera",
            style:
                TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            getPhoto(context, ImageSourceType.camera);
          },
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Album 571"),
      ),
      body: Stack(
        children: [
          gridSection,
          Column(children: [const Spacer(), buttonSection])
        ],
      ),
    );
  }
}

// full screen image showing: two classes
class FullScreenState extends StatefulWidget {
  final path;
  FullScreenState(this.path);
  @override
  FullScreenImg createState() => FullScreenImg(this.path);
}

class FullScreenImg extends State<FullScreenState> {
  var path;
  var img;
  var width;
  var height;

  FullScreenImg(this.path);

  @override
  void initState() {
    super.initState();
    img = Image(image: FileImage(File(path)));
    // get image width and height
    img.image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo info, bool _) {
          width = info.image.width;
          height = info.image.height;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Full screen image")),
        body: Stack(
          // alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            Image.file(
              File(path),
              // fit: BoxFit.scaleDown,
            ),
            Column(
              children: [
                const Spacer(),
                const Text(
                  "Image width:",
                  style: TextStyle(color: Colors.red),
                ),
                Text(
                  width.toString(),
                  style: TextStyle(color: Colors.red),
                ),
                const Text(
                  "Image height",
                  style: TextStyle(color: Colors.red),
                ),
                Text(
                  height.toString(),
                  style: TextStyle(color: Colors.red),
                )
              ],
            ),
          ],
        ));
  }
}

// These two classes are from: https://blog.logrocket.com/building-an-image-picker-in-flutter/
class ImageFromGalleryEx extends StatefulWidget {
  final type;
  ImageFromGalleryEx(this.type);

  @override
  ImageFromGalleryExState createState() => ImageFromGalleryExState(this.type);
}

class ImageFromGalleryExState extends State<ImageFromGalleryEx> {
  var _image;
  var imagePicker;
  var type;

  ImageFromGalleryExState(this.type);

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(type == ImageSourceType.camera
              ? "Image from Camera"
              : "Image from Gallery")),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 52,
          ),
          Center(
            child: GestureDetector(
              onTap: () async {
                var source = type == ImageSourceType.camera
                    ? ImageSource.camera
                    : ImageSource.gallery;
                XFile image = await imagePicker.pickImage(
                    source: source,
                    imageQuality: 50,
                    preferredCameraDevice: CameraDevice.front);

                Directory appDocumentsDirectory =
                    await getApplicationDocumentsDirectory();
                // correct path to save file for this app
                String prePath = appDocumentsDirectory.path;
                var rand = Random();
                // random int as the photo name
                String randomInt = rand.nextInt(99999999).toString();
                String newPath = "$prePath/$randomInt.jpg";
                File oldImage = File(image.path);
                // copy the image from cache to a safe place
                final File newImage = await oldImage.copy(newPath);

                setState(() {
                  _image = newImage;
                  // save the path to a global variable
                  // then the root view can update the grid list
                  photoList.add(newImage.path);
                });
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(color: Colors.red[200]),
                child: _image != null
                    ? Image.file(
                        _image,
                        width: 200.0,
                        height: 200.0,
                        fit: BoxFit.fitHeight,
                      )
                    : Container(
                        decoration: BoxDecoration(color: Colors.red[200]),
                        width: 200,
                        height: 200,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../util/utils.dart';
import 'DisplayPictureScreen.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize().then((value) {
      if(!mounted) {
        return;
      }
      setState(() {

      });
    });
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: Stack(
        children: [
          // Container(height: MediaQuery.of(context).size.height,
          // color: Colors.red,),
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the Future is complete, display the preview.
                return CameraPreview(_controller);
              } else {
                // Otherwise, display a loading indicator.
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Image.asset(
            "assets/images/Subtract.png",
            fit: BoxFit.cover,
            // color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.60,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Text(
                    "Hold your phone at eye level so that your selfie is similar to your ID proof",
                    style: TextStyle(
                        color: DefaultColor.appBarWhite, fontSize: 16)),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/Right icon.png",
                      // color: Colors.black45,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text("Look at the camera",
                        style: TextStyle(
                            color: DefaultColor.appBarWhite, fontSize: 16)),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/Right icon.png",
                      // color: Colors.black45,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text("Avoid multiple faces around you",
                        style: TextStyle(
                            color: DefaultColor.appBarWhite, fontSize: 16)),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/Right icon.png",
                      // color: Colors.black45,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text("Avoid textured background",
                        style: TextStyle(
                            color: DefaultColor.appBarWhite, fontSize: 16)),
                  ],
                ),
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        // Ensure that the camera is initialized.
                        await _initializeControllerFuture;

                        // Attempt to take a picture and get the file `image`
                        // where it was saved.
                        final image = await _controller.takePicture();

                        // If the picture was taken, display it on a new screen.
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DisplayPictureScreen(
                              // Pass the automatically generated path to
                              // the DisplayPictureScreen widget.
                              imagePath: image.path,
                            ),
                          ),
                        );
                      } catch (e) {
                        // If an error occurs, log the error to the console.
                        print(e);
                      }
                    },
                    child: Text(
                      "Click",
                      style: TextStyle(color: DefaultColor.appBarWhite,
                      fontSize: 16),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.symmetric(vertical: 15)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          DefaultColor.blueDark),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}


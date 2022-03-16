import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gmoney/bloc/consumer_home.dart';
import 'package:gmoney/util/utils.dart';
import 'package:image_picker/image_picker.dart';

class BottomSheetPicker extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();
  String _paths = '';
  final int place;
  bool showFile = true;

  BottomSheetPicker({required this.place, required this.showFile});

  Widget _row(String text, var _icon) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 22, 8, 8),
      child: Row(
        children: [
          Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xFFEBEBEB)),
              child: Icon(
                _icon,
                color: DefaultColor.appDarkBlue,
                size: 22,
              )),
          SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AadhaarColors.textGrey),
          )
        ],
      ),
    );
  }

  void _cameraPicker(BuildContext context) async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    _paths = photo!.path;
    if (_paths.length < 2) {
      Utils.instance.showToast("Pick Back image", isBottom: false);
      _cameraPicker(context);
      return;
    } else {
      print("lolsss");
    }
    if (place == 0)
      consumerHome.updateImgPath.add(_paths);
    else if (place == 1)
      consumerHome.updateImgPathBack.add(_paths);
    else
      consumerHome.updateImgPathCurrent.add(_paths);
    Navigator.pop(context);
  }

  void _galleryPicker(BuildContext context) async {
    List<XFile>? photos = await _picker.pickMultiImage();
    if (photos != null && photos.isNotEmpty)
      (photos.forEach((element) {
        _paths = element.path;
      }));
    print(_paths);
    if (place == 0)
      consumerHome.updateImgPath.add(_paths);
    else if (place == 1)
      consumerHome.updateImgPathBack.add(_paths);
    else
      consumerHome.updateImgPathCurrent.add(_paths);    Navigator.pop(context);
  }

  void pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
      ],
    );
    _paths = result!.paths.first!;
    if (place == 0)
      consumerHome.updateImgPath.add(_paths);
    else if (place == 1)
      consumerHome.updateImgPathBack.add(_paths);
    else
      consumerHome.updateImgPathCurrent.add(_paths);    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(right: 12, left: 12),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Container(
        height: showFile == false ? 150 : 200,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Upload a file",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () {
                      _cameraPicker(context);
                    },
                    child: _row("Camera", Icons.camera_alt)),
                SizedBox(
                  width: 60,
                ),
                GestureDetector(
                    onTap: () => _galleryPicker(context),
                    child: _row("Gallery", Icons.photo_album)),
              ],
            ),
            showFile == false ? SizedBox(height: 0, width: 0,) :
            GestureDetector(
                onTap: () => pickFile(context),
                child: _row("File", Icons.folder))
          ],
        ),
      ),
    );
  }
}

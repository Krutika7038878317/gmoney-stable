

import 'package:easy_localization/src/public_ext.dart';

class SliderModel{

  String? imageAssetPath;
  String? title;
  String? tutorialTitle;
  String? desc;
  String? header;

  SliderModel({this.imageAssetPath,this.title,this.desc,this.header});

  void setImageAssetPath(String getImageAssetPath){
    imageAssetPath = getImageAssetPath;
  }
  void setTutorialTitle(String getTutorialTitle){
    tutorialTitle = getTutorialTitle;
  }

  String? getTutorialTitle(){
    return tutorialTitle;
  }

  void setHeader(String getHeader){
    header = getHeader;
  }

  String? getHeader(){
    return header;
  }

  void setTitle(String getTitle){
    title = getTitle;
  }

  void setDesc(String getDesc){
    desc = getDesc;
  }

  String? getImageAssetPath(){
    return imageAssetPath;
  }

  String? getTitle(){
    return title;
  }

  String? getDesc(){
    return desc;
  }

}


List<SliderModel> getSlides(){

  // List<SliderModel> slides = new List<SliderModel>();
  List<SliderModel> slides = <SliderModel>[];
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setTutorialTitle("");
  sliderModel.setDesc("");
  sliderModel.setTitle('tutorialScreens.one'.tr());
  sliderModel.setImageAssetPath('assets/images/Illustration.png');
  sliderModel.setHeader("");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setTutorialTitle("");
  sliderModel.setDesc("");
  sliderModel.setTitle("tutorialScreens.two".tr());
  sliderModel.setImageAssetPath('assets/images/pana.png');
  sliderModel.setHeader("");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setTutorialTitle("");
  sliderModel.setDesc("");
  sliderModel.setTitle("tutorialScreens.three".tr());
  sliderModel.setImageAssetPath('assets/images/pana.png');
  sliderModel.setHeader("");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}
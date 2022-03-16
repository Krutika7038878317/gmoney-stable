import 'package:gmoney/api/bloc_provider.dart';
import 'package:gmoney/api/web_service_client.dart';
import 'package:gmoney/models/consumer_home_model.dart';
import 'package:gmoney/models/faq_res_model.dart';
import 'package:gmoney/models/mandate_url_res.dart';
import 'package:gmoney/util/utils.dart';
import 'package:rxdart/rxdart.dart';




class ConsumerHome extends BlocBase{

  var _homeDataCont = BehaviorSubject<ConsumerHomeModel>();
  Stream<ConsumerHomeModel> get homeData => _homeDataCont.stream;
  Sink<ConsumerHomeModel> get updateHomeData => _homeDataCont.sink;

  var _imgPath = BehaviorSubject<String?>();
  Stream<String?> get getImgPath => _imgPath.stream;
  Sink<String?> get updateImgPath => _imgPath.sink;

  var _imgPathBack = BehaviorSubject<String?>();
  Stream<String?> get getImgPathBack => _imgPathBack.stream;
  Sink<String?> get updateImgPathBack => _imgPathBack.sink;

  var _imgPathCurrent = BehaviorSubject<String?>();
  Stream<String?> get getImgPathCurrent => _imgPathCurrent.stream;
  Sink<String?> get updateImgPathCurrent => _imgPathCurrent.sink;

  var _faqToggle = BehaviorSubject<bool>();
  Stream<bool> get getFaqToggle => _faqToggle.stream;
  Sink<bool> get updateFaqToggle => _faqToggle.sink;

  var _tcHtml = BehaviorSubject<String?>();
  Stream<String?> get getTCHtmlStream => _tcHtml.stream;
  Sink<String?> get getTCHtmlSink => _tcHtml.sink;

  var _faqRes = BehaviorSubject<FaqRes>();
  Stream<FaqRes> get getFaqRseStream => _faqRes.stream;
  Sink<FaqRes> get getFaqRseSink => _faqRes.sink;

  ConsumerHome(){
    getConsumerHomeData();
  }

  int getCount(List<CardActiveChecks> _data){
    var count = -1;
    for(int i=0;i<5;i++){
      if(_data[i].uploaded == true){
        count++;
      }
    }
    return count;
  }

  Future getConsumerHomeData() async {
    return WebServiceClient.consumerHomeData({}).then((response) async {
      if (response is WebError) {
        switch (response) {
          case WebError.INTERNAL_SERVER_ERROR:
            {
              Utils.showErrorMessage(
                  "Unable to reach server. Please check connection.");
              break;
            }
          case WebError.ALREADY_EXIST:
            {
              Utils.showErrorMessage(
                  "This email or phone number is already registered.");
              break;
            }
          case WebError.NOT_FOUND:
            {
              Utils.showErrorMessage(
                  "This email or phone number is already registered.");
              break;
            }
          default:
            Utils.showErrorMessage(
                "Something went unexpectedly wrong. Please try again later");
            break;
        }
        return false;
      } else {
        var parsedResponse = ConsumerHomeModel.fromJson(response);
        updateHomeData.add(parsedResponse);
        return true;
      }
    }).catchError((e) {
      Utils.showErrorMessage("Error. Please try again");
    });
  }

  Future getTCHtmlData() async {
    return WebServiceClient.getTCService(Map<String, dynamic>()).then((response) async {
      if (response is WebError) {
        switch (response) {
          case WebError.INTERNAL_SERVER_ERROR:
            {
              Utils.showErrorMessage(
                  "Unable to reach server. Please check connection.");
              break;
            }
          case WebError.ALREADY_EXIST:
            {
              Utils.showErrorMessage(
                  "This email or phone number is already registered.");
              break;
            }
          case WebError.NOT_FOUND:
            {
              Utils.showErrorMessage(
                  "This email or phone number is already registered.");
              break;
            }
          default:
            Utils.showErrorMessage(
                "Something went unexpectedly wrong. Please try again later");
            break;
        }
        return false;
      } else {
        var parsedResponse = MandateUrlRes.fromJson(response);
        getTCHtmlSink.add(parsedResponse.data!);
        return true;
      }
    }).catchError((e) {
      Utils.showErrorMessage("Error. Please try again");
    });
  }
  Future getFaqData() async {
    return WebServiceClient.getFaqService(Map<String, dynamic>()).then((response) async {
      if (response is WebError) {
        switch (response) {
          case WebError.INTERNAL_SERVER_ERROR:
            {
              Utils.showErrorMessage(
                  "Unable to reach server. Please check connection.");
              break;
            }
          case WebError.ALREADY_EXIST:
            {
              Utils.showErrorMessage(
                  "This email or phone number is already registered.");
              break;
            }
          case WebError.NOT_FOUND:
            {
              Utils.showErrorMessage(
                  "This email or phone number is already registered.");
              break;
            }
          default:
            Utils.showErrorMessage(
                "Something went unexpectedly wrong. Please try again later");
            break;
        }
        return false;
      } else {
        var parsedResponse = FaqRes.fromJson(response);
        getFaqRseSink.add(parsedResponse);
        return true;
      }
    }).catchError((e) {
      Utils.showErrorMessage("Error. Please try again");
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _homeDataCont.close();
    _imgPath.close();
    _imgPathBack.close();
    _imgPathCurrent.close();
    _faqToggle.close();
    _tcHtml.close();
    _faqRes.close();
  }


}

ConsumerHome consumerHome = new ConsumerHome();
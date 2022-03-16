import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gmoney/bloc/bank_details_bloc.dart';
import 'package:gmoney/models/ifsc_res-model.dart';
import 'package:gmoney/util/utils.dart';
import 'package:screen_loader/screen_loader.dart';

class BankDetailsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BankDetailState();
  }
}

class BankDetailState extends State<BankDetailsScreen> with ScreenLoader {
  var textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int? _val = 0;
  bool? _ifscVerified = false;

  var textControllerIfsc = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    textController.dispose();
    textControllerIfsc.dispose();
    super.dispose();
  }

  @override
  Widget screen(BuildContext context) {
    // TODO: implement screen
    return Scaffold(
      backgroundColor: DefaultColor.lightGrey,
      body: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height / 4,
              decoration: new BoxDecoration(
                  color: DefaultColor.lightGrey,
                  gradient: new LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [DefaultColor.blueDark, DefaultColor.blueLightGradient],
                  ))),
          ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 12,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: DefaultColor.appBarWhite,
                          )),
                      Text(
                        "Complete your KYC",
                        style: TextStyle(
                            color: DefaultColor.appBarWhite,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  color: DefaultColor.appBarWhite,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 15, right: 15),
                        child: Text(
                          "Bank Details",
                          style: TextStyle(
                              color: DefaultColor.blueDarkLogin,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: Text(
                            "Let us know in which Bank Account you will like to receive funds",
                            style: TextStyle(
                                color: DefaultColor.blackSubText,
                                fontSize: 16)),
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6,vertical: 5),
                                      child: TextFormField(
                                          controller: textController,
                                          keyboardType: TextInputType.phone,
                                          style: TextStyle(fontSize: 16),
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(
                                                20),
                                          ],
                                          validator: (val) {
                                            if (val == null ||
                                                val.isEmpty ||
                                                val.length < 12||val.length>20) {
                                              return "Please enter valid bank account no.";
                                            }
                                            return null;
                                          },
                                          onChanged: (text) {
                                            _formKey.currentState!.validate();
                                          },
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 15),
                                            isDense: true,
                                            labelText: "Bank Account Number",

                                            labelStyle: TextStyle(
                                                color: DefaultColor.grey),
                                            border: InputBorder.none,
                                          )),
                                    ),
                                  ],
                                ),
                                margin: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: DefaultColor.blueMobile),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6,vertical: 5),
                                      child: TextFormField(
                                          controller: textControllerIfsc,
                                          keyboardType: TextInputType.text,
                                          style: TextStyle(fontSize: 16),
                                          textCapitalization:
                                              TextCapitalization.characters,
                                          validator: (val) {
                                            if (val == null ||
                                                val.isEmpty ||
                                                val.length < 11) {
                                              return "Please enter 11 digit IFSC code";
                                            }
                                            if (!_ifscVerified!) {
                                              return "Please enter valid 11 digit IFSC code";
                                            }
                                            return "";
                                          },
                                          textInputAction: TextInputAction.done,
                                          onChanged: (ifscText) {
                                            print(ifscText);
                                            _formKey.currentState!.validate();
                                            if (ifscText.length > 10 &&
                                                ifscText.length == 11) {
                                              SystemChannels.textInput
                                                  .invokeMethod(
                                                      'TextInput.hide');
                                              startLoading();
                                              bankDetailsBloc.getIfscDetails(
                                                  Map(),
                                                  ifscText.toUpperCase());
                                              stopLoading();
                                            }
                                          },
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .singleLineFormatter,
                                            LengthLimitingTextInputFormatter(
                                                11),
                                          ],
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 15),
                                            isDense: true,
                                            labelText: "IFSC Code",
                                            labelStyle: TextStyle(
                                                color: DefaultColor.grey),
                                            border: InputBorder.none,
                                          )),
                                    ),
                                  ],
                                ),
                                margin: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: DefaultColor.blueMobile),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 15),
                        child: Text(
                          "Select Account Type",
                          style: TextStyle(
                              color: DefaultColor.blackSubText,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 15),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: const Text('Savings',style: TextStyle(fontSize: 14),),
                                  leading: Radio<int?>(
                                    value: 0,
                                    groupValue: _val,
                                    activeColor: DefaultColor.blueDark,
                                    onChanged: (int? value) {
                                      setState(() {
                                        _val = value;
                                        print(_val);
                                      });
                                     },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: const Text('Current',style: TextStyle(fontSize: 14),),
                                  leading: Radio<int?>(
                                    value: 1,
                                    groupValue: _val,
                                    activeColor: DefaultColor.blueDark,
                                    onChanged: (int? value) {
                                      setState(() {
                                        _val = value;
                                        print(_val);
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      StreamBuilder<IfscRes>(
                          stream: bankDetailsBloc.ifscDataStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              _ifscVerified = snapshot.data?.status;
                            }
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (textController.text.isNotEmpty &&
                                      textController.text.length <= 20 &&
                                      textControllerIfsc.text.isNotEmpty &&
                                      textControllerIfsc.text.length == 11) {
                                    if (_ifscVerified!) {
                                      print("yess");
                                      var data = {
                                        "bank_account": textController.text,
                                        "bank_ifsc": textControllerIfsc.text,
                                        "account_type":
                                            _val == 0 ? "saving" : "current",
                                        "mandate_type":
                                            snapshot.data?.bank?.netBanking ==
                                                    true
                                                ? "netbanking"
                                                : "debitcard"
                                      };
                                      startLoading();
                                      bankDetailsBloc.addBankDetails(data).then((value) {
                                        if(value.status){
                                          Utils.instance.showToast("Bank details uploaded successfully");
                                          Navigator.of(context).pushNamedAndRemoveUntil(
                                               '/EMandate',
                                                  (Route<dynamic> route) => false);
                                        }
                                      });
                                      stopLoading();
                                      print(data);
                                    } else {
                                      _formKey.currentState!.validate();
                                      print("not yet");
                                    }
                                  } else {
                                    print("not yet val");
                                    print(_formKey.currentState!.validate());
                                  }
                                },
                                child: Text(
                                  "Send me ₹1",
                                  style: TextStyle(
                                      color: _ifscVerified!
                                          ? DefaultColor.appBarWhite
                                          : DefaultColor.grey),
                                ),
                                style: ButtonStyle(
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 0)),
                                  minimumSize: MaterialStateProperty.all<Size>(
                                      const Size(double.infinity, 50)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          _ifscVerified!
                                              ? DefaultColor.blueDark
                                              : DefaultColor.greyButtonColor),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  )),
                                ),
                              ),
                            );
                          })
                    ],
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

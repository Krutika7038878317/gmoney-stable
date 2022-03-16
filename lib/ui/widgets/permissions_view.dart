import 'package:flutter/material.dart';
import 'package:gmoney/util/utils.dart';

class PermissionsView extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final String? subTitle;

  const PermissionsView({Key? key, this.icon, this.title, this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: MediaQuery.of(context).size.height / 8,
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: 50,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: new BoxDecoration(
                color: DefaultColor.lightGrey,
                shape: BoxShape.circle,
                gradient: new LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    DefaultColor.redLight.withOpacity(0.1),
                    DefaultColor.blueDark.withOpacity(0.1)
                  ],
                )),
            child: Icon(
              icon,
              color: DefaultColor.blueDark,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    title!,
                    style: TextStyle(
                        color: DefaultColor.blueDark,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      subTitle!,
                      style: TextStyle(
                          color: DefaultColor.blackSubText, fontSize: 14),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

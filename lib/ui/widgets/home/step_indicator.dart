import 'package:flutter/material.dart';
import 'package:status_stepper/status_stepper.dart';



class StepIndicator extends StatelessWidget {
  final int? STEPS;
  final int? completedCounts;
  const StepIndicator(Key? key, this.STEPS,this.completedCounts) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statuses = List.generate(
      STEPS??0,
          (index) => SizedBox.square(
        dimension: 24,
        child: Center(child: Text('${index+1}', style: TextStyle(color: Colors.white),)),
      ),
    );
    int curIndex = completedCounts??-1;
    int lastIndex = -1;
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
        child: StatusStepper(
          connectorCurve: Curves.easeIn,

          itemCurve: Curves.easeOut,
          activeColor: Colors.green,
          disabledColor: Colors.grey,
          animationDuration: const Duration(milliseconds: 500),
          children: statuses,
          lastActiveIndex: lastIndex,
          currentIndex: curIndex,
          connectorThickness: 3,
        ),
      ),
    );
  }
}

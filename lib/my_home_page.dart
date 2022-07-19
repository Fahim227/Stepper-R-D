import 'package:flutter/material.dart';
import 'package:stepper/stepper.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _activeStep = 0;
  Color active = Colors.yellow;
  Color finished = Colors.green;
  Color remain = Colors.red;
  List<Icon> allIcons = [
    Icon(Icons.supervised_user_circle),
    Icon(Icons.flag),
    Icon(Icons.access_alarm),
    Icon(Icons.supervised_user_circle),
    Icon(Icons.flag),
    Icon(Icons.access_alarm),
    Icon(Icons.supervised_user_circle),
  ];

  static Map<String,int> completedTasks = {};


  int? upperBound;

  @override
  void initState(){
    super.initState();
    upperBound = allIcons.length-1;
    for (int i = 0 ;i<allIcons.length;i++){
      completedTasks[i.toString()] = 0;

    }
  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Stepper Test"),),
        body: Column(
          children: [
            IconStepper(
              isCompleted: ifComplete,
              completedTasks: completedTasks,
              completedStepColor: finished,
              activeStepBorderColor: active,
              activeStepColor: active,
              stepColor: remain,
              icons: allIcons ,
              activeStep: _activeStep,
              onStepReached: (index){
                setState((){
                  _activeStep = index;
                });
              }
            ),
            header(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                previousButton(),
                nextButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // if complete then call this method and make the corresponding stepper icon 1 in completeTask Map
  void ifComplete(int i){
    setState((){
      completedTasks[i.toString()] = 1;
    });
  }

  /// Returns the next button.
  Widget nextButton() {
    return ElevatedButton(
      onPressed: () {
        // if completed then..
        ifComplete(_activeStep);
        // Increment activeStep, when the next button is tapped. However, check for upper bound.
        if (_activeStep < upperBound!) {
          setState(() {
            _activeStep++;
          });
        }
      },
      child: Text('Next'),
    );
  }

  /// Returns the previous button.
  Widget previousButton() {
    return ElevatedButton(
      onPressed: () {
        // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
        if (_activeStep > 0) {
          setState(() {
            _activeStep--;
          });
        }
      },
      child: Text('Prev'),
    );
  }


  /// Returns the header wrapping the header text.
  Widget header() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              headerText(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Returns the header text based on the activeStep.
  String headerText() {
    switch (_activeStep) {
      case 1:
        return 'Preface';

      case 2:
        return 'Table of Contents';

      case 3:
        return 'About the Author';

      case 4:
        return 'Publisher Information';

      case 5:
        return 'Reviews';

      case 6:
        return 'Chapters #1';

      default:
        return 'Introduction';
    }
  }
}



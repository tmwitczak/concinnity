import 'package:flutter/material.dart';
import 'package:inconcinnity/metronome.dart';

class HomeTab extends StatefulWidget {
  @override
  HomeTabState createState() => HomeTabState();
}

class HomeTabState extends State<HomeTab> {
//  // init the step to 0th position
//  int current_step = 0;
//  List<Step> my_steps = [
//    Step(
//        // Title of the Step
//        title: Text("Paul Gilbert Alternate Picking"),
//        subtitle: Text("Alternate picking | Legato"),
//        // Content, it can be any widget here. Using basic Text for this example
//        content: MetronomeWidget(),
//        isActive: true),
//    Step(
//        // Title of the Step
//        title: Text("Paul Gilbert Alternate Picking"),
//        // Content, it can be any widget here. Using basic Text for this example
//        content: Text("Hello!"),
//        isActive: true),
//    Step(
//        // Title of the Step
//        title: Text("Paul Gilbert Alternate Picking"),
//        // Content, it can be any widget here. Using basic Text for this example
//        content: Text("Hello!"),
//        isActive: true),
//    Step(
//        // Title of the Step
//        title: Text("Paul Gilbert Alternate Picking"),
//        // Content, it can be any widget here. Using basic Text for this example
//        content: Text("Hello!"),
//        isActive: true),
//    Step(
//        // Title of the Step
//        title: Text("Paul Gilbert Alternate Picking"),
//        // Content, it can be any widget here. Using basic Text for this example
//        content: Text("Hello!"),
//        isActive: true),
//    Step(
//        title: Text("Step 2"),
//        content: Text("World!"),
//        // You can change the style of the step icon i.e number, editing, etc.
//        state: StepState.complete,
//        isActive: false),
//    Step(
//        title: Text("Step 2"),
//        content: Text("World!"),
//        // You can change the style of the step icon i.e number, editing, etc.
//        state: StepState.complete,
//        isActive: false),
//    Step(
//        title: Text("Step 2"),
//        content: Text("World!"),
//        // You can change the style of the step icon i.e number, editing, etc.
//        state: StepState.complete,
//        isActive: false),
//    Step(
//        title: Text("Step 2"),
//        content: Text("World!"),
//        // You can change the style of the step icon i.e number, editing, etc.
//        state: StepState.complete,
//        isActive: false),
//    Step(
//        title: Text("Step 2"),
//        content: Text("World!"),
//        // You can change the style of the step icon i.e number, editing, etc.
//        state: StepState.complete,
//        isActive: false),
//    Step(
//        title: Text("Step 2"),
//        content: Text("World!"),
//        // You can change the style of the step icon i.e number, editing, etc.
//        state: StepState.complete,
//        isActive: false),
//    Step(title: Text("Step 3"), content: Text("Hello World!"), isActive: true),
//  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stepper(
        // Using a variable here for handling the currentStep
        currentStep: this.current_step,
        // List the steps you would like to have
        steps: my_steps,
        // Define the type of Stepper style
        // StepperType.horizontal :  Horizontal Style
        // StepperType.vertical   :  Vertical Style
        type: StepperType.vertical,
        // Know the step that is tapped
        onStepTapped: (step) {
          // On hitting step itself, change the state and jump to that step
          setState(() {
            // update the variable handling the current step value
            // jump to the tapped step
            current_step = step;
          });
          // Log function call
          print("onStepTapped : " + step.toString());
        },
        onStepCancel: () {
          // On hitting cancel button, change the state
          setState(() {
            // update the variable handling the current step value
            // going back one step i.e subtracting 1, until its 0
            if (current_step > 0) {
              current_step = current_step - 1;
            } else {
              current_step = 0;
            }
          });
          // Log function call
          print("onStepCancel : " + current_step.toString());
        },
        controlsBuilder: (BuildContext context,
            {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
          return Row(
            children: <Widget>[
              Container(
                child: null,
              ),
              Container(
                child: null,
              ),
            ],
          );
        },
        // On hitting continue button, change the state
        onStepContinue: () {
          setState(() {
            // update the variable handling the current step value
            // going back one step i.e adding 1, until its the length of the step
            if (current_step < my_steps.length - 1) {
              current_step = current_step + 1;
            } else {
              current_step = 0;
            }
          });
          // Log function call
          print("onStepContinue : " + current_step.toString());
        },
      )),
    );
  }
}

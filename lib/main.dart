import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var wtcontroller = TextEditingController();
  var ftcontroller = TextEditingController();
  var incontroller = TextEditingController();

  var bgColor = Colors.grey;

  var result="Fill all values for BMI calculation";

  double bmi=0;

  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text(
            "BMI Calculator",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 25),
          )),
          backgroundColor: Colors.blueGrey,
        ),
        body: Container(
          color: Colors.black87,
          child: Center(
            child: SingleChildScrollView(
              child: SizedBox(
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    const SizedBox(
                      height: 30,
                    ),

                    TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: wtcontroller,
                      decoration: const InputDecoration(
                        label: Text("Enter your weight (in Kgs)", style: TextStyle(color: Colors.white),),
                        prefixIcon: Icon(Icons.monitor_weight_outlined,color: Colors.white,),
                      ),
                      keyboardType: TextInputType.number,
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: ftcontroller,
                      decoration: const InputDecoration(
                        label: Text("Enter height (in feet's)", style: TextStyle(color: Colors.white),),
                        prefixIcon: Icon(Icons.accessibility_new,color: Colors.white,),
                      ),
                      keyboardType: TextInputType.number,
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: incontroller,
                      decoration: const InputDecoration(
                        label: Text("Enter height (in inches)", style: TextStyle(color: Colors.white),),
                        prefixIcon: Icon(Icons.height,color: Colors.white,),
                      ),
                      keyboardType: TextInputType.number,
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    ElevatedButton(onPressed: (){

                      var wt = wtcontroller.text.toString();
                      var ft = ftcontroller.text.toString();
                      var inches = incontroller.text.toString();

                      if(wt != "" && ft != "" && inches != ""){
                        //code for bmi
                        var iwt = int.parse(wt);
                        var ift = int.parse(ft);
                        var iInches = int.parse(inches);

                        var tInches = (ift*12) + iInches;

                        var tCm = tInches*2.54;

                        var tM = tCm/100;

                        bmi = iwt/(tM*tM);

                        var msg="";

                        if(bmi>25){
                          msg="You are overweight.";
                        }
                        else if(bmi<18){
                          msg="You are underweight.";
                        }
                        else{
                          msg="You are Healthy.";
                        }

                        setState(() {
                          result = "$msg \n BMI is : ${bmi.toStringAsFixed(3)}";
                        });


                      }
                      else{
                        bmi=0;
                        setState(() {
                          result = "Please enter all values";
                        });
                      }

                    },style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,),
                      child: const Text("Calculate", style: TextStyle(color: Colors.white),),
                    ),

                    const SizedBox(height: 20,),

                    SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                          axisLabelStyle: const GaugeTextStyle(color: Colors.white),
                          startAngle: 180,
                          endAngle: 0,
                          minorTickStyle: const MinorTickStyle(color: Colors.white),
                          majorTickStyle: const MajorTickStyle(color: Colors.white),
                          // onLabelCreated: GaugeTextStyle(color: Colors.white),
                          minimum: 0.000,
                          maximum: 45.000,
                          interval: 5.000,
                          ranges: <GaugeRange>[
                            GaugeRange(startValue: 0, endValue: 18.4,color: Colors.blue,),
                            GaugeRange(startValue: 18.5, endValue: 24.9,color: Colors.green,),
                            GaugeRange(startValue: 25, endValue: 30,color: Colors.orange,),
                            GaugeRange(startValue: 30, endValue: 45,color: Colors.red,),
                          ],
                          pointers: <GaugePointer>[
                            NeedlePointer(
                              needleColor: Colors.blueGrey,
                              value: bmi,
                              enableAnimation: true,
                              knobStyle: const KnobStyle(color: Colors.blueGrey),
                            )
                          ],
                          annotations: [
                            GaugeAnnotation(angle:90 ,positionFactor: 0.5,widget:Text(result, style: const TextStyle(fontSize: 20,fontWeight: FontWeight.normal,color: Colors.white),),
                            )
                          ],
                        )
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

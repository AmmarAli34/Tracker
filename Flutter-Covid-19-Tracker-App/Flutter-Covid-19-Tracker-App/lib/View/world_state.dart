import 'package:covid_tracker/Model/WorldStatesModel.dart';
import 'package:covid_tracker/View/country_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Servies/states.dart';
class worldstate extends StatefulWidget {
  const worldstate({Key? key}):super(key: key);

  @override
  State<worldstate> createState() => _worldstateState();
}

class _worldstateState extends State<worldstate> with TickerProviderStateMixin{


  late final AnimationController _controller =AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  final colorlist=<Color>[
    Color(0xff4285F4),
    Color(0xff1aa268),
    Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    states statessarvices = states();
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .01,),
                FutureBuilder(
                    future: statessarvices.facthWorldStates(),
                    builder: (context,AsyncSnapshot<WorldStatesModel>snapshot){

                      if(!snapshot.hasData){
                          return Expanded(
                            flex: 1,
                              child: SpinKitFadingCircle(
                                color: Colors.white,
                                size: 50.0,
                                controller: _controller,

                              )

                          );

                      }else{
                           return Column(
                               children: [
                                 SizedBox(height:MediaQuery.of(context).size.height * .01,),
                                 Container(
                                   height: 100,

                                   child: PieChart(
                                       dataMap: {
                                         "Total":double.parse(snapshot.data!.cases.toString()),
                                         "Recoverd":double.parse(snapshot.data!.recovered.toString()),
                                         "Deaths":double.parse(snapshot.data!.deaths.toString()),
                                       },
                                     chartValuesOptions: ChartValuesOptions(
                                       showChartValuesInPercentage: true
                                     ),
                                       animationDuration: Duration(microseconds: 1200),
                                       chartRadius: MediaQuery.of(context).size.width /3.2,
                                       legendOptions: LegendOptions(
                                         legendPosition: LegendPosition.left,
                                       ),
                                       chartType: ChartType.ring,
                                       colorList: colorlist,
                                     ),
                                 ),
                                 Padding(
                                   padding:EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .01,),
                                   child: Card(
                                     child: Column(
                                         children: [
                                           reuseablerow(title: 'Total',value: snapshot.data!.cases.toString(),),
                                           reuseablerow(title: 'Recoverd',value: snapshot.data!.recovered.toString(),),
                                           reuseablerow(title: 'Deaths',value: snapshot.data!.deaths.toString(),),
                                           reuseablerow(title: 'Active',value: snapshot.data!.active.toString(),),
                                           reuseablerow(title: 'Critical',value: snapshot.data!.critical.toString(),),
                                           reuseablerow(title: ' Today Recoverd',value: snapshot.data!.todayRecovered.toString(),),
                                           reuseablerow(title: ' Today Deaths',value: snapshot.data!.todayDeaths.toString(),),
                                         ],
                                       ),

                                   ),
                                 ),
                                 GestureDetector(
                                   onTap: (){
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=>countrylist()));
                      },
                                   child: Container(
                                       height: 50,
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(10),
                                         color: Color(0xff1aa260),
                                       ),
                                       child: Center(
                                         child: Text('Track Countries'),
                                       ),
                                     ),
                                 ),
                               ],
                             );
                      }
                    }),

        ],
            ),
          ),
        ),
      ),
    );
  }
}
class reuseablerow extends StatelessWidget {
  String title,value;
   reuseablerow({Key? key, required this.title,required this.value}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
      child:Column(
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 2,),
        Divider(),

      ],
      ),
    );
  }
}


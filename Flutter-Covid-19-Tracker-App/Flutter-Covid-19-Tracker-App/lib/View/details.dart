import 'package:covid_tracker/View/world_state.dart';
import 'package:flutter/material.dart';
class details extends StatefulWidget {
  String image;
  String name;
  int totalcase,totaldeaths,totalrecovered,active,critical,test,recovered;
  details({
    required this.image,
    required this.name,
    required this.totalcase,
    required this.totaldeaths,
    required this.totalrecovered,
    required this.active,
    required this.critical,
    required this.test,
    required this.recovered,
  });

  @override
  State<details> createState() => _detailsState();
}

class _detailsState extends State<details> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .067,),
                    child: Card(
                      child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * .06,),
                          reuseablerow(title: 'Total',value: widget.totalcase.toString(),),
                          reuseablerow(title: 'Recovered',value: widget.recovered.toString(),),
                          reuseablerow(title: 'Deaths',value: widget.totaldeaths.toString(),),
                          reuseablerow(title: 'Active',value: widget.active.toString(),),
                          reuseablerow(title: 'Critical',value: widget.critical.toString(),),
                          reuseablerow(title: ' TotalRecovered',value: widget.totalrecovered.toString(),),
                          reuseablerow(title: ' Deaths',value: widget.totaldeaths.toString(),),
                        ],
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(widget.image),
                  )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}

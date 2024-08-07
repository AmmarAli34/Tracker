import 'package:covid_tracker/Servies/states.dart';
import 'package:covid_tracker/View/details.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class countrylist extends StatefulWidget {
  const countrylist({Key? key}):super(key: key);

  @override
  State<countrylist> createState() => _countrylistState();
}

class _countrylistState extends State<countrylist> {

  TextEditingController searchcontorller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    states statessarvices = states();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: SafeArea(
          child:Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(

                  controller: searchcontorller,
                  onChanged: (value){
                    setState(() {

                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20,),
                    hintText: 'Search with country name',
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    )

                  ),

                ),
              ),
              Expanded(
                  child: FutureBuilder(
                    future:statessarvices.countrylist() ,
                    builder: (context,AsyncSnapshot<List<dynamic>>snapshot){
                      if(!snapshot.hasData){
                        return ListView.builder(
                            itemCount: 8,
                            itemBuilder:(context,index){

                              return Shimmer.fromColors(

                                  baseColor: Colors.grey.shade700,
                                  highlightColor: Colors.grey.shade100,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Container(height: 10,width: 89,color: Colors.white,),
                                      subtitle: Container(height: 10,width: 89,color: Colors.white,),
                                      leading:Container(height: 50,width: 89,color: Colors.white,),
                                    )
                                  ],
                                ),
                              );
                            });
                      }
                      else{
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                            itemBuilder:(context,index){
                            String name = snapshot.data![index]['country'];

                            if(searchcontorller.text.isEmpty){
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context,
                                      MaterialPageRoute(builder: (context)=> details(
                                        image:snapshot.data![index]['countryInfo']['flag'] ,
                                        name: snapshot.data![index]['country'],
                                        totalcase: snapshot.data![index]['cases'],
                                        totaldeaths:snapshot.data![index]['deaths'] ,
                                        totalrecovered: snapshot.data![index]['totalRecovered'],
                                        active: snapshot.data![index]['active'],
                                        critical: snapshot.data![index]['critical'],
                                        test: snapshot.data![index]['test'],
                                        recovered: snapshot.data![index]['recovered'],
                                      )));
                                    },
                                    child: ListTile(
                                      title: Text(snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]['cases'].toString()),
                                      leading: Image(
                                        height:50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']['flag']
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }
                            else if(name.toLowerCase().contains(searchcontorller.text.toLowerCase())){
                              return Column(
                                children: [
                                  InkWell(
                                  onTap: (){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=> details(
                                      image:snapshot.data![index]['countryInfo']['flag'] ,
                                      name: snapshot.data![index]['country'],
                                      totalcase: snapshot.data![index]['cases'],
                                      totaldeaths:snapshot.data![index]['deaths'] ,
                                      totalrecovered: snapshot.data![index]['totalRecovered'],
                                      active: snapshot.data![index]['active'],
                                      critical: snapshot.data![index]['critical'],
                                      test: snapshot.data![index]['test'],
                                      recovered: snapshot.data![index]['recovered'],
                                    )));
                              },
                              child:ListTile(
                                    title: Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]['cases'].toString()),
                                    leading: Image(
                                      height:50,
                                      width: 50,
                                      image: NetworkImage(
                                          snapshot.data![index]['countryInfo']['flag']
                                      ),
                                    ),
                                  ),
                                  )
                                ],
                              );
                            }
                            else{
                              return Container();
                            }

                            });
                      }

                    },
                  ))
            ],
          ) ,
        ),
        ),
    );
  }
}

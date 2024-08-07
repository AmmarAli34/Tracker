
import 'dart:convert';

import 'package:covid_tracker/Utilities/app_uri.dart';
import 'package:covid_tracker/View/country_list.dart';
import 'package:http/http.dart'as http;

import '../Model/WorldStatesModel.dart';

class states{
  Future<WorldStatesModel> facthWorldStates ()async{
    final response = await http.get(Uri.parse(AppUri.worldStatesApi));

    if(response.statusCode == 200){

      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);


    }
    else{
      throw Exception('error');

    }
  }
  Future<List<dynamic>> countrylist ()async{
    var data;
    final response = await http.get(Uri.parse(AppUri.countriesList));

    if(response.statusCode == 200){

       data = jsonDecode(response.body);
      return data;


    }
    else{
      throw Exception('error');

    }
  }

}
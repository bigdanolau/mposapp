import 'dart:convert';

import 'package:http/http.dart' as http;
import  '../models/parks.dart';
class ParksProviders{
 
 
  Future<List<Park>> getParks() async {
  final response =
      await http.get(Uri.http('iesanlucas.com.co:3000',''));
  print(response);
  if (response.statusCode == 200) {

    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<dynamic> decodeData =  json.decode(response.body);
    return decodeData.map((i)=>Park.fromJson(i)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Park');
  }

  }
  Future<bool> addPark(Park park) async {
    var client = http.Client();
    try {
      var uriResponse = await client.post(Uri.parse('http://iesanlucas.com.co:3000/'),
          body:{
        'id': park.id.toString(),
        'nombrePropietario': park.nombrePropietario.toString(),
        'idPropietario': park.idPropietario.toString(),
        'placa': park.placa.toString(),
        'nombrePrestadorServicio': park.nombrePrestadorServicio.toString(),
        'fechaInicio': park.fechaInicio.toString(),
        'estado': park.estado.toString(),
      });
      if (uriResponse.statusCode == 201) {
        return true;
        
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    } finally {
      client.close();
    }
  }
  Future<bool> updateP(Park park) async {
    var client = http.Client();
    try {
      var uriResponse = await client.put(Uri.parse('http://iesanlucas.com.co:3000/'),
          body:{
        'id': park.id.toString(),
        'estado': false.toString(),
      });
      if (uriResponse.statusCode != 500) {
        return true;
        
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    } finally {
      client.close();
    }
  }
  Future<bool> updatek(Park park) async {
    var client = http.Client();
    try {
      var uriResponse = await client.post(Uri.parse('http://iesanlucas.com.co:3000/update/'),body:{
        'id':park.id.toString(),
        'estado': "false"
      });
      if (uriResponse.statusCode == 201) {
        return true;
        
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    } finally {
      client.close();
    }
  }
}
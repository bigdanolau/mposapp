import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:parqueos/config/configProvider.dart';
import 'package:parqueos/models/parks.dart';
import 'package:parqueos/providers/parksProvider.dart';
import 'package:qr_flutter/qr_flutter.dart';
// Terceros
// Propios 


class Details extends StatefulWidget {
  Park parqueo;
  Details({this.parqueo});
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  
  @override
   build(BuildContext context)  {
    var duracion = DateTime.now().difference(widget.parqueo?.fechaInicio);
    int horas = duracion.inHours;
    int minutos = duracion.inMinutes;
    var size = MediaQuery.of(context).size;
    int minutosExtras = 0;
    if(horas > 0){
      minutosExtras = (60 * horas) - minutos;
      
    }
    var costo = horas > 0 ? horas.toString() + '.'+ this.calcularMinutos(minutosExtras).toStringAsFixed(2).split('.')[1] : this.calcularMinutos(minutos).toStringAsFixed(2);
    print(costo);
    var  pagar = [{
      "placa":widget.parqueo.placa,
      "costo": costo,
    }];
    return Scaffold(
      
      appBar: AppBar(
        title: Text(widget.parqueo.placa),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size.width * 0.8,
              child: QrImage(
                embeddedImage: NetworkImage(
                    "https://play-lh.googleusercontent.com/t8OF5ePf0C0X3bVESTiled5zm62V64qAwBcO7D5wy9EtS1_0Cmi9n7uwibhgyitrxh4",
                  ),
                  gapless: true,
                data: pagar.toString(),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Text(widget.parqueo.nombrePropietario.toString(),style: TextStyle(fontSize: size.width * 0.05 ),),
            Text(widget.parqueo.idPropietario.toString()),
            Text(horas > 0 ? horas.toString() +' horas '+ minutosExtras.toString()+' minutos':horas.toString() +' horas '+ minutos.toString()+' minutos'),
            SizedBox(
              height: size.height * 0.01,
            ),
            Text(costo+ ' USD' ,style: TextStyle(fontSize: size.width * 0.075 ),),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                
                Container(
                  constraints: BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                  margin: EdgeInsets.all(10),
                  child: RaisedButton(
                    elevation: 0,
                    onPressed: () {
                      
                      ParksProviders().updateP(widget.parqueo);
                      setState(() {
                        
                      });
                      
                      Navigator.pop(context);
                    },
                    color: Colors.blueAccent,
                    child: Padding(
                      padding: EdgeInsets.all(0),
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Registrar salida.',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                
                ),
              ],
            )
          ],
        )
      ),
    );
  }
  double calcularMinutos(minutos){
     double operacion = (minutos * ConfigProvier().precioMinuto);
     return operacion;
  }

 

}
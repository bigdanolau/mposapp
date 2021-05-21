import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parqueos/models/parks.dart';
import 'package:parqueos/pages/details.dart';
import '../providers/parksProvider.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  Future<List<Park>> futurePark;
  @override
  void initState() {
    super.initState();
  
  }
  TextEditingController nombrePropietario = new TextEditingController();
  TextEditingController idPropietario = new TextEditingController();
  TextEditingController placaVehiculo = new TextEditingController();
  TextEditingController nombreServicio = new TextEditingController();
  List<Park> parqueos = [
    Park(id: 1, estado: true, nombrePrestadorServicio: 'Andres',placa: 'BPV748',idPropietario: 1235038396,nombrePropietario: 'DANIEL AGAMEZ G',fechaInicio: DateTime.parse('2021-05-20 16:26:05.633'))
  ];
  @override
  Widget build(BuildContext context) {
    futurePark = ParksProviders().getParks();
    return Scaffold(
      appBar: AppBar(title: Text('Parqueos Activos'),backgroundColor: Colors.blueAccent,
      actions: [Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: (){
            setState(() {
              
            });
          },
          child: Icon(Icons.update)),
      )],
      ),
      body: Container(child:  FutureBuilder<List<Park>>(
  future: futurePark,
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: ( context, index)=> buildListTile(snapshot.data[index])
            ,
      );
    } else if (snapshot.hasError) {
      return Text("${snapshot.error}");
    }

    // By default, show a loading spinner.
    return CircularProgressIndicator();
  },
)),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),onPressed: (){
        _addPark();
      },backgroundColor: Colors.blueAccent,foregroundColor: Colors.white,),
    );
  }

  ListTile buildListTile(Park park) {
    return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            child: Text(park.placa.substring(0,2)),
          ),
          title: Text(park.placa + ' - '+park.nombrePropietario.toString()),
          onTap: (){
            
            //Navigator.of(context).pushNamed("/details",arguments: ).then((value) => setState(() {}));
            Navigator.push(context,MaterialPageRoute(builder: (context) => Details(parqueo:park))).then((value) => setState(() {
              
            }));
          },
        );
  }

  _addPark() {

    var size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (context){
        return contenidoAlert(size);
      }
    );
  }

  AlertDialog contenidoAlert(Size size) {
                nombrePropietario.text ="";
                idPropietario.text= "";
                placaVehiculo.text = "";
                nombreServicio.text = "";
    return AlertDialog(
        title: Text('Registrar ingreso',textAlign: TextAlign.center,),
        content: Container(
          height: size.height * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            TextField(
              controller: nombrePropietario,
              decoration: InputDecoration(
                hintText: 'Nombre Propietario'
              ),
              inputFormatters: [
                  UpperCaseTextFormatter(),
              ]
            ),
            TextField(
              controller: idPropietario,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'ID. Propietario'
              )
            ),
            
            TextField(
              controller: placaVehiculo,
              decoration: InputDecoration(
                hintText: 'Placa del vehículo',
              ),
              inputFormatters: [
                  UpperCaseTextFormatter(),
              ]
            ),
            TextField(
              controller: nombreServicio,
              decoration: InputDecoration(
                hintText: 'Nombre prestador servicio'
              ),
              inputFormatters: [
                  UpperCaseTextFormatter(),
              ]
            )
          ],),
        ),
        actions: [
          MaterialButton(
            child: Text('Añadir'),
            textColor: Colors.blueAccent,
            onPressed: (){
              var parktemp = new Park(
                 nombrePropietario: nombrePropietario.text  ,
                 idPropietario: int.parse(idPropietario.text) ,
                 placa: placaVehiculo.text ,
                 nombrePrestadorServicio: nombreServicio.text,
                 estado: true,
                 fechaInicio: DateTime.now()
              );
              ParksProviders().addPark(parktemp).then((value){
                  Navigator.pop(context);
                setState(() {
                  
                });
              });
              //addParkToList(nombrePropietario.text  , idPropietario.text , placaVehiculo.text , nombreServicio.text);
            },
          )
        ],
      );
  }

  void addParkToList(nombreP,idP,placaV,nombreS) {
    var ingreso = DateTime.now();
    if(nombreP.toString().length > 0 && idP.toString().length > 0 && placaV.toString().length > 0 && nombreS.toString().length > 0){
      this.parqueos.add(new Park(
        nombrePropietario: nombreP,
        idPropietario: int.parse(idP),
        placa: placaV,
        nombrePrestadorServicio: nombreS,
        fechaInicio: DateTime.now(),
        estado: true
        
      ));
      print(ingreso);
      setState(() {
        
      Navigator.pop(context);
      });
    }
    

  }
}
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text?.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
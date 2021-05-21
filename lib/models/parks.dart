import 'dart:convert';

Park parkFromJson(String str) => Park.fromJson(json.decode(str));

String parkToJson(Park data) => json.encode(data.toJson());

class Park {
    Park({
        this.id,
        this.nombrePropietario,
        this.idPropietario,
        this.placa,
        this.nombrePrestadorServicio,
        this.fechaInicio,
        this.estado,
    });

    int id;
    String nombrePropietario;
    int idPropietario;
    String placa;
    String nombrePrestadorServicio;
    DateTime fechaInicio;
    bool estado;

    factory Park.fromJson(Map<String, dynamic> json) => Park(
        id: int.parse(json["id"]),
        nombrePropietario: json["nombrePropietario"],
        idPropietario: int.parse(json["idPropietario"]),
        placa: json["placa"],
        nombrePrestadorServicio: json["nombrePrestadorServicio"],
        fechaInicio: DateTime.parse(json["fechaInicio"]),
        estado: json["estado"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombrePropietario": nombrePropietario,
        "idPropietario": idPropietario,
        "placa": placa,
        "nombrePrestadorServicio": nombrePrestadorServicio,
        "fechaInicio": fechaInicio,
        "estado": estado,
    };
}

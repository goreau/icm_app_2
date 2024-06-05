class Visita {
  late int idVisita;
  late int idMunicipio;
  late String dtCadastro;
  late String agente;

  late String idArea = '0';
  late String idCensitario = '0';
  late String idQuarteirao = '0';

  late String ordem;
  late String endereco;
  late String numero;
  late String idTipo;

  late int fachada;
  late int casa;
  late int quintal;
  late int sombraQuintal;
  late int pavQuintal;
  late int telhado;
  late int recipiente;
  late String latitude;
  late String longitude;
  late String foto;

  /* Visita(
      this.idVisita,
      this.idMunicipio,
      this.idArea,
      this.idCensitario,
      this.idQuarteirao,
      this.dtCadastro,
      this.agente,
      this.ordem,
      this.endereco,
      this.numero,
      this.fachada,
      this.casa,
      this.quintal,
      this.sombraQuintal,
      this.pavQuintal,
      this.telhado,
      this.recipiente,
      this.latitude,
      this.longitude);*/

  void fromJson(dynamic json) {
    idVisita = int.parse(json['id_visita'].toString());
    idMunicipio = int.parse(json['id_municipio'].toString());
    idArea = json['id_area'].toString();
    idCensitario = json['id_censitario'].toString();
    idQuarteirao = json['id_quarteirao'].toString();
    dtCadastro = json['dt_cadastro'];
    agente = json['agente'];
    ordem = json['ordem'].toString();
    endereco = json['endereco'].toString();
    numero = json['numero'];
    fachada = int.parse(json['fachada'].toString());
    casa = int.parse(json['casa'].toString());
    quintal = int.parse(json['quintal'].toString());
    sombraQuintal = int.parse(json['sombra_quintal'].toString());
    pavQuintal = int.parse(json['pav_quintal'].toString());
    telhado = int.parse(json['telhado'].toString());
    recipiente = int.parse(json['recipiente'].toString());
    latitude = json['latitude'].toString();
    longitude = json['longitude'].toString();
    foto = json['foto'].toString();
  }

  Map toJson() => {
        'id_municipio': idMunicipio,
        'id_area': idArea,
        'id_censitario': idCensitario,
        'id_quarteirao': idQuarteirao,
        'dt_cadastro': dtCadastro,
        'agente': agente,
        'ordem': ordem,
        'endereco': endereco,
        'numero': numero,
        'fachada': fachada,
        'casa': casa,
        'quintal': quintal,
        'sombra_quintal': sombraQuintal,
        'pav_quintal': pavQuintal,
        'telhado': telhado,
        'recipientes': recipiente,
        'latitude': latitude,
        'longitude': longitude,
        'foto': longitude,
      };
}

class LstMaster {
  int idQuadra;
  String area;
  String quadra;
  String dtCadastro;
  int status;

  LstMaster(
      this.idQuadra, this.area, this.quadra, this.dtCadastro, this.status);

  factory LstMaster.fromJson(dynamic json) {
    //var prop = jsonDecode(json['dados_proposta']);
    return LstMaster(
      int.parse(json['id_quadra'].toString()),
      json['area'].toString(),
      json['quadra'].toString(),
      json['dt_cadastro'],
      int.parse(json['status'].toString()),
    );
  }
}

class LstDetail {
  int id;
  int status;
  String ordem;
  String endereco;

  LstDetail(this.id, this.status, this.ordem, this.endereco);

  factory LstDetail.fromJson(dynamic json) {
    //var prop = jsonDecode(json['dados_proposta']);
    return LstDetail(
        int.parse(json['id_visita'].toString()),
        int.parse(json['status'].toString()),
        json['ordem'].toString(),
        json['endereco'].toString().trim() +
            ', ' +
            json['numero'].toString().trim());
  }
}


/*class VisitaEnvio {
  int idVisita;
  int idMunicipio;
  String dtCadastro;
  String agente;

  String idArea;
  String idCensitario;
  String idQuarteirao;

  String ordem;
  String endereco;
  String numero;

  int fachada;
  int casa;
  int quintal;
  int sombraQuintal;
  int pavQuintal;
  int telhado;
  int recipiente;
  String latitude;
  String longitude;

  VisitaEnvio(
    {
    required this.idVisita,
    required this.idMunicipio,
    required this.dtCadastro,
    required this.agente,
    required this.idArea,
    required this.idCensitario,
    required this.idQuarteirao,
    required this.ordem,
    required this.endereco,
    required this.numero,
    required this.fachada,
    required this.casa,
    required this.quintal,
    required this.sombraQuintal,
    required this.pavQuintal,
    required this.telhado,
    required this.recipiente,
    required this.latitude,
    required this.longitude,
  });

  factory VisitaEnvio.fromJson(Map<String, dynamic> json){
    return VisitaEnvio(
        idVisita: int.parse(json["id_visita"]),
        idMunicipio: int.parse(json["id_municipio"]),
        idArea: json["id_area"].toString(),
        idCensitario: json["id_censitario"].toString(),
        idQuarteirao: json["id_quarteirao"].toString(),
        dtCadastro: json["dt_cadastro"].toString(),
        agente: json["agente"].toString(),
        ordem: json["ordem"].toString(),
        endereco: json["endereco"],
        numero: json["numero"].toString(),
        fachada: int.parse(json["fachada"].toString()),
        casa: int.parse(json["casa"].toString()),
        quintal: int.parse(json["quintal"].toString()),
        sombraQuintal: int.parse(json["sombra_quintal"].toString()),
        pavQuintal: int.parse(json["pavQuintal"].toString()),
        telhado: int.parse(json["cartao_corporativo"].toString()),
        recipiente: int.parse(json["cpf"].toString()),
        latitude: json["nome"].toString(),
        longitude: json["perfil"].toString(),
    );
  }
}*/
class Veiculo {
  String placa;
  String anotacao;
  bool feito;

  Veiculo({this.placa, this.anotacao, this.feito = false});

  Veiculo.fromJson(Map<String, dynamic> json) {
    placa = json['placa'];
    anotacao = json['anotacao'];
    feito = json['feito'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['placa'] = this.placa;
    data['anotacao'] = this.anotacao;
    data['feito'] = this.feito;
    return data;
  }
}

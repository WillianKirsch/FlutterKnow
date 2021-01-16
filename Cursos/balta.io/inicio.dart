import 'dart:io';

class Pessoa {
  int idade;
  List<Map<String, String>> pessoasConhecidas = [];

  salvarIdade(int idade) {
    this.idade = idade;
  }

  salvarNomePai(String nome) {
    pessoasConhecidas.add({"Pai": nome});
  }

  salvarNomeMae(String nome) {
    pessoasConhecidas.add({"Mãe": nome});
  }
}

//Executando no cmd "dart hello.dart"

Pessoa pessoaEntrevistada;
main() {
  pessoaEntrevistada = Pessoa();
  escreverFalaDoGaucho("Olá tchê!");
  _pedindoIdade();

  _imprimirInformacoesColetadas();
}

escreverFalaDoGaucho(String fala) {
  print("Gaúcho: $fala");
}

perguntar() {
  stdout.write("Eu: ");
}

_pedindoIdade() {
  escreverFalaDoGaucho("Qual a tua idade, gaúcho?");

  int idade = _obterIdade();

  if (idade < 18) {
    escreverFalaDoGaucho("Mas bah, tu ainda é um gurizote!");
    _pedindoNomeDosFamiliares();
  } else if (idade < 60) {
    escreverFalaDoGaucho("Parabéns, já é um barbado!");
  } else {
    escreverFalaDoGaucho(
        "Com todos esses $idade anos já tá bem experiente na vida!");
  }
  pessoaEntrevistada.salvarIdade(idade);
}

_pedindoNomeDosFamiliares() {
  _pedirNomeDoPai();

  _pedirNomeDaMae();
}

_pedirNomeDoPai() {
  escreverFalaDoGaucho("Quem é teu pai guri?");

  perguntar();
  String nomePai = stdin.readLineSync();

  if (nomePai.length == 0) {
    escreverFalaDoGaucho("Mas até parece que não conhece teu pai, tchê!");
  } else {
    escreverFalaDoGaucho(
        "Huum $nomePai, mas que tal, posso ter conhecido ele na minha vida já, mas não me alembro.");
    pessoaEntrevistada.salvarNomePai(nomePai);
  }
}

_pedirNomeDaMae() {
  escreverFalaDoGaucho("E me conta, quem é tua mãe?");

  String nomeMae;
  do {
    perguntar();
    nomeMae = stdin.readLineSync();

    if (nomeMae.length == 0) {
      escreverFalaDoGaucho(
          "Mas para de frescura guri, qual é o nome da tua mãe?");
    }
  } while (nomeMae.length == 0);

  pessoaEntrevistada.salvarNomeMae(nomeMae);
  escreverFalaDoGaucho(
      "Muito bonito nome! $nomeMae, é o mesmo nome que eu ia dar pra minha filha.");
}

int _obterIdade() {
  String idadeTexto;
  int idade;
  do {
    perguntar();
    idadeTexto = stdin.readLineSync();
    idade = int.tryParse(idadeTexto);

    if (idade == null) {
      escreverFalaDoGaucho(
          "Não tenta me enganar que eu te peguei no pulo piá! Me diz tua idade!");
    }
  } while (idade == null);
  return idade;
}

_imprimirInformacoesColetadas() {
  print("Idade: " + pessoaEntrevistada.idade.toString());
  print("Pessoas conhecidas: (Total de " +
      pessoaEntrevistada.pessoasConhecidas.length.toString() +
      ") " +
      pessoaEntrevistada.pessoasConhecidas
          .map((pessoa) => pessoa.toString())
          .toString());
}

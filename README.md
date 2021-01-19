# FlutterKnow

Material concentrado para estudos sobre Flutter.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Links de cursos

https://app.balta.io/

## Links úteis

### Components

- https://flutterawesome.com/

### Aplicativos

- https://appsco.pe/

### Publicação

Gerar a chave no Console Play Store

keytool -genkey -v -keystore c:\Users\USER_NAME\key.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias key
keytool -genkey -v -keystore C:\GitHub\Cursos\FlutterKnow\key.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias key

- Android
  flutter build appbundle

- IoS
  flutter build ios

### Coisas estranhas encontradas

- Não aceita concatenação de string de objetos complexos com o uso do $.
  Ex: print("Pessoas conhecidas: (Total de " + pessoaEntrevistada.pessoasConhecidas.length.toString() +")");
  Sugestão: print("Pessoas conhecidas: (Total de $pessoaEntrevistada.pessoasConhecidas.length.toString())");

// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
class Cliente{
  late Socket conexaoServidor;

//metodo para estabelecer conexão
 void connectServer(String ipAdress, int port, BuildContext context) async{
  try{
    conexaoServidor = await Socket.connect(ipAdress, port);
  } on SocketException {
    resposta(context, "Servidor não respondeu à tentativa de conexão");
  }  
  }

//metodo para ouvir a resposta do servidor
void listenServer(BuildContext context) {    
    conexaoServidor.listen((Uint8List data) {
     final serverResponse =  String.fromCharCodes(data); 
     resposta(context, serverResponse);
  },
    onError: (error){
      resposta(context, error.toString());
    },
    onDone: (){      
      conexaoServidor.destroy();
    });    
  }

//metodo para enviar mensagens ao servidor
  Future<void> sendMessage(String message) async{
    conexaoServidor.write(message);
    await Future.delayed(const Duration(seconds: 1));
  }

  void resposta(BuildContext context, String respostaServidor){
  SnackBar  snackBar = SnackBar(
    content: Text(respostaServidor, style: const TextStyle(color: Colors.white),
    ));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
  
  }
  
  void closeConnection(BuildContext context){
    resposta(context, "Conexão fechada.");
    conexaoServidor.destroy();
  }
}  
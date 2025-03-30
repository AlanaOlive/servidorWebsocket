// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:typed_data';
void main(){
    Servidor server = Servidor();
    server.initializeServer();
   }
   
class Servidor{
  late ServerSocket servidor;

  void initializeServer() async{
    try{
      servidor = await ServerSocket.bind(InternetAddress.anyIPv4, 8000);
      servidor.listen((conexao) {
        handleConnection(conexao);
      });
    }on SocketException catch (e){
      print(e.message);
    }
  }

  void handleConnection(Socket conexao){
    conexao.listen((Uint8List data) async { 
      await Future.delayed(const Duration(seconds: 1));
      final mensagem = String.fromCharCodes(data);        
        conexao.write("Mensagem recebida com sucesso:  $mensagem");
        print("Mensagem recebida com sucesso:  $mensagem");
    },    
      onError: (error){        
        conexao.write(error.toString());
        conexao.close();
      },
      onDone: (){
        conexao.write("Cliente finalizou a conexão.");
        conexao.close();
      }
      );
  }

  void closeServer(){
    servidor.close();
  }
}


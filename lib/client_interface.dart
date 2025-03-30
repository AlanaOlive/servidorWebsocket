// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, await_only_futures
import 'client_socket.dart';
import 'server_socket.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Servidor server = Servidor();
  late Future<bool> connServer;
  Cliente cliente = Cliente();
  String ipAdress = "";
  int port = 0;
  final TextEditingController _controllerMessage = TextEditingController();
  final TextEditingController _controllerIP = TextEditingController();
  final TextEditingController _controllerPort = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final scaffoldState = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldState,
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,      
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextField(
              controller: _controllerIP,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'IP do servidor',
              ),
            ),
            TextField(
              controller: _controllerPort,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Porta de acesso ao servidor',
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(        
        onPressed: () async {
          ipAdress = _controllerIP.text;
          port = int.parse(_controllerPort.text);
          cliente.connectServer(ipAdress, port, context);
          scaffoldState.currentState?.showBottomSheet((context) => Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: TextField(
                      controller: _controllerMessage,
                      decoration: const InputDecoration(
                          hintText: "Digite um texto",
                          border: OutlineInputBorder()),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        tooltip: "Enviar",
                        child: Text("Enviar mensagem"),
                        onPressed: () async {
                          await cliente.sendMessage(_controllerMessage.text);
                          cliente.listenServer(context);
                          _controllerMessage.clear();
                        },
                      ),
                      FloatingActionButton(
                          tooltip: "Fechar conexão",
                          onPressed: () {
                            cliente.closeConnection(context);
                            Navigator.pop(context);
                          },
                          child: Text("Fechar conexão")),
                    ],
                  )
                ],
              ));
        },
        tooltip: 'Connect',
        child: const Icon(Icons.not_started_rounded),
      ),
    );
  }
}

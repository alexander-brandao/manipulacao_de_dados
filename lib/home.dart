import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _textoSalvo = "Nada salvo!";
  TextEditingController _controllerCampo = TextEditingController();

  _salvar() async {

    String valorDigitado = _controllerCampo.text;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("nome", valorDigitado);

  }

  _recuperar() async {

    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _textoSalvo = prefs.getString("nome") ?? "Sem valor" ;
    });
  }

  _remover() async{

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("nome");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manipulação de dados"),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _textoSalvo,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Padding(
                padding: EdgeInsets.all(20)
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Digite algo',
                border: OutlineInputBorder(),
              ),
              controller: _controllerCampo,
            ),
            Padding(
                padding: EdgeInsets.all(20)
            ),
            ElevatedButton(
                onPressed: _salvar,
                child: Text(
                  "Salvar",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )
            ),
            Padding(
                padding: EdgeInsets.all(5)
            ),
            ElevatedButton(
                onPressed: _recuperar,
                child: Text(
                  "Recuperar",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )
            ),
            Padding(
                padding: EdgeInsets.all(5)
            ),
            ElevatedButton(
                onPressed: _remover,
                child: Text(
                  "Remover",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}

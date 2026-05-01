import 'package:flutter/material.dart';
import 'compras.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Aplicativo de venda de roupas",
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: const Login(),
    );
  }
}
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  String _resultado = '';
  bool esconderSenha = true;

  void _validalogin() {
    String usuario = _usuarioController.text;
    String senha = _senhaController.text;

    if (usuario != '' && senha != '') {
      if(usuario == 'admin' && senha == '123') {
        _resultado = "Bem-vindo(a)!";

      }else {
        _resultado = "Usuário ou senha incorretos.";
      }

      setState(() {
        _resultado;
      });
    } else {
      setState(() {
        _resultado = "Preencha os campos!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Center(
        child:
        Padding(padding: EdgeInsets.all(24),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.shopping_bag_rounded,
                size: 90,
                color: Colors.deepOrange,
              ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _usuarioController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Digite o usuário: ',
                      prefixIcon: Icon(Icons.person),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _senhaController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: "Digite a senha: ",
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          esconderSenha
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                          onPressed: () {
                            setState(() {
                              esconderSenha = !esconderSenha;
                            });
                          },
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    obscureText: esconderSenha,
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            SizedBox(height: 30,
              child:
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  _validalogin();
                  if(_resultado == "Bem-vindo(a)!"){
                    Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context) =>
                          Compras(),
                    ),
                    );
                  }else{
                    Text(_resultado);
                  }

                },
                //style: ButtonStyle(backgroundColor: Colors.deepOrange),
                child: const Text('Entrar', style: TextStyle(fontSize: 18),),
              ),
            ),
            ),
            SizedBox(height: 20),
            Text(_resultado, style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
          ],

        ))

      ),
    );
  }
}

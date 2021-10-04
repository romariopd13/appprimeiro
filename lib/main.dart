import 'package:flutter/material.dart';

//método principal da classe
void main() => runApp(
      //MaterialApp->utiliza as partes gráficas
      //para elaboração dos layouts
      MaterialApp(
        home: Home(),
        //utiliza um pequeno banner de debug no aplicativo
        debugShowCheckedModeBanner: false,
      ),
    );

//início
class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  //para poder utilizar as ações dos botões de acordo
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //criando os campos de entrada de dados
  TextEditingController _codigoController = TextEditingController();
  TextEditingController _cpfController = TextEditingController();
  TextEditingController _consumoMesController = TextEditingController();
  TextEditingController _valorKwController = TextEditingController();

  //contém valor do resultado final
  String _result = "";

  //método para zerar todos os campos quando o aplicativo
  //for aberto
  @override
  void initState() {
    //iniciando o estado do aplicativo ao ser executado
    super.initState();
    //chamando o método para limpar os dados informados
    limpaCampos();
  }

  void limpaCampos() {
    _codigoController.text = '';
    _cpfController.text = '';
    _consumoMesController.text = '';
    _valorKwController.text = '';
  }

  void calcularConsumo() {
    double _cm = double.parse(_consumoMesController.text);
    double _vkm = double.parse(_valorKwController.text);
    double _consumo = (_cm * _vkm);

    setState(() {
      _result = "ConsumoMes=${_consumo.toStringAsFixed(2)}\n";
    });
  }

  //criando o botão para calcular o Valor a Pagar
  Widget buildCalcularButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: RaisedButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            calcularConsumo();
          }
        },
        child: Text('CALCULAR ENERGIA', style: TextStyle(color: Colors.brown)),
      ),
    );
  }

  //método para configurar o resultado em uma Text
  Widget buildTextResult() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: Text(
        _result,
        textAlign: TextAlign.left,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20.0), child: buildForm()));
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('App Rain'),
      backgroundColor: Colors.green,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            limpaCampos();
          },
        )
      ],
    );
  }

  Form buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildTextFormField(
              label: "Código do Consumidor",
              error: "Insira o Código do Consumidor!",
              controller: _codigoController),
          buildTextFormField(
              label: "CPF do Consumidor",
              error: "Insira CPF do Consumidor!",
              controller: _cpfController),
          buildTextFormField(
              label: "Consumo mês Consumidor",
              error: "Insira Consumo mês Consumidor!",
              controller: _consumoMesController),
          buildTextFormField(
              label: "Valor KW Mês",
              error: "Insira Valor KW Mês!",
              controller: _valorKwController),
          buildTextResult(),
          buildCalcularButton(),
        ],
      ),
    );
  }

  //formatar e exibir msg de erro nos inputs (entrada
  //de dados)
  TextFormField buildTextFormField(
      {TextEditingController controller, String error, String label}) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
      controller: controller,
      validator: (text) {
        //verifica se o valor foi digitado
        return text.isEmpty ? error : null;
      },
    );
  }
}

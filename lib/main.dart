import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: "Input, Alert Dialog & Snackbar",
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // membuat variabel untuk menampung inputan text
  String teks = "";

  // membuat controler untuk textfield
  TextEditingController controllerInput = new TextEditingController();
  TextEditingController controllerAlert = new TextEditingController();
  TextEditingController controllerSnackbar = new TextEditingController();

  // membuat global key untuk scaffold
  final GlobalKey<ScaffoldState> _scaffoldstate = new GlobalKey<ScaffoldState>();

  void _snackbars(String str) {
    if (str.isEmpty) return;

    _scaffoldstate.currentState.showSnackBar(new SnackBar(
      content: Text(str, style: TextStyle(fontSize: 20.0),),
    ));
  }

  void _alertdialog(String str) {
    if (str.isEmpty) return;

    AlertDialog alertDialog = new AlertDialog(
      content: Text(
        str,
        style: TextStyle(fontSize: 20.0),
      ),
      actions: <Widget>[
        // action bisa digunakan untuk button cancel ataupun ok
        FlatButton(
          color: Colors.red,
          child: Text("OK", style: TextStyle(color: Colors.white),),
          onPressed: (){
            // ketika button OK diklik maka akan kembali
            Navigator.pop(context);

            // akan menghapus teks pada field ketika di klik ok
            controllerAlert.text = "";
          },
        ),
        FlatButton(
          color: Colors.red,
          child: Text("Cancel", style: TextStyle(color: Colors.white),),
          onPressed: (){
            // ketika button OK diklik maka akan kembali
            Navigator.pop(context);
          },
        )
      ],
    );

    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldstate,
      appBar: AppBar(
        title: Text("Input, Alert Dialog & Snackbar"),
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            // Container untuk input dan menampilkan text
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    // memasukan controler textediting pada textfield
                    controller: controllerInput,
                    decoration: InputDecoration(hintText: "Untuk Input Text"),
                    onSubmitted: (String str) {
                      // onSubmited = harus di submit(ok, selesai, dll) dulu baru teks akan muncul
                      // str = variabel untuk menyimpan inputan
                      setState(() {
                        // teks akan terus berganti
                        // teks = str;

                        // Agar teks yang sebelumnya tidak hilang dan terus bertambah
                        teks = str + '\n' + teks;
                        // jika sudah di submit maka textfield akan di kembalikan ke value awal yaitu ""
                        controllerInput.text = "";
                      });
                    },
                    // onChanged: (String str) {
                    //   // onChanged = langsung berubah ketika input di ketik
                    //   // str = variabel untuk menyimpan inputan
                    //   setState(() {
                    //     teks = str;
                    //   });
                    // },
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                  ),
                  Text(
                    teks,
                    style: TextStyle(fontSize: 20.0),
                  )
                ],
              ),
            ),
            
            // container untuk alert dialog
            Container(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                // memanggil controller textediting
                controller: controllerAlert,
                decoration:
                    InputDecoration(hintText: "Input untuk alert dialog !"),
                onSubmitted: (String str) {
                  // onSubmited = harus di submit(ok, selesai, dll) dulu baru teks akan muncul
                  // str = variabel untuk menyimpan inputan

                  // memanggil method _alertdialog dengan parameter "str"
                  _alertdialog(str);
                },
              ),
            ),

            // container untuk snackbar
            Container(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                // memanggil controller textediting
                controller: controllerSnackbar,
                decoration:
                    InputDecoration(hintText: "Input untuk snackbar !"),
                onSubmitted: (String str) {
                  // onSubmited = harus di submit(ok, selesai, dll) dulu baru teks akan muncul
                  // str = variabel untuk menyimpan inputan

                  // memanggil method _snackbars dengan parameter "str"
                  _snackbars(str);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

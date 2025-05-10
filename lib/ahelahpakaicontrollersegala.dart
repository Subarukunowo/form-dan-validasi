import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late FocusNode focusNode;
  final prodiController = TextEditingController();
  final nimController = TextEditingController();
  final namaController = TextEditingController();
  final semesterController = TextEditingController();
  void printValue(){
    print('NIM: ${nimController.text}');
    print('Nama: ${namaController.text}');
    print('Prodi: ${prodiController.text}');
    print('Semester: ${semesterController.text}');
  }
showData(){
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Data Mahasiswa'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('NIM: ${nimController.text}'),
            Text('Nama: ${namaController.text}'),
            Text('Prodi: ${prodiController.text}'),
            Text('Semester: ${semesterController.text}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  void validasiInput() {
    FormState? form = formKey.currentState;

    const snackBar = SnackBar(
      content: Text('Semua data sudah tervalidasi'),
    );

    if (form!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
       print('NIM: ${nimController.text}');
    print('Nama: ${namaController.text}');
    print('Program Studi: ${prodiController.text}');
    print('Semester: ${semesterController.text}');
    showData();  // Menambahkan pemanggilan showData()
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nimController,
                decoration: const InputDecoration(
                  hintText: 'NIM',
                  labelText: 'NIM',
                  icon: Icon(Icons.person_pin),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'NIM tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: namaController,
                decoration: const InputDecoration(
                  hintText: 'Nama',
                  labelText: 'Nama',
                  icon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
                focusNode: focusNode,
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller : prodiController,
                decoration: const InputDecoration(
                  hintText: 'Program Studi',
                  labelText: 'Program Studi',
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.dashboard),
                ),
                keyboardType: TextInputType.text,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Program Studi tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller : semesterController,
                decoration: const InputDecoration(
                  hintText: 'Semester',
                  labelText: 'Semester',
                  icon: Icon(Icons.format_list_numbered),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Semester tidak boleh kosong';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Semester harus berupa angka';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    child: const Text('Kirim'),
                    onPressed: validasiInput,
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    child: const Text('Fokus ke Nama'),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(focusNode);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

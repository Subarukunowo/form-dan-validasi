import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Pendaftaran',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Form Pendaftaran Pengguna'),
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
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final hpController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final roleController = TextEditingController();

  void validasiInput() {
    FormState? form = formKey.currentState;

    if (form!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data sudah tervalidasi')),
      );
      // You can print or display the form data as needed
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
                controller: usernameController,
                decoration: const InputDecoration(
                  hintText: 'Username',
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Username tidak boleh kosong';
                  }
                  if (value.length < 4 || value.length > 25) {
                    return 'Username harus antara 4 hingga 25 karakter';
                  }
                  if (RegExp(r'\d').hasMatch(value)) {
                    return 'Username tidak boleh mengandung angka';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Email tidak boleh kosong';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Format email tidak valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: hpController,
                decoration: const InputDecoration(
                  hintText: 'Nomor HP',
                  labelText: 'Nomor HP',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor HP tidak boleh kosong';
                  }
                  if (value.length < 10 || value.length > 12) {
                    return 'Nomor HP harus antara 10 hingga 12 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Password tidak boleh kosong';
                  }
                  if (value.length < 4 || value.length > 25) {
                    return 'Password harus antara 4 hingga 25 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(
                  hintText: 'Confirm Password',
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirm Password tidak boleh kosong';
                  }
                  if (value != passwordController.text) {
                    return 'Password dan Confirm Password tidak cocok';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
              DropdownButtonFormField<String>(
                value: roleController.text.isEmpty ? null : roleController.text,
                decoration: const InputDecoration(
                  labelText: 'Role',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'User', child: Text('User')),
                  DropdownMenuItem(value: 'Admin', child: Text('Admin')),
                ],
                onChanged: (value) {
                  setState(() {
                    roleController.text = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pilih Role';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: validasiInput,
                child: const Text('Kirim'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

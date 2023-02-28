import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SecureStorage(),
    );
  }
}

class SecureStorage extends StatefulWidget {
  const SecureStorage({Key? key}) : super(key: key);

  @override
  State<SecureStorage> createState() => _SecureStorageState();
}

class _SecureStorageState extends State<SecureStorage> {

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController address = TextEditingController();
  FlutterSecureStorage secureStorage = FlutterSecureStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getValues();
  }

  void getValues() async {
    name.text = await getValue("Name");
    email.text = await getValue("Email");
    address.text = await getValue("Address");
  }

  Future<void> save(String key, String value) async {
    await secureStorage.write(key: key, value: value);
  }

  Future<String> getValue(String key) async {
    return await secureStorage.read(key: key) ?? '';
  }

  void saveDetails() {
    save("Name", name.text);
    save("Email", email.text);
    save("Address", address.text);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Secure Storage'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            customTextField("Name", name),
            customTextField('Email', email),
            customTextField("Address", address),
            ElevatedButton(
                onPressed: () {
                  saveDetails();
                },
                child: Text('Save')
            )
          ],
        ),
      ),
    );
  }

  Widget customTextField(String hintText,TextEditingController controller) => Padding(
     padding: EdgeInsets.all(15),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hintText,
      ),
    ),
  );
}


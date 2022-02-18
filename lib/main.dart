import 'package:flutter/material.dart';
import 'package:mental/shared/sp_helper.dart';

import 'admin/MenuAdmin.dart';
import 'constants/constants.dart';
import 'user/menu_user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<String> showLoginPage() async {
    SPHelper helper = SPHelper();

    // sharedPreferences.setString('user', 'hasuser');
    var type = await helper.readUserType();
    return type;
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      theme: ThemeData(
        fontFamily: Font.nunito,
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      //https://stackoverflow.com/questions/55213527/flutter-set-startup-page-based-on-shared-preference
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() {
    return HomePageState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class HomePageState extends State<HomePage> {
  late String password;
  final _formKey = GlobalKey<FormState>();

  SPHelper helper = SPHelper();

  @override
  void initState() {
    super.initState();
    helper.init().then((value) {
      helper.readUserType().then((userType) {
        print(userType);
        if ("ADMIN" == userType) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MenuAdmin()));
        } else if ("ADMIN" == userType) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => UserMenu()));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 50),
              Container(height: 150, child: Image.asset(ImageRasterPath.logo)),
              const SizedBox(height: 50),
              Text(
                "Entrez votre code",
                style: TextStyle(fontSize: 20),
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.number,
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez votre code';
                        }
                        setState(() {
                          password = value;
                        });
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            print(password);

                            FocusScope.of(context).requestFocus(FocusNode());

                            if (password == "1948") {
                              helper.writeUserType("ADMIN");
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MenuAdmin()));
                            } else if (password == "1966") {
                              helper.writeUserType("USER");
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => UserMenu()));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Code incorrect')),
                              );
                            }
                          }
                        },
                        child: const Text('Valider'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'create_your_order.dart';


class EnterYourDetails extends StatefulWidget {
  const EnterYourDetails({Key? key}) : super(key: key);

  @override
  State<EnterYourDetails> createState() => _EnterYourDetailsState();
}

class _EnterYourDetailsState extends State<EnterYourDetails> {
  final formKey = GlobalKey<FormState>();
  String? selectedGender;
  double? weight;
  double? height;
  int? age;
  bool isFormValid = false;

  void _validateForm() {
    setState(() {
      isFormValid = formKey.currentState?.validate() ?? false;
    });
  }

  void _submitDetails(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Map<String, dynamic> user = {
        'gender': selectedGender,
        'weight': weight,
        'height':height,
        'age': age,
      };

      try {
        await DatabaseHelper().insertUser(user);
        print('Navigating to CreateYourOrder screen...');

        // Calculate needed calories
        double neededCalories;
        if (selectedGender == 'Female') {
          neededCalories = 655.1 + (9.56 * weight!) + (1.85 * height!) - (4.67 * age!);
        } else if (selectedGender == 'Male') {
          neededCalories = (666.47 + (13.75 * weight!) + (5 * height!) - (6.75 * age!));
        } else {
          throw Exception('Invalid gender');
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateYourOrder(needcalories: neededCalories),
          ),
        );
      } catch (e) {
        print('Error adding user: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.only(left: 25.0),
          icon: Icon(Icons.arrow_left_sharp, size: 35.0),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Center(
          child: Text(
            'Enter your details',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            onChanged: _validateForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gender',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                DropdownButtonFormField<String>(
                  value: selectedGender,
                  items: ['Male', 'Female'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedGender = newValue;
                      _validateForm();
                    });
                  },
                  dropdownColor: Colors.white,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Colors.grey, // Border color
                        width: 0.2, // Border thickness
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.grey, // Border color when enabled
                        width: 0.2, // Border thickness when enabled
                      ),
                    ),
                    hintText: 'Choose your gender',
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'This field shouldn\'t be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 25.0),
                Text(
                  'Height',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.grey, // Border color
                        width: 0.2, // Border thickness
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.grey, // Border color when enabled
                        width: 0.2, // Border thickness when enabled
                      ),
                    ),
                    hintText: 'Enter your height',
                    suffixText: 'Cm',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field shouldn\'t be empty';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    height = double.parse(value!);
                  },
                ),
                SizedBox(height: 25.0),
                Text(
                  'Weight',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Colors.grey, // Border color
                        width: 0.2, // Border thickness
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.grey, // Border color when enabled
                        width: 0.2, // Border thickness when enabled
                      ),
                    ),
                    hintText: 'Enter your weight',
                    suffixText: 'kg',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field shouldn\'t be empty';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    weight = double.parse(value!);
                  },
                ),
                SizedBox(height: 25.0),
                Text(
                  'Age',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Colors.grey, // Border color
                        width: 0.2, // Border thickness
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.grey, // Border color when enabled
                        width: 0.2, // Border thickness when enabled
                      ),
                    ),
                    hintText: 'Enter your age',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field shouldn\'t be empty';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    age = int.parse(value!);
                  },
                ),
                SizedBox(height: 140.0),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: isFormValid ? () => _submitDetails(context) : null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: isFormValid ? Color(0xFFF25700) : Colors.grey,
                      minimumSize: Size(150, 50), // Button size (width, height)
                      padding: const EdgeInsets.symmetric(horizontal: 140, vertical: 22), // Button padding
                      textStyle: const TextStyle(
                        fontSize: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // Border radius
                      ),
                    ),
                    child: Text('Next'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_details.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            gender TEXT,
            weight REAL,
            height REAL,
            age INTEGER
          )
        '''). then((value) {
        print("Table created");
        });
      },
    );
  }

  Future<Null> insertUser(Map<String, dynamic> user) async {
    Database db = await database;
    return await db.insert('users', user).then((value) {
      print("$value insteresd successfully");

    }).catchError((onError) {
      print("inserting Error is ${onError.toString()}");
    });
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    Database db = await database;
    return await db.query('users');
  }
}

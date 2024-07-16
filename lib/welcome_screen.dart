import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'enter_your_details.dart';
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return
        Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(image:AssetImage('assets/images/img4.jpg'),
                    fit: BoxFit.cover,
                  )

              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 50.0),
                      child: Text(
                        'Balanced Meal',
                        style: GoogleFonts.abhayaLibre(
                          fontSize: 48,
                          fontWeight: FontWeight.w800,
                          height: 57 / 48,
                          color: Colors.white,

                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 40.0),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0), // Left and right padding
                              child: Text(
                                'Craft your ideal meal effortlessly with our app.'
                                    ''
                                    ' Select nutritious ingredients tailored'
                                    ' to your taste and well-being.',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 22,
                                  height: 1.5, // line-height in Flutter is set by height (lineHeight / fontSize)
                                  color: Colors.white,

                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),

                            SizedBox(height: 20),// Adjust the value as needed
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(context,MaterialPageRoute(builder: (context) => EnterYourDetails()),
                                );

                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Color(0xFFF25700),
                                minimumSize: Size(100, 50), // Button size (width, height)
                                padding: const EdgeInsets.symmetric(horizontal: 125, vertical: 22), // Button padding
                                textStyle: const TextStyle(
                                  fontSize: 16,

                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15), // Border radius
                                ),
                              ),
                              child: Text('Order Food'),
                            ),
                          ]),
                    ),
                  ),
                ],

              ),


            )
        );

  }
}

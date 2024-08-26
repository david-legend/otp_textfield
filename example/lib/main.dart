import 'package:example/verification_screen.dart';
import 'package:flutter/material.dart';

const Color accentPurpleColor = Color(0xFF6A53A1);
const Color accentPinkColor = Color(0xFFF99BBD);
const Color accentDarkGreenColor = Color(0xFF115C49);
const Color accentYellowColor = Color(0xFFFFB612);
const Color accentOrangeColor = Color(0xFFEA7A3B);

class Example {
  final String title;
  final String subtitle;
  final GestureTapCallback? onTap;
  final Route<Object?> route;

  Example({
    required this.title,
    required this.subtitle,
    required this.route,
    this.onTap,
  });
}

List<Example> examples = [
  Example(
    title: "OTP TextField Example 1",
    subtitle: "Verification Screen 1",
    route: MaterialPageRoute(
      builder: (context) => VerificationScreen1(),
    ),
  ),
  Example(
    title: "OTP TextField Example 2",
    subtitle: "Verification Screen 2",
    route: MaterialPageRoute(
      builder: (context) => VerificationScreen2(),
    ),
  ),
  // Example(
  //   title: "OTP TextField Example 3",
  //   subtitle: "Verification Screen 3",
  //   route: MaterialPageRoute(
  //     builder: (context) => Test(),
  //   ),
  // ),
];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Examples"),
        ),
        body: ListView(
          children: [
            Builder(builder: (context) {
              return ListTile(
                title: Text(
                  examples[0].title,
                  style: TextStyle(fontSize: 18),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VerificationScreen1(),
                    ),
                  );
                },
              );
            }),
            Builder(
              builder: (context) {
                return ListTile(
                  title: Text(
                    examples[1].title,
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VerificationScreen2(),
                      ),
                    );
                  },
                );
              },
            ),
            // Builder(
            //   builder: (context) {
            //     return ListTile(
            //       title: Text(
            //         examples[2].title,
            //         style: TextStyle(fontSize: 18),
            //       ),
            //       onTap: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => Test(),
            //           ),
            //         );
            //       },
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  void nav(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VerificationScreen1(),
      ),
    );
  }
}

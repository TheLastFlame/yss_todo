import 'package:flutter/material.dart';
import 'package:yss_todo/constants.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text('Text'),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(appPadding),
                child: Card(
                    elevation: 2,
                    child: SizedBox(
                      height: 500,
                      width: MediaQuery.of(context).size.width,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'pages/particles/particles_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My art project'),
        ),
        body: const SafeArea(
          child: ListContentPage(),
        ),
      ),
    );
  }
}

class ListContentPage extends StatelessWidget {
  const ListContentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      children: [
        const CardItemWidget(
          name: 'Particles Section',
          description: 'Drawing particles and play with them',
          route: ParticlesPage(),
        )
      ],
    );
  }
}

class CardItemWidget extends StatelessWidget {
  const CardItemWidget({
    Key? key,
    required this.name,
    this.description = '',
    required this.route,
    this.isDone = true,
  }) : super(key: key);

  final String name;
  final String description;
  final Widget route;
  final bool isDone;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => route,
          ),
        );
      },
      child: Card(
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isDone ? Icons.done : Icons.build_rounded,
              color: Colors.white,
            ),
          ),
          title: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          subtitle: Text(
            description,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:art_project/views/cloud_particles_view.dart';
import 'package:art_project/views/cone_view.dart';
import 'package:flutter/material.dart';

import 'views/floating_particles_view.dart';
import 'views/moving_particles_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text('Material App Bar'),
        // ),
        body: ConeParticleView(),
      ),
    );
  }
}

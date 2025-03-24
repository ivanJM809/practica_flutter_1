import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class RedesScreen extends StatelessWidget {
  const RedesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_outlined),
        ),
        title: Text(
          'Contacta con nosotros',
          style: TextStyle(fontFamily: 'permanent_marker', fontSize: 25),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),

      body: Column(
        children: [
          Row(
            children: [
              Container(
                color: const Color.fromARGB(200, 154, 204, 228),
                height: 300,
                width: 300,
                margin: EdgeInsets.only(left: 650, top: 180),
                child: Column(
                  children: [
                    Text(
                      'Instagram',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'permanent_marker',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 60),
                    IconButton(
                      onPressed: () async {
                        final Uri url = Uri.parse('https://www.instagram.com/');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'No se encontro $url';
                        }
                      },
                      icon: Icon(
                        FontAwesomeIcons.instagram,
                        size: 80,
                        color: Colors.pink,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Container(
                color: const Color.fromARGB(200, 154, 204, 228),
                height: 300,
                width: 300,
                margin: EdgeInsets.only(top: 180),
                child: Column(
                  children: [
                    Text(
                      'Facebook',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'permanent_marker',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 60),
                    IconButton(
                      onPressed: () async {
                        final Uri url = Uri.parse('https://www.facebook.com/?locale=es_LA');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'No se encontro $url';
                        }
                      },
                      icon: Icon(
                        FontAwesomeIcons.facebook,
                        size: 80,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                color: const Color.fromARGB(200, 154, 204, 228),
                height: 300,
                width: 300,
                margin: EdgeInsets.only(left: 650, top: 10),
                child: Column(
                  children: [
                    Text(
                      'Tik Tok',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'permanent_marker',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 60),
                    IconButton(
                      onPressed: () async {
                        final Uri url = Uri.parse('https://www.tiktok.com/login?lang=es&redirect_url=https%3A%2F%2Fwww.tiktok.com%2Fupload%3Flang%3Des');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'No se encontro $url';
                        }
                      },
                      icon: Icon(
                        FontAwesomeIcons.tiktok,
                        size: 80,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Container(
                color: const Color.fromARGB(200, 154, 204, 228),
                height: 300,
                width: 300,
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Text(
                      'Correo electronico',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'permanent_marker',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 60),
                    IconButton(
                      onPressed: () async {
                        final Uri url = Uri.parse('https://workspace.google.com/intl/es/gmail/');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'No se encontro $url';
                        }
                      },
                      icon: Icon(
                        FontAwesomeIcons.envelope,
                        size: 80,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

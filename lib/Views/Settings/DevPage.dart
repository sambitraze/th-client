import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class DevPage extends StatefulWidget {
  @override
  _DevPageState createState() => _DevPageState();
}

class _DevPageState extends State<DevPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Our Developers',
          style: GoogleFonts.nunito(
              fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/dev.png",
              height: 250,
            ),
            Container(
                // height: 350,
                child: CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 0.9,
                viewportFraction: 1,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                autoPlay: true,
              ),
              items: [devCard1(), devCard2()],
            )),
          ],
        ),
      ),
    );
  }

  devCard2() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Colors.purple.shade200,
        child: Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 75,
                  backgroundColor: Colors.purple.shade100.withOpacity(0.5),
                  child: CircleAvatar(
                    radius: 65,
                    backgroundImage: AssetImage("assets/dev2.png"),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Utkarsh Udit",
                    style: GoogleFonts.nunito(
                      fontSize: 24,
                      color: Colors.purple.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "UI/UX Developer",
                    style: GoogleFonts.nunito(
                      fontSize: 20,
                      color: Colors.purple.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      InkWell(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 18,
                          child: Image.asset(
                            "assets/gmail.png",
                            height: 20,
                          ),
                        ),
                        onTap: () async {
                          const uri =
                              'mailto:utkarshudit001@gmail.com?subject=Reach Utkarsh&body=';
                          if (await canLaunch(uri)) {
                            await launch(uri);
                          } else {
                            throw 'Could not launch $uri';
                          }
                        },
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 18,
                          child: Image.asset(
                            "assets/linkedin.png",
                            height: 20,
                          ),
                        ),
                        onTap: () async {
                          const uri =
                              'https://www.linkedin.com/in/utkarsh-udit-396b741a3/';
                          if (await canLaunch(uri)) {
                            await launch(uri);
                          } else {
                            throw 'Could not launch $uri';
                          }
                        },
                      ),
                    ],
                    mainAxisSize: MainAxisSize.min,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  devCard1() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Colors.cyan.shade200,
        child: Container(
          height: 320,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 75,
                  backgroundColor: Colors.cyan.shade100.withOpacity(0.5),
                  child: CircleAvatar(
                    radius: 65,
                    backgroundImage: AssetImage("assets/dev1.png"),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Sambit Majhi",
                    style: GoogleFonts.nunito(
                      fontSize: 24,
                      color: Colors.cyan.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Full-Stack Developer",
                    style: GoogleFonts.nunito(
                      fontSize: 20,
                      color: Colors.cyan.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      InkWell(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 18,
                          child: Image.asset(
                            "assets/gmail.png",
                            height: 20,
                          ),
                        ),
                        onTap: () async {
                          const uri =
                              'mailto:majhisambit2@gmail.com?subject=Reach Sambit&body=';
                          if (await canLaunch(uri)) {
                            await launch(uri);
                          } else {
                            throw 'Could not launch $uri';
                          }
                        },
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 18,
                          child: Image.asset(
                            "assets/linkedin.png",
                            height: 20,
                          ),
                        ),
                        onTap: () async {
                          const uri = 'https://www.linkedin.com/in/sambitraze/';
                          if (await canLaunch(uri)) {
                            await launch(uri);
                          } else {
                            throw 'Could not launch $uri';
                          }
                        },
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 18,
                          child: Image.asset(
                            "assets/github.png",
                            height: 20,
                          ),
                        ),
                        onTap: () async {
                          const uri = 'https://github.com/sambitraze';
                          if (await canLaunch(uri)) {
                            await launch(uri);
                          } else {
                            throw 'Could not launch $uri';
                          }
                        },
                      ),
                    ],
                    mainAxisSize: MainAxisSize.min,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

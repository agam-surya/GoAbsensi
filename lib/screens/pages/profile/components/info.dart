import 'package:flutter/material.dart';
import 'package:flutter_api_test/common/common.dart';
import 'package:flutter_api_test/size_config.dart';

class Info extends StatelessWidget {
  const Info({
    required this.name,
    required this.position,
    required this.image,
  });
  final String name, position;
  final Widget image;

  @override
  Widget build(BuildContext context) {
    double? defaultSize = SizeConfig.defaultSize;
    return SizedBox(
      height: defaultSize! * 32, // 320
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: CustomShape(),
            child: Container(
              height: defaultSize * 25, //250
              color: primaryColor,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      // margin: EdgeInsets.only(bottom: defaultSize), //10
                      height: defaultSize * 18, //140
                      width: defaultSize * 18,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: screenColor,
                            width: defaultSize * 0.8, //8
                          ),
                          ),
                          child: image,
                    ),
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: defaultSize * 2.2, // 22
                        color: darkColor,
                      ),
                    ),
                    SizedBox(height: defaultSize / 2), //5
                    Text(
                      position,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF8492A2),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(width / 2, height, width, height - 100);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

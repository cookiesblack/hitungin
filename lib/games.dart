import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class GamesRoute extends StatelessWidget {
  const GamesRoute({super.key});

  static const List<String> sampleImages = [
    'https://img.freepik.com/free-vector/game-template-rural-farm-background_1308-114544.jpg?w=826&t=st=1698729490~exp=1698730090~hmac=7d3d16c63deed0c8d9660b3dfbea7b188166983070747cf28efa98bd0d670c2f',
    'https://img.freepik.com/premium-photo/cartoon-style-video-game-scene-with-mushroom-island-flying-birds-generative-ai_958098-12781.jpg?w=1060',
    'https://img.freepik.com/free-vector/retro-pixel-space-game-interface_1308-84574.jpg?w=1060&t=st=1698729349~exp=1698729949~hmac=f86f389e98da593e0eb3a52a8ef9218f8be67277bda0ad0a8a635358f644fcb5',
    'https://img.freepik.com/premium-vector/game-ui-game-asset-design-casual-game-ui-kit-menus-pop-up-screens-game-elements-premium-vector_667090-5.jpg?w=740',
    'https://img.freepik.com/free-vector/cartoon-style-stone-game-menu_52683-80238.jpg?w=1800&t=st=1698729570~exp=1698730170~hmac=00d0b531eb1161503dfa85d2a4152398e371b4319c06e240c6b3cc3b84c9bdb1'
    // 'https://img.freepik.com/free-photo/lovely-woman-vintage-outfit-expressing-interest-outdoor-shot-glamorous-happy-girl-sunglasses_197531-11312.jpg?w=1800&t=st=1673886721~exp=1673887321~hmac=57318aa37912a81d9c6e8f98d4e94fb97a766bf6161af66488f4d890f88a3109',
    // 'https://img.freepik.com/free-photo/attractive-curly-woman-purple-cashmere-sweater-fuchsia-sunglasses-poses-isolated-wall_197531-24158.jpg?w=1800&t=st=1673886680~exp=1673887280~hmac=258c92922874ad41d856e7fdba03ce349556cf619de4074143cec958b5b4cf05',
    // 'https://img.freepik.com/free-photo/stylish-blonde-woman-beret-beautiful-french-girl-jacket-standing-red-wall_197531-14428.jpg?w=1800&t=st=1673886821~exp=1673887421~hmac=5e77d3fab088b29a3b19a9023289fa95c1dc2af15565f290886bab4642fa2621',
    // 'https://img.freepik.com/free-photo/pretty-young-girl-with-pale-skin-dark-hair-french-beret-sunglasses-polka-dot-skirt-white-top-red-shirt-walking-around-sunny-city-laughing_197531-24480.jpg?w=1800&t=st=1673886800~exp=1673887400~hmac=9a1c61de63180118c5497ce105bbb36bfbb53050111de466d5110108848f2128',
    // 'https://img.freepik.com/free-photo/elegant-woman-brown-coat-spring-city_1157-33434.jpg?w=1800&t=st=1673886830~exp=1673887430~hmac=cc8c28a9332e008db251bdf9c7b838b7aa5077ec7663773087a8cc56d11138ff',
    // 'https://img.freepik.com/free-photo/high-fashion-look-glamor-closeup-portrait-beautiful-sexy-stylish-blond-young-woman-model-with-bright-yellow-makeup-with-perfect-clean-skin-with-gold-jewelery-black-cloth_158538-2003.jpg?w=826&t=st=1673886857~exp=1673887457~hmac=3ba51578e6a1e9c58e95a6b72e492cbbc26abf8e2f116a0672113770d3f4edbe',
  ];

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Material(
        color: const Color.fromARGB(0, 255, 255, 255),
        shadowColor: const Color(0x802196F3),
        child: CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(),
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Vertically center the children
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 90,
                      ),
                      Text(
                        'Games in App',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            color: HexColor("#000"),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      FanCarouselImageSlider(
                        imagesLink: sampleImages,
                        isAssets: false,
                        autoPlay: true,
                      ),
                    ],
                  ),
                ),
              ],
            ))));
  }
}

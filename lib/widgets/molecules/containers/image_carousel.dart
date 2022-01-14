import 'package:carousel_slider/carousel_slider.dart';
import 'package:donor_app/const/constants.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class ImageCarousel extends StatefulWidget {
  final List<String> imgList;
  const ImageCarousel({
    Key? key,
    required this.imgList
  }) : super(key: key);

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          CarouselSlider.builder(
            itemCount: widget.imgList.length,
            itemBuilder: (ctx, index, realIndex) {
              final image = widget.imgList[index];
              return buildImage(image, index);
            },
            options: CarouselOptions(

                height: 180,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 8),
                //viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                }
            ),

          ),

          Positioned.fill(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: dotIndicator(),
                )),
          )

        ]
    );
  }


  Widget buildImage(String url, int index){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        //color: Colors.grey

      ),

      child: Image.asset(url,fit: BoxFit.fill,),
    );
  }

  Widget dotIndicator(){
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: widget.imgList.length,
      effect: SlideEffect(
          dotHeight: 10,
          dotWidth: 10,
          activeDotColor: Constants.appColorBrownRed,
          dotColor: Colors.grey
      ),
    );
  }
}
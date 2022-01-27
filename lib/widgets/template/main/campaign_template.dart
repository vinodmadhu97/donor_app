import 'package:donor_app/widgets/molecules/containers/campaign_card_view.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';

class CampaignTemplate extends StatelessWidget {
  const CampaignTemplate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
        title: Text("Campaigns"),
        curvedBodyRadius: 0,
        headerExpandedHeight: 0.3,
        fullyStretchable: false,

        headerWidget: _buildHeader(context),
        body: _buildBody()
    );


  }

  Widget _buildHeader(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 16.0,right: 16,bottom: 16,top: 40),
      child: Container(

        margin: EdgeInsets.symmetric(horizontal: 6),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.3,
        //color: Colors.grey,
        decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage("assets/images/poster-2.jpg"),
              fit: BoxFit.cover,

            )
        ),
        //child: Image.asset(url,fit: BoxFit.cover,),
      ),
    );
  }

  List<Widget> _buildBody(){
    return [
      ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (ctx,index)=>Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
          child: CampaignCardView(
            title: "Kalubowila Hospital",
            imgUrl: "assets/images/campaign-1.jpg",
            location: "B229 Hospital Rd, Dehiwala-Mount Lavinia",
            time: "2022/02/04 \nat 8.00 am - 2.00 pm",
          ),
        ),
      )
    ];
  }
}

import 'package:donor_app/widgets/molecules/containers/request_card_view.dart';
import 'package:flutter/material.dart';

class RequestTemplate extends StatelessWidget {
  const RequestTemplate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Requests"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.sort))
        ],
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (ctx, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: RequestCardView(),
              )),
    );
  }
}

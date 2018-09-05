import 'package:flutter/material.dart';
import './home_data.dart';
import './home_page_item.dart';
import './homepage_transformer.dart';
import '../widgets.dart';

class HomePageView extends StatelessWidget {

  final GlobalKey<ScaffoldState> _appBarKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _appBarKey,
      drawer: Widgets(),
      body: Stack(
      children: <Widget>[
        Center(
          child: SizedBox.fromSize(
            size:const Size.fromHeight(500.0),
            child: PageTransformer(
              pageViewBuilder: (context, visibilityResolver) {
                return PageView.builder(
                  controller: PageController(viewportFraction: 0.90),
                  itemCount: sampleItems.length,
                  itemBuilder: (context, index) {
                    final item = sampleItems[index];
                    final pageVisibility =
                        visibilityResolver.resolvePageVisibility(index);

                    return HomePageItem(
                      item: item,
                      pageVisibility: pageVisibility,
                    );
                  },
                );
              },
            ),
          ),
        ),
        Container (
            margin: EdgeInsets.fromLTRB(4.0, 28.0, 0.0, 0.0),
            child: new IconButton(
              icon: Icon(Icons.menu)
              ,
              color: Colors.white,
              onPressed: () => _appBarKey.currentState.openDrawer(),
            )
        )
      ]
      )
    );
  }
}

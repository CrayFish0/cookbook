import 'package:cookbook/util/cuisine_tile.dart';
import 'package:cookbook/util/global.dart';
import 'package:cookbook/util/recommend_tile.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    //List<List<String>> a = [];
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        //Logo initialisation
        title: Image.asset(
          "assets/Logo.png",
          width: 120,
          height: 120,
        ),
        //curved edges
        elevation: 3,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(12),
        )),
        //colour initialization
        backgroundColor: const Color.fromRGBO(177, 255, 199, 1),
        shadowColor: const Color.fromRGBO(102, 180, 124, 1),
      ),
        body: Padding(
            padding: const EdgeInsets.all(0),
            child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'TODAYS TOP PICKS',
                      style: TextStyle(
                          fontSize: 28,
                          fontFamily: 'Ariel',
                          color: Color.fromRGBO(0, 70, 20, 1)),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                      height: (MediaQuery.of(context).size.width - 60),
                      child: ListView.builder(
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final result = data?['recipes'];
                            final resultId = result[index]['id'];
                            final name = result[index]['title'];
                            final image = result[index]['image'] ?? 'No Image';
                            return RecommendTile(
                              id: resultId,
                              image: image,
                              title: name,
                            );
                          })),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'CUISINE',
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Ariel',
                          color: Color.fromRGBO(0, 70, 20, 1)),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: SizedBox(
                        height: (MediaQuery.of(context).size.width / 2.9),
                        child: CustomScrollView(
                          scrollDirection: Axis.horizontal,
                          slivers: [
                            SliverGrid(
                                delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                  return CuisineTile(
                                      cuisineName: cuisineItems[index]);
                                }, childCount: cuisineItems.length),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 16,
                                        crossAxisSpacing: 16,
                                        childAspectRatio: 0.41))
                          ],
                        )),
                  ),
                ])));
  }
}
//Text color 0 50 14
//'African','Asian','American','British','Cajun','Caribbean','Chinese','Eastern European','European','French','German','Greek','Indian','Irish','Italian','Japanese','Jewish','Korean','Latin American','Mediterranean','Mexican','Middle Eastern','Nordic','Southern','Spanish','Thai','Vietnamese'
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book/models/recipe.dart';
import 'package:recipe_book/pages/recipe_page.dart';
import 'package:recipe_book/services/data_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _mealTypeFilter="";

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(
          "Recipe Book",
        ),
        centerTitle: true,
      ) ,
      body: SafeArea(
          child: _UI()
      ),
    );
  }

  Widget _UI(){
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [

          _recipeType(),
          _recipesList(),
        ],
      ),
    );
  }

  Widget _recipeType(){
    return SizedBox(
      height: MediaQuery.sizeOf(context).height*0.05,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: (){
                setState(() {
                  _mealTypeFilter="snack";
                });
              },
              child: const Text("🍕 Snack"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: (){
                setState(() {
                  _mealTypeFilter="breakfast";
                });
              },
              child: const Text("🍛 Breakfast"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: (){
                setState(() {
                  _mealTypeFilter="lunch";
                });
              },
              child: const Text("🍗 Lunch"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: (){
                setState(() {
                  _mealTypeFilter="dinner";
                });
              },
              child: const Text("🍜 Dinner"),
            ),
          ),

        ],
      ),
    );
  }

  Widget _recipesList(){
    return Expanded(
        child:FutureBuilder(
          future: DataService().getRecipe(_mealTypeFilter),
          builder:(context,snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),
              );
            }
            if(snapshot.hasError){
              return const Center(
                child: Text("Unable to load data"),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
                itemBuilder:(context,index){
                Recipe recipe=snapshot.data![index];
                  return ListTile(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context){
                            return RecipePage(
                              recipe: recipe,
                            );
                          }));
                    },
                    contentPadding: const EdgeInsets.only(
                      top: 20.0,
                    ),

                    isThreeLine: true,
                    leading: Image.network(recipe.image),
                    subtitle: Text("${recipe.cuisine}\nDifficulty: ${recipe.difficulty}"),
                    title: Text(
                      recipe.name,
                    ),
                    trailing:  Text("${recipe.rating.toString()}⭐",
                    style:  TextStyle(
                      fontSize: 15,
                    ),),
                  );
                });
          },
        )
    );
  }
}

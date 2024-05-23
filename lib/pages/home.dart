import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book/services/data_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
    return Container(
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
              onPressed: (){},
              child: const Text("🍕 Snack"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: (){},
              child: const Text("🍛 Breakfast"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: (){},
              child: const Text("🍗 Lunch"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: (){},
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
          future: DataService().getRecipe(),
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
            return Container();
          },)
    );
  }
}

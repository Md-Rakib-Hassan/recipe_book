import 'package:recipe_book/models/recipe.dart';
import 'package:recipe_book/services/http_service.dart';

class DataService {
  static final DataService _singleton = DataService._internal();
  final HTTPService _httpService=HTTPService();


  factory DataService(){
    return _singleton;
  }
  DataService._internal();

  Future<List<Recipe>?>getRecipe() async{
    String path="recipes/";
    var response = await _httpService.get(path);
    if(response?.data != null && response?.statusCode==200){
      List data= response!.data["recipes"];
      List<Recipe>recipes=data.map((e) => Recipe.fromJson(e)).toList();
      print(recipes);
      return recipes;
    }
  }

}
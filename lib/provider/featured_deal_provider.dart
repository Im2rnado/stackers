import 'package:flutter/material.dart';
import 'package:stackers/data/model/response/base/api_response.dart';
import 'package:stackers/data/repository/featured_deal_repo.dart';
import 'package:stackers/data/model/response/product_model.dart';
import 'package:stackers/helper/api_checker.dart';

class FeaturedDealProvider extends ChangeNotifier {
  final FeaturedDealRepo featuredDealRepo;

  FeaturedDealProvider({@required this.featuredDealRepo});

  int _featuredDealSelectedIndex;
  List<Product> _featuredDealProductList =[];
  List<Product> get featuredDealProductList =>_featuredDealProductList;
  int get featuredDealSelectedIndex => _featuredDealSelectedIndex;

  Future<void> getFeaturedDealList(bool reload, BuildContext context) async {



      ApiResponse apiResponse = await featuredDealRepo.getFeaturedDeal();
      if (apiResponse.response != null && apiResponse.response.statusCode == 200 && apiResponse.response.data.toString() != '{}') {
        _featuredDealProductList =[];
        print('----rrr--->${apiResponse.response.data.toString()}');
        apiResponse.response.data.forEach((fDeal) => _featuredDealProductList.add(Product.fromJson(fDeal)));
        _featuredDealSelectedIndex = 0;
      } else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();

  }

  void changeSelectedIndex(int selectedIndex) {
    _featuredDealSelectedIndex = selectedIndex;
    notifyListeners();
  }
}

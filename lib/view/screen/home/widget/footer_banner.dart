import 'package:flutter/material.dart';
import 'package:stackers/data/model/response/product_model.dart';
import 'package:stackers/provider/banner_provider.dart';
import 'package:stackers/provider/brand_provider.dart';
import 'package:stackers/provider/category_provider.dart';
import 'package:stackers/provider/splash_provider.dart';
import 'package:stackers/provider/top_seller_provider.dart';
import 'package:stackers/utill/images.dart';
import 'package:stackers/view/screen/product/brand_and_category_product_screen.dart';
import 'package:stackers/view/screen/product/product_details_screen.dart';
import 'package:stackers/view/screen/topSeller/top_seller_product_screen.dart';
import 'package:provider/provider.dart';
class FooterBannersView extends StatelessWidget {
  final int index;
  const FooterBannersView({Key key, this.index}) : super(key: key);

  _clickBannerRedirect(BuildContext context, int id, Product product,  String type){

    final cIndex =  Provider.of<CategoryProvider>(context, listen: false).categoryList.indexWhere((element) => element.id == id);
    final bIndex =  Provider.of<BrandProvider>(context, listen: false).brandList.indexWhere((element) => element.id == id);
    final tIndex =  Provider.of<TopSellerProvider>(context, listen: false).topSellerList.indexWhere((element) => element.id == id);


    if(type == 'category'){
      if(Provider.of<CategoryProvider>(context, listen: false).categoryList[cIndex].name != null){
        Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
          isBrand: false,
          id: id.toString(),
          name: '${Provider.of<CategoryProvider>(context, listen: false).categoryList[cIndex].name}',
        )));
      }

    }else if(type == 'product'){
      Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetails(
        productId: product.id,slug: product.slug,
      )));

    }else if(type == 'brand'){
      if(Provider.of<BrandProvider>(context, listen: false).brandList[bIndex].name != null){
        Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
          isBrand: true,
          id: id.toString(),
          name: '${Provider.of<BrandProvider>(context, listen: false).brandList[bIndex].name}',
        )));
      }

    }else if( type == 'shop'){
      if(Provider.of<TopSellerProvider>(context, listen: false).topSellerList[tIndex].name != null){
        Navigator.push(context, MaterialPageRoute(builder: (_) => TopSellerProductScreen(
          topSellerId: id,
          topSeller: Provider.of<TopSellerProvider>(context,listen: false).topSellerList[tIndex],
        )));
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
    Consumer<BannerProvider>(
    builder: (context, footerBannerProvider, child) {

      return InkWell(
        onTap: () {
          _clickBannerRedirect(context,
              footerBannerProvider.footerBannerList[index].resourceId,
              footerBannerProvider.footerBannerList[index].resourceType =='product'?
              footerBannerProvider.footerBannerList[index].product : null,
              footerBannerProvider.footerBannerList[index].resourceType);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width/2.2,
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5))),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: FadeInImage.assetNetwork(
                placeholder: Images.placeholder, fit: BoxFit.cover,
                image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls.bannerImageUrl}'
                    '/${footerBannerProvider.footerBannerList[index].photo}',
                imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, fit: BoxFit.cover),
              ),
            ),
          ),
        ),
      );

    },
    ),
      ],
    );
  }


}


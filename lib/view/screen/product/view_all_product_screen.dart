import 'package:flutter/material.dart';
import 'package:stackers/helper/product_type.dart';

import 'package:stackers/provider/theme_provider.dart';
import 'package:stackers/utill/color_resources.dart';
import 'package:stackers/utill/custom_themes.dart';
import 'package:stackers/utill/dimensions.dart';
import 'package:stackers/view/screen/home/widget/products_view.dart';
import 'package:provider/provider.dart';

class AllProductScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final ProductType productType;
  AllProductScreen({@required this.productType});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorResources.getHomeBg(context),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Provider.of<ThemeProvider>(context).darkTheme ?
        Colors.black : Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(5), bottomLeft: Radius.circular(5))),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios, size: 20,
            color: ColorResources.WHITE),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(productType == ProductType.FEATURED_PRODUCT ?
        'Featured Product':'Latest Product',
            style: titilliumRegular.copyWith(fontSize: 20, color: ColorResources.WHITE)),
      ),

      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {
            return true;
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(

                child: Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: ProductView(isHomePage: false , productType: productType, scrollController: _scrollController),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

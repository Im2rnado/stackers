
import 'package:flutter/material.dart';
import 'package:stackers/data/model/response/order_details.dart';
import 'package:stackers/data/model/response/product_model.dart';
import 'package:stackers/helper/price_converter.dart';
import 'package:stackers/localization/language_constrants.dart';
import 'package:stackers/provider/order_provider.dart';
import 'package:stackers/provider/splash_provider.dart';
import 'package:stackers/utill/app_constants.dart';
import 'package:stackers/utill/color_resources.dart';
import 'package:stackers/utill/custom_themes.dart';
import 'package:stackers/utill/dimensions.dart';
import 'package:stackers/utill/images.dart';
import 'package:stackers/view/basewidget/custom_app_bar.dart';
import 'package:stackers/view/basewidget/image_diaglog.dart';
import 'package:provider/provider.dart';

class RefundResultBottomSheet extends StatefulWidget {
  final Product product;
  final int orderDetailsId;
  final OrderDetailsModel orderDetailsModel;
  RefundResultBottomSheet({@required this.product, @required this.orderDetailsId, this.orderDetailsModel});

  @override
  _RefundResultBottomSheetState createState() => _RefundResultBottomSheetState();
}

class _RefundResultBottomSheetState extends State<RefundResultBottomSheet> {

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    Provider.of<OrderProvider>(context, listen: false).getRefundResult(context, widget.orderDetailsId);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(title: getTranslated('refund_details', context)),
            SingleChildScrollView(
              child: Consumer<OrderProvider>(builder: (context,refundReq,_) {
                return Padding(padding: mediaQueryData.viewInsets, child: Container(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  decoration: BoxDecoration(
                    color: Theme.of(context).highlightColor,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20),
                        topLeft: Radius.circular(20)),),
                  child: Column(mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start, children: [
                        refundReq.refundResultModel != null && refundReq.refundResultModel.refundRequest != null?
                        Text('${getTranslated('refund_id', context)}'+
                            refundReq.refundResultModel.refundRequest.first.id.toString(),
                          style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,
                              color: ColorResources.getTextTitle(context)),
                          maxLines: 2, overflow: TextOverflow.ellipsis,):SizedBox(),


                        Row(mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center, children: [
                          Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: Container( width: 70,height: 70,
                              child: FadeInImage.assetNetwork(
                                placeholder: Images.placeholder,
                                height: MediaQuery.of(context).size.width, width: MediaQuery.of(context).size.width,
                                image: '${Provider.of<SplashProvider>(context,listen: false).
                                baseUrls.productThumbnailUrl}/${widget.product.thumbnail}',
                                imageErrorBuilder: (c, o, s) => Image.asset(
                                  Images.placeholder, height: MediaQuery.of(context).size.width,
                                  width: MediaQuery.of(context).size.width,),),),),


                            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                              children: [Text(widget.product.name,
                                style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL,
                                    color: Theme.of(context).hintColor),
                                maxLines: 2, overflow: TextOverflow.ellipsis,),


                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                  Text(PriceConverter.convertPrice(context, widget.orderDetailsModel.price),
                                    style: titilliumSemiBold.copyWith(color: ColorResources.getPrimary(context)),),


                                  Text('x${widget.orderDetailsModel.qty}',
                                        style: titilliumSemiBold.copyWith(color: ColorResources.getPrimary(context))),


                                  widget.orderDetailsModel.discount>0?
                                  Container(height: 20, alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: ColorResources.getPrimary(context))),



                                    child: Text(PriceConverter.percentageCalculation(context,
                                        (widget.orderDetailsModel.price * widget.orderDetailsModel.qty),
                                        widget.orderDetailsModel.discount, 'amount'),
                                      style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                          color: ColorResources.getPrimary(context)),),):SizedBox(),],),


                                (widget.orderDetailsModel.variant != null && widget.orderDetailsModel.variant.isNotEmpty) ?
                                Padding(padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                                    SizedBox(width: 65),


                                    Text('${getTranslated('variations', context)}: ',
                                          style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),

                                    Text(widget.orderDetailsModel.variant,
                                        style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL,
                                          color: Theme.of(context).disabledColor,)),]),) : SizedBox(),
                              ],),),],),
                        Divider(thickness: .1),


                        Consumer<OrderProvider>(builder: (context, refund,_) {
                          return refund.refundResultModel!=null && refund.refundResultModel.refundRequest != null ?
                          Padding(padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                              RichText(text: TextSpan(text: '', style: DefaultTextStyle.of(context).style, children: <TextSpan>[
                                TextSpan(text: getTranslated('total_price', context),
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: PriceConverter.convertPrice(context,
                                    refund.refundInfoModel.refund.productPrice*refund.refundInfoModel.refund.quntity ),
                                    style: TextStyle(fontWeight: FontWeight.w200)),],),),



                              RichText(text: TextSpan(text: '', style: DefaultTextStyle.of(context).style, children: <TextSpan>[
                                TextSpan(text: getTranslated('product_discount', context),
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: PriceConverter.convertPrice(context,
                                    refund.refundInfoModel.refund.productTotalDiscount),
                                    style: TextStyle(fontWeight: FontWeight.w200)),],),),


                              RichText(text: TextSpan(text: '', style: DefaultTextStyle.of(context).style, children: <TextSpan>[
                                TextSpan(text: getTranslated('tax', context), style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: PriceConverter.convertPrice(context,
                                    refund.refundInfoModel.refund.productTotalTax),
                                    style: TextStyle(fontWeight: FontWeight.w200)),],),),


                              RichText(text: TextSpan(text: '', style: DefaultTextStyle.of(context).style, children: <TextSpan>[
                                TextSpan(text: getTranslated('sub_total', context),
                                    style: TextStyle(fontWeight: FontWeight.bold)),

                                TextSpan(text: PriceConverter.convertPrice(context,
                                    refund.refundInfoModel.refund.subtotal),
                                    style: TextStyle(fontWeight: FontWeight.w200)),],),),


                              RichText(text: TextSpan(text: '', style: DefaultTextStyle.of(context).style, children: <TextSpan>[
                                TextSpan(text: getTranslated('coupon_discount', context),
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: PriceConverter.convertPrice(context,
                                    refund.refundInfoModel.refund.couponDiscount),
                                    style: TextStyle(fontWeight: FontWeight.w200)),],),),




                              RichText(text: TextSpan(text: '', style: DefaultTextStyle.of(context).style, children: <TextSpan>[
                                TextSpan(text: getTranslated('total_refund_amount', context),
                                    style: TextStyle(fontWeight: FontWeight.bold)),

                                TextSpan(text: PriceConverter.convertPrice(context,
                                    refund.refundInfoModel.refund.refundAmount),
                                    style: TextStyle(fontWeight: FontWeight.w200)),],),),
                              Divider(),



                              RichText(text: TextSpan(text: '', style: DefaultTextStyle.of(context).style, children: <TextSpan>[
                                TextSpan(text: getTranslated('refund_status', context),
                                    style: TextStyle(fontWeight: FontWeight.bold)),



                                TextSpan(text: refund.refundResultModel.refundRequest[0].status,
                                    style: TextStyle(fontWeight: FontWeight.w200)),],),),



                              refund.refundResultModel.refundRequest[0].approvedNote != null?
                              RichText(text: TextSpan(text: '', style: DefaultTextStyle.of(context).style, children: <TextSpan>[
                                TextSpan(text: getTranslated('approved_note', context),
                                    style: TextStyle(fontWeight: FontWeight.bold)),


                                TextSpan(text: ' : ', style: TextStyle(fontWeight: FontWeight.w200)),

                                TextSpan(text: refund.refundResultModel.refundRequest[0].approvedNote,
                                    style: TextStyle(fontWeight: FontWeight.w200)),],),):SizedBox(),




                              refund.refundResultModel.refundRequest[0].rejectedNote != null?
                              RichText(text: TextSpan(text: '', style: DefaultTextStyle.of(context).style, children: <TextSpan>[
                                TextSpan(text: getTranslated('rejected_note', context),
                                    style: TextStyle(fontWeight: FontWeight.bold)),


                                TextSpan(text: ' : ', style: TextStyle(fontWeight: FontWeight.w200)),
                                TextSpan(text: refund.refundResultModel.refundRequest[0].rejectedNote,
                                    style: TextStyle(fontWeight: FontWeight.w200)),],),):SizedBox(),




                              refund.refundResultModel.refundRequest[0].paymentInfo != null?
                              Text('${getTranslated('payment_info', context)} : '
                                  '${refund.refundResultModel.refundRequest[0].paymentInfo}',
                                  style: titilliumSemiBold.copyWith(
                                      color: ColorResources.getHint(context), fontSize: 12)):SizedBox(),
                              Divider(),



                              RichText(text: TextSpan(text: '', style: DefaultTextStyle.of(context).style, children: <TextSpan>[
                                TextSpan(text:  getTranslated('refund_reason', context),
                                    style: TextStyle(fontWeight: FontWeight.w700)),
                                TextSpan(text: refund.refundResultModel.refundRequest[0].refundReason,
                                    style: TextStyle(fontWeight: FontWeight.w200)),],),),



                              (refund.refundResultModel.refundRequest[0].images != null &&
                                  refund.refundResultModel.refundRequest[0].images.length>0)?
                              Text(getTranslated('attachment', context),
                                style: TextStyle(decoration: TextDecoration.underline),):SizedBox(),



                              (refund.refundResultModel.refundRequest[0].images != null &&
                                  refund.refundResultModel.refundRequest[0].images.length>0)?
                              Container(height: 100,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount:  refund.refundResultModel.refundRequest[0].images.length,
                                  itemBuilder: (BuildContext context, index){
                                    return  refund.refundResultModel.refundRequest[0].images.length > 0?
                                    Padding(padding: const EdgeInsets.all(8.0),
                                      child: Stack(children: [
                                        InkWell(
                                          onTap: () => showDialog(context: context, builder: (ctx) =>
                                              ImageDialog(imageUrl:'${AppConstants.BASE_URL}/storage/app/public/refund/'
                                                  '${refund.refundResultModel.refundRequest[0].images[index]}'), ),
                                          child: Container(width: 100, height: 100,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_DEFAULT)),
                                              child: FadeInImage.assetNetwork(placeholder: Images.placeholder,
                                                image: '${AppConstants.BASE_URL}/storage/app/public/refund/'
                                                    '${refund.refundResultModel.refundRequest[0].images[index]}',
                                                width: 100, height: 100, fit: BoxFit.cover,
                                                imageErrorBuilder: (c,o,x)=> Image.asset(Images.placeholder),),) ,
                                            decoration: BoxDecoration(
                                              color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20)),
                                            ),
                                          ),
                                        ),
                                      ],),):SizedBox();
                                    },),):SizedBox()
                            ]),):SizedBox();
                        }),

                      ]),
                ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}



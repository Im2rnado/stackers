import 'package:flutter/material.dart';
import 'package:stackers/data/model/response/order_model.dart';
import 'package:stackers/localization/language_constrants.dart';
import 'package:stackers/provider/order_provider.dart';
import 'package:stackers/utill/color_resources.dart';
import 'package:stackers/utill/custom_themes.dart';
import 'package:stackers/utill/dimensions.dart';
import 'package:stackers/view/basewidget/button/custom_button.dart';
import 'package:stackers/view/screen/support/support_ticket_screen.dart';
import 'package:stackers/view/screen/tracking/tracking_screen.dart';
import 'package:provider/provider.dart';

class CancelAndSupport extends StatelessWidget {
  final OrderModel orderModel;
  final bool fromNotification;
  const CancelAndSupport({Key key, this.orderModel, this.fromNotification = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_SMALL,
          vertical: Dimensions.PADDING_SIZE_SMALL),
      child: Row(children: [Expanded(child: orderModel != null &&
          orderModel.orderStatus =='pending' && orderModel.orderType != "POS" || fromNotification?

      CustomButton(buttonText: getTranslated('cancel_order', context),
          onTap: () => Provider.of<OrderProvider>(context,listen: false).cancelOrder(context, orderModel.id).then((value) {
            if(value.response.statusCode == 200){
              Provider.of<OrderProvider>(context, listen: false).initOrderList(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(getTranslated('order_cancelled_successfully', context)),
                backgroundColor: Colors.green,));
            }
          })) :

      CustomButton(buttonText: getTranslated('TRACK_ORDER', context),
        onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => TrackingScreen(orderID: orderModel.id.toString()))),),),
        SizedBox(width: Dimensions.PADDING_SIZE_SMALL),


        Expanded(child: SizedBox(height: 45,
          child: TextButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SupportTicketScreen())),
            child: Text(getTranslated('SUPPORT_CENTER', context),
              style: titilliumSemiBold.copyWith(fontSize: 16, color: ColorResources.getPrimary(context)),),
            style: TextButton.styleFrom(shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
              side: BorderSide(color: ColorResources.getPrimary(context)),
            )),
          ),
        ),
        ),
      ],
      ),
    );
  }
}

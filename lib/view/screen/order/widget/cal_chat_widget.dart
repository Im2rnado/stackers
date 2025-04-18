
import 'package:flutter/material.dart';
import 'package:stackers/data/model/response/order_model.dart';
import 'package:stackers/provider/chat_provider.dart';
import 'package:stackers/provider/order_provider.dart';
import 'package:stackers/utill/dimensions.dart';
import 'package:stackers/utill/images.dart';
import 'package:stackers/view/screen/chat/chat_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CallAndChatWidget extends StatelessWidget {
  final OrderProvider orderProvider;
  final OrderModel orderModel;
  final bool isSeller;
  const CallAndChatWidget({Key key, this.orderProvider, this.isSeller = false, this.orderModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String phone = isSeller? orderProvider.orderDetails[0].seller.phone : orderModel.deliveryMan.phone;
    String name = isSeller? orderProvider.orderDetails[0].seller.shop.name : orderModel.deliveryMan.fName+' '+orderModel.deliveryMan.lName;
    int id =  isSeller ? orderProvider.orderDetails[0].seller.id : orderModel.deliveryMan.id;
    return Row(children: [
      InkWell(
        onTap: ()=> _launchUrl("tel:$phone"),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
          child: Container(width: 40,height: 40,decoration: BoxDecoration(
            color: Theme.of(context).hintColor.withOpacity(.0525),
            border: Border.all(color: Theme.of(context).hintColor),
            borderRadius: BorderRadius.circular(50),

          ),
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Image.asset(Images.callIcon,color: Theme.of(context).colorScheme.onTertiaryContainer)),
        ),
      ),

      InkWell(
        onTap: (){
          Provider.of<ChatProvider>(context, listen: false).setUserTypeIndex(context, 1);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChatScreen(id: id, name: name)));

          },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
          child: Container(width: 40,decoration: BoxDecoration(
            color: Theme.of(context).hintColor.withOpacity(.0525),
            border: Border.all(color: Theme.of(context).hintColor),
            borderRadius: BorderRadius.circular(50),

          ),
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Image.asset(Images.smsIcon,color: Theme.of(context).primaryColor,),),
        ),
      )
    ],);
  }
}
Future<void> _launchUrl(String _url) async {
  if (!await launchUrl(Uri.parse(_url))) {
    throw 'Could not launch $_url';
  }
}
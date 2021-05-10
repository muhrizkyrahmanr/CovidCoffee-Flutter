import 'package:badges/badges.dart';
import 'package:covidcoffee/src/ui/main/Keranjang.dart';
import 'package:covidcoffee/src/ui/main/Login.dart';
import 'package:flutter/material.dart';

AppBar AppBarDetail({BuildContext context, int totalKeranjang, String id_pelanggan, bool isLogin, VoidCallback getTotalKeranjang, VoidCallback getTotalKeranjangHome}){
 return AppBar(
   backgroundColor: Colors.lightBlue[800],
   elevation: 0.0,
   leading: IconButton(
     onPressed: (){
       Navigator.pop(context);
       getTotalKeranjangHome();
     },
     icon: Icon(
       Icons.chevron_left,
       size: 32.0,
     ),
   ),
   actions: [
     Badge(
       badgeContent: Text(
         '$totalKeranjang',
         style: TextStyle(
           color: Colors.black,
           fontSize: 10.0,
         ),
       ),
       showBadge: totalKeranjang == 0 ? false : true,
       position: BadgePosition.topEnd(
         top: 5.0,
         end: 4.0,
       ),
       badgeColor: Colors.white,
       toAnimate: true,
       animationDuration: Duration(
           milliseconds: 200
       ),
       animationType: BadgeAnimationType.scale,
       child: IconButton(
         onPressed: () {
           if(isLogin) {
             Navigator.push(context, MaterialPageRoute(
                 builder: (context) =>
                     Keranjang(
                       id_pelanggan: id_pelanggan,
                       getTotalKeranjang: getTotalKeranjang,
                     )
             ));
           }else{
             Navigator.pushAndRemoveUntil(
               context,
               MaterialPageRoute(
                 builder: (context) => Login(),
               ),
                   (route) => false,
             );
           }
         },
         icon: Icon(
           Icons.shopping_cart,
           color: Colors.white,
         ),
       ),
     )
   ],
 );
}
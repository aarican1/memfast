// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MediaQueryConstants {
  BuildContext context;

  dynamic getContantsMediaQueryData(MediaQueryContantsEnum mediaQueryContantsEnum){

    switch (mediaQueryContantsEnum) {
      case MediaQueryContantsEnum.width:
      return MediaQuery.of(context).size.width;
       case MediaQueryContantsEnum.height:
       return MediaQuery.of(context).size.height;
        case MediaQueryContantsEnum.appBarFontSize:
      return  MediaQuery.of(context).size.width * 0.11;
         case MediaQueryContantsEnum.appbarPadding:
      return   MediaQuery.of(context).size.height * 0.045;
          case MediaQueryContantsEnum.bodyPadding:
        return  MediaQuery.of(context).size.height * 0.13;
           case MediaQueryContantsEnum.nameFontSize:
         return   MediaQuery.of(context).size.width * 0.06;
             case MediaQueryContantsEnum.usernameFontSize:
         return    MediaQuery.of(context).size.width * 0.09;
          


        
       
      default:
    }
  }



  MediaQueryConstants({
    required this.context,
  });
}
enum MediaQueryContantsEnum{
  width,height,usernameFontSize,nameFontSize,bodyPadding,
  appbarPadding,appBarFontSize,
}
import 'package:activeitzone/middlewares/group_middleware.dart';
import 'package:activeitzone/middlewares/maintenance.dart';
import 'package:activeitzone/middlewares/middleware.dart';
import 'package:http/http.dart' as http;



class AIZApiResponse{
 static http.Response check(http.Response response,{Middleware? middleware,GroupMiddleware? groupMiddleWare}){
   _commonCheck(response);
   if(middleware!=null){
     middleware.next(response);
   }
   if(groupMiddleWare!=null){
     groupMiddleWare.next(response);
   }
    return response;
  }

 static _commonCheck(http.Response response){
   MaintenanceMiddleware().next(response);
 }
}
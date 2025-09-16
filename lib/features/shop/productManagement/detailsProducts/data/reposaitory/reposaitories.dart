import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../data_source/remote_data_source.dart';
import '../model/product_data.dart';

class DetailsProductReposaitories {


  DetailsProductReposaitories();


  Future<Either<DioException, ProductData>> getDetailsOfProduct(
      int idProduct) async {
    try {
      final data = await ProductDetailsRemoteDataSource ().getDetailsOfProduct(idProduct);
      return Right(data);
    } on DioException catch (erorr) {
      print(erorr.type.toString());
      return Left(erorr);
    }
  }
}
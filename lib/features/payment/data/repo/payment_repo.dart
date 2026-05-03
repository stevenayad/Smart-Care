import 'package:dartz/dartz.dart';
import 'package:smartcare/core/api/failure.dart';
import 'package:smartcare/features/payment/data/Model/intentpayment_model/intentpayment_model.dart';
import 'package:smartcare/features/payment/data/Model/payment_cash_model.dart';

abstract class PaymentRepo {
  Future<Either<Failure, IntentpaymentModel>> PaymentIntentOrder(
    int provider,
    String idorder,
  );
  Future<Either<Failure, PaymentCashModel>> PaymentCashOrder(
    String idorder,
  );
}
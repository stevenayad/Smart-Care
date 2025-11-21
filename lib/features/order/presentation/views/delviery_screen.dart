import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocProvider, BlocListener, MultiBlocProvider, ReadContext;
import 'package:smartcare/core/api/dio_consumer.dart';
import 'package:smartcare/core/api/services/cache_helper.dart';
import 'package:smartcare/core/widget/evluted_button.dart';
import 'package:smartcare/features/cart/data/cart_signalr.dart';
import 'package:smartcare/features/cart/data/cartrepo.dart';
import 'package:smartcare/features/cart/presentation/cubit/cart/cart_cubit.dart';
import 'package:smartcare/features/order/data/model/request_createoreder.dart';
import 'package:smartcare/features/order/data/model/request_pickup.dart';

import 'package:smartcare/features/order/data/repo/orderrepo.dart';
import 'package:smartcare/features/order/presentation/cubits/address_store/address_store_cubit.dart';
import 'package:smartcare/features/order/presentation/cubits/order/order_cubit.dart';
import 'package:smartcare/features/order/presentation/views/orderscreen.dart';
import 'package:smartcare/features/order/presentation/views/widget/appbar.dart';
import 'package:smartcare/features/order/presentation/views/widget/delivery_selection.dart';
import 'package:smartcare/features/order/presentation/views/widget/show_daliog.dart';

class DelvieryScreen extends StatelessWidget {
  const DelvieryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signalRService = CartSignalRService(CacheHelper.getAccessToken()!);
    String? selectedStoreId;
    String? selectedAddressId;
    int selectedTab = 0;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AddressStoreCubit(Orderrepo(apiConsumer: DioConsumer(Dio())))
                ..getaddress()
                ..getstore(),
        ),
        BlocProvider(
          create: (context) =>
              OrderCubit(Orderrepo(apiConsumer: DioConsumer(Dio()))),
        ),
        BlocProvider(
          create: (context) => CartCubit(
            cartrepo: Cartrepo(apiConsumer: DioConsumer(Dio())),
            signalRService: signalRService,
          ),
        ),
      ],
      child: Builder(
        builder: (context) {
          final cartId = context.read<CartCubit>().cartId;

          return Scaffold(
            appBar: buildGradientAppBar(
              'Pickup or Delivery',
              onBack: () => Navigator.pop(context),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  DeliverySelection(
                    onStoreSelected: (storeId) {
                      selectedStoreId = storeId;
                    },
                    onAddressSelected: (AddreesId) {
                      selectedAddressId = AddreesId;
                    },
                    onTabChanged: (tab) => selectedTab = tab,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BlocListener<OrderCubit, OrderState>(
                      listener: (context, state) {
                        if (state is PickupSucess) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Orderscreen(
                                orderId: state.pickupOrderModel.data!.id ?? '',
                              ),
                            ),
                          );
                        } else if (state is CreateorderSucess) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Orderscreen(
                                orderId: state.createOrderModel.data!.id ?? '',
                              ),
                            ),
                          );
                        } else if (state is OrderFailure) {
                          showOrderFailedDialog(context, state.errmessage);
                        }
                      },
                      child: EvlutedButton(
                        text: 'Pick Up Order',
                        onTap: () {
                          if (selectedTab == 0 && selectedAddressId == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please select an address!"),
                              ),
                            );
                            return;
                          }

                          if (selectedTab == 1 && selectedStoreId == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please select a store!"),
                              ),
                            );
                            return;
                          }

                          if (selectedTab == 0) {
                            final requestcreateorder = RequestCreateoreder(
                              cartId: 'e58ddaaf-941b-406e-d1a0-08de2754afd1',
                              deliveryAddressId: selectedAddressId,
                            );

                            BlocProvider.of<OrderCubit>(
                              context,
                            ).createorder(requestcreateorder);
                          }

                          if (selectedTab == 1) {
                            final request = RequestPickup(
                              cartId: 'e58ddaaf-941b-406e-d1a0-08de2754afd1',
                              storeId: selectedStoreId!,
                            );

                            BlocProvider.of<OrderCubit>(
                              context,
                            ).pickorder(request);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

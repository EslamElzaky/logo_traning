import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logo_app_traning/helper/custom_app_bar.dart';
import 'package:logo_app_traning/views/Select_location/EnterLocation/cubit/manage_location_cubit.dart';

class PageLocation extends StatelessWidget {
  const PageLocation({super.key});
  static String id = 'pageLocation';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(
        text: 'اختر العنوان',
        icon: Icons.notifications,
        backeIcon: Icons.arrow_back,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          context.read<ManageLocationCubit>().loadTitelData();
          Navigator.pushNamed(context, 'selectLocation');
        },
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: BlocBuilder<ManageLocationCubit, ManageLocationState>(
        builder: (context, state) {
          if (state.status == LocationStatus.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.status == LocationStatus.success) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: state.addresses.length,
                itemBuilder: (context, index) {
                  final address = state.addresses[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 95,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xffACACAC),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        title: Text(address.displayValue ?? "بدون عنوان"),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

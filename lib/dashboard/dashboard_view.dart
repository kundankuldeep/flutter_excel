import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:poc_excel_to_json/buttons.dart';

import 'dashboard_controller.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder<DashboardController>(
        builder: (controller) => Scaffold(
          backgroundColor: Colors.white,
          // main screen content
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                pocButton("Import", () {
                  controller.onImportClicked();
                }),
                const SizedBox(height: 10),
                pocButton("Export", () {
                  controller.onExportClicked();
                }),
                const SizedBox(height: 10),
                pocButton("Show Data", () {
                  controller.onShowDataClicked();
                }),
                const SizedBox(height: 20),
                if (controller.isShowData)
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.showDataList?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Text(index.toString()),
                          title: Text(controller.getDataAtIndex(index)),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
}

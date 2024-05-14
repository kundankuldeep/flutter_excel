import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:poc_excel_to_json/FileStorageHelper.dart';
import 'package:poc_excel_to_json/messageHelper.dart';
import 'package:poc_excel_to_json/models/VoterDetails.dart';

class DashboardController extends GetxController {
  List<VoterDetails>? mainDataList;
  List<VoterDetails>? showDataList = [];
  bool isShowData = false;
  String file_name =
      "voterDetails_${DateTime.now().millisecondsSinceEpoch}.xlsx";

  /**
   * following functions used to get the data from list and
   * save that to a xlsx file in the device
   * */
  void onExportClicked() {
    if (mainDataList == null || mainDataList!.isEmpty) {
      showLog("No data found");
      showToast("No data to be exported, Import data first");
      return;
    }
    saveDataToExcel(mainDataList);
  }

  void saveDataToExcel(List<VoterDetails>? mainDataList) async {
    var excel = Excel.createExcel();
    Sheet sheetObject =
        excel['voter details']; // Create a sheet named 'voter details'

    // Write data to the Excel sheet
    for (int i = 0; i < mainDataList!.length; i++) {
      VoterDetails voter = mainDataList[i];
      sheetObject.appendRow([
        TextCellValue(voter.boothnumber ?? ""),
        TextCellValue(voter.name ?? ""),
        TextCellValue(voter.guardianname ?? ""),
        TextCellValue(voter.epicnumber ?? ""),
        TextCellValue(voter.gender ?? ""),
        TextCellValue(voter.mobilenumber ?? ""),
        TextCellValue(voter.age ?? ""),
        TextCellValue(voter.caste ?? ""),
        TextCellValue(voter.occupation ?? ""),
        TextCellValue(voter.address ?? ""),
        TextCellValue(voter.influencer ?? ""),
        TextCellValue(voter.sentiment ?? ""),
        TextCellValue(voter.religion ?? ""),
        TextCellValue(voter.feedback ?? "")
      ]); // Assuming name and age are properties of the VoterDetails class
    }

    // Save the Excel file
    var bytes = excel.encode();

    if (bytes != null) {
      FileStorageHelper.writeToExcel(bytes!, file_name);
      showToast("File Exported successfully!! Please check downloads folder.");
    } else {
      showLog("file not saved");
    }
  }

  /**
   * following functions used to get the data from xlsx file and
   * save that to a list of model in device for now,
   * we can upload that to server as well.
   * */
  void onImportClicked() async {
    var byteData = await loadAsset();
    var listData = await parseExcel(byteData);
    mainDataList = convertToPOJO(listData!);
    showDataList?.addAll(mainDataList ?? []);
    showDataList?.removeAt(0);
    showToast("Data Imported successfully");
    showLog("dataList size: ${mainDataList?.length}");
  }

  Future<ByteData> loadAsset() async {
    return await rootBundle.load('assets/sample_voter_details.xlsx');
  }

  Future<List<List<Data?>>?> parseExcel(ByteData data) async {
    var bytes = data.buffer.asUint8List();
    var excel = Excel.decodeBytes(bytes);
    var table =
        excel.tables.keys.first; // Assuming the data is in the first sheet
    return excel.tables[table]?.rows;
  }

  List<VoterDetails> convertToPOJO(List<List<Data?>> excelData) {
    List<VoterDetails> dataList = [];
    for (var row in excelData) {
      if (row.length >= 2 && row[0] != null && row[1] != null) {
        dataList.add(
          VoterDetails(
            boothnumber: row[0]?.value.toString(),
            name: row[1]?.value.toString(),
            guardianname: row[2]?.value.toString(),
            epicnumber: row[3]?.value.toString(),
            gender: row[4]?.value.toString(),
            mobilenumber: row[5]?.value.toString(),
            age: row[6]?.value.toString(),
            caste: row[7]?.value.toString(),
            occupation: row[8]?.value.toString(),
            address: row[9]?.value.toString(),
            influencer: row[10]?.value.toString(),
            sentiment: row[11]?.value.toString(),
            religion: row[12]?.value.toString(),
            feedback: row[13]?.value.toString(),
          ),
        );
      }
    }
    return dataList;
  }

  void onShowDataClicked() {
    if (mainDataList == null || mainDataList!.isEmpty) {
      showLog("No data found");
      showToast("No data to show, Import data first");
      return;
    }
    isShowData = true;
    update();
  }

  String getDataAtIndex(int index) {
    return "${showDataList![index].name} (${showDataList![index].age})";
  }
}

class WaybillListMode {
  num code;
  List<Content> content;
  int mark;
  int total;

  WaybillListMode({this.code, this.content, this.mark, this.total});

  WaybillListMode.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['content'] != null) {
      content = new List<Content>();
      json['content'].forEach((v) {
        content.add(new Content.fromJson(v));
      });
    }
    mark = json['mark'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.content != null) {
      data['content'] = this.content.map((v) => v.toJson()).toList();
    }
    data['mark'] = this.mark;
    data['total'] = this.total;
    return data;
  }
}

class Content {
  String platformOriginalConsignOrgCode;
  num standardDistance;
  String loadingTime;
  String reportCapitalStatus;
  String platformDriverCode;
  String platformTruckCode;
  String externalNoPrintStatus;
  String payeeDriverFullName;
  String craneOrderStatus;
  num settleClientOrgPayeeAdjust;
  String loadingCountyName;
  String meterageType;
  String loadingAttachmentExecuteOrgCode;
  String licensePlateTypeCode;
  String unloadingCountyName;
  String loadingInputTime;
  String unloadingGoodsWeightUnitCode;
  String driverPayeeBankName;
  num operatorLongitude;
  num id;
  String goodsName;
  String loadingProvinceName;
  String routeCode;
  String trailerTruckLicenseNo;
  String driverConfirmTime;
  num settleTradingConfigAmount;
  String consignOrgName;
  String creatorUserCode;
  num standardTime;
  String ownerUserCode;
  String ip;
  num settleConfigAmount3;
  num settleConfigAmount4;
  String synchronousId;
  num settleConfigAmount1;
  num settleConfigAmount2;
  String unloadingCityName;
  String unloadingUserPhone;
  String loadingAttachmentExecuteUserCode;
  String platformClientOrgCode;
  String dispatchOrgName;
  String ownerOrgCode;
  String scheduleType;
  String loadingCityName;
  num goodsPrice;
  String loadingOrgName;
  String returnMileageUnitCode;
  String currentActionCode;
  String truckLicenseNo;
  num settleDriverFreight;
  String goodsLossMethod;
  String platformDispatchOrgCode;
  String loadingAttachmentExecuteTime;
  String settleStatus;
  String standardDistanceUnitCode;
  String loadingAddrLon;
  num unloadingGoodsWeight;
  num goodsWeight;
  String unloadingAddr;
  String driverCode;
  num waybillType;
  num settleDriverPayment;
  String driverPayeeBankAccountDescription;
  String clientFreightPriceUnitCode;
  bool disabled;
  String settleMethod;
  String reportCargoTypeClassificationCode;
  num settleGoodsLossReasonable;
  String moduleCode;
  String loadingGoodsWeightUnitCode;
  String unloadingProvinceName;
  String payeeDriverPhone;
  String loadingAddr;
  String updateTime;
  String platformConsignOrgCode;
  num settleGoodsLossVolume;
  num operatorLatitude;
  num settleVolume;
  bool deleted;
  String createTime;
  String goodsLossUnitCode;
  String downSettleStatus;
  num loadingGoodsVolume;
  num truckLength;
  num clientFreightPrice;
  String clientOrgName;
  String unloadingUserFullName;
  num settleDriverRealPayment;
  String originalConsignOrgCode;
  num goodsLoss;
  String driverPayeeBankAccountNo;
  String platformDispatchUserCode;
  String settlePaymentPayStatus;
  String consignEvaluation;
  String unloadingCityCode;
  String complianceStatus;
  String upSettleStatus;
  num settleClientOrgPayeeCalculated;
  String loadingGoodsVolumeUnitCode;
  num settleClientOrgFreight;
  String routeName;
  String loadingCountyCode;
  String clientOrgCode;
  num unloadingGoodsNum;
  String dispatchOrgCode;
  String currentActionName;
  String loadingCityCode;
  String truckCode;
  String unloadingGoodsNumUnitCode;
  num settleRealPayment;
  String driverFuelCardNo;
  String loadingAttachmentExecuteUserFullName;
  String dispatchPrintStatus;
  num settlePaymentSummary;
  String trailerTruckCode;
  String driverConfirmStatus;
  num settleConfigValue4;
  String logisticsCode;
  String reportStatus;
  String updateUserCode;
  String loadingAttachmentExecuteOrgName;
  num settleClientOrgPayee;
  String creatorUsername;
  num settleConfigValue2;
  String updateUsername;
  String logisticsNo;
  num settleConfigValue3;
  String loadingProvinceCode;
  num settleDriverExpense;
  num settleConfigValue1;
  String loadingInputUserFullName;
  num loadingGoodsNum;
  String truckPowerType;
  String driverLicenseNo;
  String driverPayeeBankAccountName;
  String dispatchUserFullName;
  String code;
  num fleetPrice;
  num settleTradingConfigValue;
  String platformTrailerTruckCode;
  num settleViceDriverExpense;
  num settleLossDeduction;
  String ownerOrgName;
  String loadingUserFullName;
  String driverPriceUnitCode;
  num settleTransportationCost;
  String waybillStatus;
  String driverIdentityNumber;
  num goodsNum;
  String loadingGoodsNumUnitCode;
  String consignOrgCode;
  num settleGrossProfit;
  num driverPrice;
  String driverFullName;
  String payeeDriverCode;
  String loadingAddrLat;
  num loadingGoodsWeight;
  String reportBusinessTypeCode;
  num goodsVolume;
  String originalConsignOrgName;
  String loadingUserPhone;
  String dispatchUserCode;
  String unloadingCountyCode;
  String loadingAttachment;
  String unloadingOrgName;
  num regTonnage;
  String unloadingProvinceCode;
  num unloadingGoodsVolume;
  String unloadingGoodsVolumeUnitCode;
  String departMileageUnitCode;
  String driverPhone;
  String payeePlatformDriverCode;
  String waybillNo;

  Content(
      {this.platformOriginalConsignOrgCode,
      this.standardDistance,
      this.loadingTime,
      this.reportCapitalStatus,
      this.platformDriverCode,
      this.platformTruckCode,
      this.externalNoPrintStatus,
      this.payeeDriverFullName,
      this.craneOrderStatus,
      this.settleClientOrgPayeeAdjust,
      this.loadingCountyName,
      this.meterageType,
      this.loadingAttachmentExecuteOrgCode,
      this.licensePlateTypeCode,
      this.unloadingCountyName,
      this.loadingInputTime,
      this.unloadingGoodsWeightUnitCode,
      this.driverPayeeBankName,
      this.operatorLongitude,
      this.id,
      this.goodsName,
      this.loadingProvinceName,
      this.routeCode,
      this.trailerTruckLicenseNo,
      this.driverConfirmTime,
      this.settleTradingConfigAmount,
      this.consignOrgName,
      this.creatorUserCode,
      this.standardTime,
      this.ownerUserCode,
      this.ip,
      this.settleConfigAmount3,
      this.settleConfigAmount4,
      this.synchronousId,
      this.settleConfigAmount1,
      this.settleConfigAmount2,
      this.unloadingCityName,
      this.unloadingUserPhone,
      this.loadingAttachmentExecuteUserCode,
      this.platformClientOrgCode,
      this.dispatchOrgName,
      this.ownerOrgCode,
      this.scheduleType,
      this.loadingCityName,
      this.goodsPrice,
      this.loadingOrgName,
      this.returnMileageUnitCode,
      this.currentActionCode,
      this.truckLicenseNo,
      this.settleDriverFreight,
      this.goodsLossMethod,
      this.platformDispatchOrgCode,
      this.loadingAttachmentExecuteTime,
      this.settleStatus,
      this.standardDistanceUnitCode,
      this.loadingAddrLon,
      this.unloadingGoodsWeight,
      this.goodsWeight,
      this.unloadingAddr,
      this.driverCode,
      this.waybillType,
      this.settleDriverPayment,
      this.driverPayeeBankAccountDescription,
      this.clientFreightPriceUnitCode,
      this.disabled,
      this.settleMethod,
      this.reportCargoTypeClassificationCode,
      this.settleGoodsLossReasonable,
      this.moduleCode,
      this.loadingGoodsWeightUnitCode,
      this.unloadingProvinceName,
      this.payeeDriverPhone,
      this.loadingAddr,
      this.updateTime,
      this.platformConsignOrgCode,
      this.settleGoodsLossVolume,
      this.operatorLatitude,
      this.settleVolume,
      this.deleted,
      this.createTime,
      this.goodsLossUnitCode,
      this.downSettleStatus,
      this.loadingGoodsVolume,
      this.truckLength,
      this.clientFreightPrice,
      this.clientOrgName,
      this.unloadingUserFullName,
      this.settleDriverRealPayment,
      this.originalConsignOrgCode,
      this.goodsLoss,
      this.driverPayeeBankAccountNo,
      this.platformDispatchUserCode,
      this.settlePaymentPayStatus,
      this.consignEvaluation,
      this.unloadingCityCode,
      this.complianceStatus,
      this.upSettleStatus,
      this.settleClientOrgPayeeCalculated,
      this.loadingGoodsVolumeUnitCode,
      this.settleClientOrgFreight,
      this.routeName,
      this.loadingCountyCode,
      this.clientOrgCode,
      this.unloadingGoodsNum,
      this.dispatchOrgCode,
      this.currentActionName,
      this.loadingCityCode,
      this.truckCode,
      this.unloadingGoodsNumUnitCode,
      this.settleRealPayment,
      this.driverFuelCardNo,
      this.loadingAttachmentExecuteUserFullName,
      this.dispatchPrintStatus,
      this.settlePaymentSummary,
      this.trailerTruckCode,
      this.driverConfirmStatus,
      this.settleConfigValue4,
      this.logisticsCode,
      this.reportStatus,
      this.updateUserCode,
      this.loadingAttachmentExecuteOrgName,
      this.settleClientOrgPayee,
      this.creatorUsername,
      this.settleConfigValue2,
      this.updateUsername,
      this.logisticsNo,
      this.settleConfigValue3,
      this.loadingProvinceCode,
      this.settleDriverExpense,
      this.settleConfigValue1,
      this.loadingInputUserFullName,
      this.loadingGoodsNum,
      this.truckPowerType,
      this.driverLicenseNo,
      this.driverPayeeBankAccountName,
      this.dispatchUserFullName,
      this.code,
      this.fleetPrice,
      this.settleTradingConfigValue,
      this.platformTrailerTruckCode,
      this.settleViceDriverExpense,
      this.settleLossDeduction,
      this.ownerOrgName,
      this.loadingUserFullName,
      this.driverPriceUnitCode,
      this.settleTransportationCost,
      this.waybillStatus,
      this.driverIdentityNumber,
      this.goodsNum,
      this.loadingGoodsNumUnitCode,
      this.consignOrgCode,
      this.settleGrossProfit,
      this.driverPrice,
      this.driverFullName,
      this.payeeDriverCode,
      this.loadingAddrLat,
      this.loadingGoodsWeight,
      this.reportBusinessTypeCode,
      this.goodsVolume,
      this.originalConsignOrgName,
      this.loadingUserPhone,
      this.dispatchUserCode,
      this.unloadingCountyCode,
      this.loadingAttachment,
      this.unloadingOrgName,
      this.regTonnage,
      this.unloadingProvinceCode,
      this.unloadingGoodsVolume,
      this.unloadingGoodsVolumeUnitCode,
      this.departMileageUnitCode,
      this.driverPhone,
      this.payeePlatformDriverCode,
      this.waybillNo});

  Content.fromJson(Map<String, dynamic> json) {
    platformOriginalConsignOrgCode = json['platformOriginalConsignOrgCode'];
    standardDistance = json['standardDistance'];
    loadingTime = json['loadingTime'];
    reportCapitalStatus = json['reportCapitalStatus'];
    platformDriverCode = json['platformDriverCode'];
    platformTruckCode = json['platformTruckCode'];
    externalNoPrintStatus = json['externalNoPrintStatus'];
    payeeDriverFullName = json['payeeDriverFullName'];
    craneOrderStatus = json['craneOrderStatus'];
    settleClientOrgPayeeAdjust = json['settleClientOrgPayeeAdjust'];
    loadingCountyName = json['loadingCountyName'];
    meterageType = json['meterageType'];
    loadingAttachmentExecuteOrgCode = json['loadingAttachmentExecuteOrgCode'];
    licensePlateTypeCode = json['licensePlateTypeCode'];
    unloadingCountyName = json['unloadingCountyName'];
    loadingInputTime = json['loadingInputTime'];
    unloadingGoodsWeightUnitCode = json['unloadingGoodsWeightUnitCode'];
    driverPayeeBankName = json['driverPayeeBankName'];
    operatorLongitude = json['operatorLongitude'];
    id = json['id'];
    goodsName = json['goodsName'];
    loadingProvinceName = json['loadingProvinceName'];
    routeCode = json['routeCode'];
    trailerTruckLicenseNo = json['trailerTruckLicenseNo'];
    driverConfirmTime = json['driverConfirmTime'];
    settleTradingConfigAmount = json['settleTradingConfigAmount'];
    consignOrgName = json['consignOrgName'];
    creatorUserCode = json['creatorUserCode'];
    standardTime = json['standardTime'];
    ownerUserCode = json['ownerUserCode'];
    ip = json['ip'];
    settleConfigAmount3 = json['settleConfigAmount3'];
    settleConfigAmount4 = json['settleConfigAmount4'];
    synchronousId = json['synchronousId'];
    settleConfigAmount1 = json['settleConfigAmount1'];
    settleConfigAmount2 = json['settleConfigAmount2'];
    unloadingCityName = json['unloadingCityName'];
    unloadingUserPhone = json['unloadingUserPhone'];
    loadingAttachmentExecuteUserCode = json['loadingAttachmentExecuteUserCode'];
    platformClientOrgCode = json['platformClientOrgCode'];
    dispatchOrgName = json['dispatchOrgName'];
    ownerOrgCode = json['ownerOrgCode'];
    scheduleType = json['scheduleType'];
    loadingCityName = json['loadingCityName'];
    goodsPrice = json['goodsPrice'];
    loadingOrgName = json['loadingOrgName'];
    returnMileageUnitCode = json['returnMileageUnitCode'];
    currentActionCode = json['currentActionCode'];
    truckLicenseNo = json['truckLicenseNo'];
    settleDriverFreight = json['settleDriverFreight'];
    goodsLossMethod = json['goodsLossMethod'];
    platformDispatchOrgCode = json['platformDispatchOrgCode'];
    loadingAttachmentExecuteTime = json['loadingAttachmentExecuteTime'];
    settleStatus = json['settleStatus'];
    standardDistanceUnitCode = json['standardDistanceUnitCode'];
    loadingAddrLon = json['loadingAddrLon'];
    unloadingGoodsWeight = json['unloadingGoodsWeight'];
    goodsWeight = json['goodsWeight'];
    unloadingAddr = json['unloadingAddr'];
    driverCode = json['driverCode'];
    waybillType = json['waybillType'];
    settleDriverPayment = json['settleDriverPayment'];
    driverPayeeBankAccountDescription =
        json['driverPayeeBankAccountDescription'];
    clientFreightPriceUnitCode = json['clientFreightPriceUnitCode'];
    disabled = json['disabled'];
    settleMethod = json['settleMethod'];
    reportCargoTypeClassificationCode =
        json['reportCargoTypeClassificationCode'];
    settleGoodsLossReasonable = json['settleGoodsLossReasonable'];
    moduleCode = json['moduleCode'];
    loadingGoodsWeightUnitCode = json['loadingGoodsWeightUnitCode'];
    unloadingProvinceName = json['unloadingProvinceName'];
    payeeDriverPhone = json['payeeDriverPhone'];
    loadingAddr = json['loadingAddr'];
    updateTime = json['updateTime'];
    platformConsignOrgCode = json['platformConsignOrgCode'];
    settleGoodsLossVolume = json['settleGoodsLossVolume'];
    operatorLatitude = json['operatorLatitude'];
    settleVolume = json['settleVolume'];
    deleted = json['deleted'];
    createTime = json['createTime'];
    goodsLossUnitCode = json['goodsLossUnitCode'];
    downSettleStatus = json['downSettleStatus'];
    loadingGoodsVolume = json['loadingGoodsVolume'];
    truckLength = json['truckLength'];
    clientFreightPrice = json['clientFreightPrice'];
    clientOrgName = json['clientOrgName'];
    unloadingUserFullName = json['unloadingUserFullName'];
    settleDriverRealPayment = json['settleDriverRealPayment'];
    originalConsignOrgCode = json['originalConsignOrgCode'];
    goodsLoss = json['goodsLoss'];
    driverPayeeBankAccountNo = json['driverPayeeBankAccountNo'];
    platformDispatchUserCode = json['platformDispatchUserCode'];
    settlePaymentPayStatus = json['settlePaymentPayStatus'];
    consignEvaluation = json['consignEvaluation'];
    unloadingCityCode = json['unloadingCityCode'];
    complianceStatus = json['complianceStatus'];
    upSettleStatus = json['upSettleStatus'];
    settleClientOrgPayeeCalculated = json['settleClientOrgPayeeCalculated'];
    loadingGoodsVolumeUnitCode = json['loadingGoodsVolumeUnitCode'];
    settleClientOrgFreight = json['settleClientOrgFreight'];
    routeName = json['routeName'];
    loadingCountyCode = json['loadingCountyCode'];
    clientOrgCode = json['clientOrgCode'];
    unloadingGoodsNum = json['unloadingGoodsNum'];
    dispatchOrgCode = json['dispatchOrgCode'];
    currentActionName = json['currentActionName'];
    loadingCityCode = json['loadingCityCode'];
    truckCode = json['truckCode'];
    unloadingGoodsNumUnitCode = json['unloadingGoodsNumUnitCode'];
    settleRealPayment = json['settleRealPayment'];
    driverFuelCardNo = json['driverFuelCardNo'];
    loadingAttachmentExecuteUserFullName =
        json['loadingAttachmentExecuteUserFullName'];
    dispatchPrintStatus = json['dispatchPrintStatus'];
    settlePaymentSummary = json['settlePaymentSummary'];
    trailerTruckCode = json['trailerTruckCode'];
    driverConfirmStatus = json['driverConfirmStatus'];
    settleConfigValue4 = json['settleConfigValue4'];
    logisticsCode = json['logisticsCode'];
    reportStatus = json['reportStatus'];
    updateUserCode = json['updateUserCode'];
    loadingAttachmentExecuteOrgName = json['loadingAttachmentExecuteOrgName'];
    settleClientOrgPayee = json['settleClientOrgPayee'];
    creatorUsername = json['creatorUsername'];
    settleConfigValue2 = json['settleConfigValue2'];
    updateUsername = json['updateUsername'];
    logisticsNo = json['logisticsNo'];
    settleConfigValue3 = json['settleConfigValue3'];
    loadingProvinceCode = json['loadingProvinceCode'];
    settleDriverExpense = json['settleDriverExpense'];
    settleConfigValue1 = json['settleConfigValue1'];
    loadingInputUserFullName = json['loadingInputUserFullName'];
    loadingGoodsNum = json['loadingGoodsNum'];
    truckPowerType = json['truckPowerType'];
    driverLicenseNo = json['driverLicenseNo'];
    driverPayeeBankAccountName = json['driverPayeeBankAccountName'];
    dispatchUserFullName = json['dispatchUserFullName'];
    code = json['code'];
    fleetPrice = json['fleetPrice'];
    settleTradingConfigValue = json['settleTradingConfigValue'];
    platformTrailerTruckCode = json['platformTrailerTruckCode'];
    settleViceDriverExpense = json['settleViceDriverExpense'];
    settleLossDeduction = json['settleLossDeduction'];
    ownerOrgName = json['ownerOrgName'];
    loadingUserFullName = json['loadingUserFullName'];
    driverPriceUnitCode = json['driverPriceUnitCode'];
    settleTransportationCost = json['settleTransportationCost'];
    waybillStatus = json['waybillStatus'];
    driverIdentityNumber = json['driverIdentityNumber'];
    goodsNum = json['goodsNum'];
    loadingGoodsNumUnitCode = json['loadingGoodsNumUnitCode'];
    consignOrgCode = json['consignOrgCode'];
    settleGrossProfit = json['settleGrossProfit'];
    driverPrice = json['driverPrice'];
    driverFullName = json['driverFullName'];
    payeeDriverCode = json['payeeDriverCode'];
    loadingAddrLat = json['loadingAddrLat'];
    loadingGoodsWeight = json['loadingGoodsWeight'];
    reportBusinessTypeCode = json['reportBusinessTypeCode'];
    goodsVolume = json['goodsVolume'];
    originalConsignOrgName = json['originalConsignOrgName'];
    loadingUserPhone = json['loadingUserPhone'];
    dispatchUserCode = json['dispatchUserCode'];
    unloadingCountyCode = json['unloadingCountyCode'];
    loadingAttachment = json['loadingAttachment'];
    unloadingOrgName = json['unloadingOrgName'];
    regTonnage = json['regTonnage'];
    unloadingProvinceCode = json['unloadingProvinceCode'];
    unloadingGoodsVolume = json['unloadingGoodsVolume'];
    unloadingGoodsVolumeUnitCode = json['unloadingGoodsVolumeUnitCode'];
    departMileageUnitCode = json['departMileageUnitCode'];
    driverPhone = json['driverPhone'];
    payeePlatformDriverCode = json['payeePlatformDriverCode'];
    waybillNo = json['waybillNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['platformOriginalConsignOrgCode'] =
        this.platformOriginalConsignOrgCode;
    data['standardDistance'] = this.standardDistance;
    data['loadingTime'] = this.loadingTime;
    data['reportCapitalStatus'] = this.reportCapitalStatus;
    data['platformDriverCode'] = this.platformDriverCode;
    data['platformTruckCode'] = this.platformTruckCode;
    data['externalNoPrintStatus'] = this.externalNoPrintStatus;
    data['payeeDriverFullName'] = this.payeeDriverFullName;
    data['craneOrderStatus'] = this.craneOrderStatus;
    data['settleClientOrgPayeeAdjust'] = this.settleClientOrgPayeeAdjust;
    data['loadingCountyName'] = this.loadingCountyName;
    data['meterageType'] = this.meterageType;
    data['loadingAttachmentExecuteOrgCode'] =
        this.loadingAttachmentExecuteOrgCode;
    data['licensePlateTypeCode'] = this.licensePlateTypeCode;
    data['unloadingCountyName'] = this.unloadingCountyName;
    data['loadingInputTime'] = this.loadingInputTime;
    data['unloadingGoodsWeightUnitCode'] = this.unloadingGoodsWeightUnitCode;
    data['driverPayeeBankName'] = this.driverPayeeBankName;
    data['operatorLongitude'] = this.operatorLongitude;
    data['id'] = this.id;
    data['goodsName'] = this.goodsName;
    data['loadingProvinceName'] = this.loadingProvinceName;
    data['routeCode'] = this.routeCode;
    data['trailerTruckLicenseNo'] = this.trailerTruckLicenseNo;
    data['driverConfirmTime'] = this.driverConfirmTime;
    data['settleTradingConfigAmount'] = this.settleTradingConfigAmount;
    data['consignOrgName'] = this.consignOrgName;
    data['creatorUserCode'] = this.creatorUserCode;
    data['standardTime'] = this.standardTime;
    data['ownerUserCode'] = this.ownerUserCode;
    data['ip'] = this.ip;
    data['settleConfigAmount3'] = this.settleConfigAmount3;
    data['settleConfigAmount4'] = this.settleConfigAmount4;
    data['synchronousId'] = this.synchronousId;
    data['settleConfigAmount1'] = this.settleConfigAmount1;
    data['settleConfigAmount2'] = this.settleConfigAmount2;
    data['unloadingCityName'] = this.unloadingCityName;
    data['unloadingUserPhone'] = this.unloadingUserPhone;
    data['loadingAttachmentExecuteUserCode'] =
        this.loadingAttachmentExecuteUserCode;
    data['platformClientOrgCode'] = this.platformClientOrgCode;
    data['dispatchOrgName'] = this.dispatchOrgName;
    data['ownerOrgCode'] = this.ownerOrgCode;
    data['scheduleType'] = this.scheduleType;
    data['loadingCityName'] = this.loadingCityName;
    data['goodsPrice'] = this.goodsPrice;
    data['loadingOrgName'] = this.loadingOrgName;
    data['returnMileageUnitCode'] = this.returnMileageUnitCode;
    data['currentActionCode'] = this.currentActionCode;
    data['truckLicenseNo'] = this.truckLicenseNo;
    data['settleDriverFreight'] = this.settleDriverFreight;
    data['goodsLossMethod'] = this.goodsLossMethod;
    data['platformDispatchOrgCode'] = this.platformDispatchOrgCode;
    data['loadingAttachmentExecuteTime'] = this.loadingAttachmentExecuteTime;
    data['settleStatus'] = this.settleStatus;
    data['standardDistanceUnitCode'] = this.standardDistanceUnitCode;
    data['loadingAddrLon'] = this.loadingAddrLon;
    data['unloadingGoodsWeight'] = this.unloadingGoodsWeight;
    data['goodsWeight'] = this.goodsWeight;
    data['unloadingAddr'] = this.unloadingAddr;
    data['driverCode'] = this.driverCode;
    data['waybillType'] = this.waybillType;
    data['settleDriverPayment'] = this.settleDriverPayment;
    data['driverPayeeBankAccountDescription'] =
        this.driverPayeeBankAccountDescription;
    data['clientFreightPriceUnitCode'] = this.clientFreightPriceUnitCode;
    data['disabled'] = this.disabled;
    data['settleMethod'] = this.settleMethod;
    data['reportCargoTypeClassificationCode'] =
        this.reportCargoTypeClassificationCode;
    data['settleGoodsLossReasonable'] = this.settleGoodsLossReasonable;
    data['moduleCode'] = this.moduleCode;
    data['loadingGoodsWeightUnitCode'] = this.loadingGoodsWeightUnitCode;
    data['unloadingProvinceName'] = this.unloadingProvinceName;
    data['payeeDriverPhone'] = this.payeeDriverPhone;
    data['loadingAddr'] = this.loadingAddr;
    data['updateTime'] = this.updateTime;
    data['platformConsignOrgCode'] = this.platformConsignOrgCode;
    data['settleGoodsLossVolume'] = this.settleGoodsLossVolume;
    data['operatorLatitude'] = this.operatorLatitude;
    data['settleVolume'] = this.settleVolume;
    data['deleted'] = this.deleted;
    data['createTime'] = this.createTime;
    data['goodsLossUnitCode'] = this.goodsLossUnitCode;
    data['downSettleStatus'] = this.downSettleStatus;
    data['loadingGoodsVolume'] = this.loadingGoodsVolume;
    data['truckLength'] = this.truckLength;
    data['clientFreightPrice'] = this.clientFreightPrice;
    data['clientOrgName'] = this.clientOrgName;
    data['unloadingUserFullName'] = this.unloadingUserFullName;
    data['settleDriverRealPayment'] = this.settleDriverRealPayment;
    data['originalConsignOrgCode'] = this.originalConsignOrgCode;
    data['goodsLoss'] = this.goodsLoss;
    data['driverPayeeBankAccountNo'] = this.driverPayeeBankAccountNo;
    data['platformDispatchUserCode'] = this.platformDispatchUserCode;
    data['settlePaymentPayStatus'] = this.settlePaymentPayStatus;
    data['consignEvaluation'] = this.consignEvaluation;
    data['unloadingCityCode'] = this.unloadingCityCode;
    data['complianceStatus'] = this.complianceStatus;
    data['upSettleStatus'] = this.upSettleStatus;
    data['settleClientOrgPayeeCalculated'] =
        this.settleClientOrgPayeeCalculated;
    data['loadingGoodsVolumeUnitCode'] = this.loadingGoodsVolumeUnitCode;
    data['settleClientOrgFreight'] = this.settleClientOrgFreight;
    data['routeName'] = this.routeName;
    data['loadingCountyCode'] = this.loadingCountyCode;
    data['clientOrgCode'] = this.clientOrgCode;
    data['unloadingGoodsNum'] = this.unloadingGoodsNum;
    data['dispatchOrgCode'] = this.dispatchOrgCode;
    data['currentActionName'] = this.currentActionName;
    data['loadingCityCode'] = this.loadingCityCode;
    data['truckCode'] = this.truckCode;
    data['unloadingGoodsNumUnitCode'] = this.unloadingGoodsNumUnitCode;
    data['settleRealPayment'] = this.settleRealPayment;
    data['driverFuelCardNo'] = this.driverFuelCardNo;
    data['loadingAttachmentExecuteUserFullName'] =
        this.loadingAttachmentExecuteUserFullName;
    data['dispatchPrintStatus'] = this.dispatchPrintStatus;
    data['settlePaymentSummary'] = this.settlePaymentSummary;
    data['trailerTruckCode'] = this.trailerTruckCode;
    data['driverConfirmStatus'] = this.driverConfirmStatus;
    data['settleConfigValue4'] = this.settleConfigValue4;
    data['logisticsCode'] = this.logisticsCode;
    data['reportStatus'] = this.reportStatus;
    data['updateUserCode'] = this.updateUserCode;
    data['loadingAttachmentExecuteOrgName'] =
        this.loadingAttachmentExecuteOrgName;
    data['settleClientOrgPayee'] = this.settleClientOrgPayee;
    data['creatorUsername'] = this.creatorUsername;
    data['settleConfigValue2'] = this.settleConfigValue2;
    data['updateUsername'] = this.updateUsername;
    data['logisticsNo'] = this.logisticsNo;
    data['settleConfigValue3'] = this.settleConfigValue3;
    data['loadingProvinceCode'] = this.loadingProvinceCode;
    data['settleDriverExpense'] = this.settleDriverExpense;
    data['settleConfigValue1'] = this.settleConfigValue1;
    data['loadingInputUserFullName'] = this.loadingInputUserFullName;
    data['loadingGoodsNum'] = this.loadingGoodsNum;
    data['truckPowerType'] = this.truckPowerType;
    data['driverLicenseNo'] = this.driverLicenseNo;
    data['driverPayeeBankAccountName'] = this.driverPayeeBankAccountName;
    data['dispatchUserFullName'] = this.dispatchUserFullName;
    data['code'] = this.code;
    data['fleetPrice'] = this.fleetPrice;
    data['settleTradingConfigValue'] = this.settleTradingConfigValue;
    data['platformTrailerTruckCode'] = this.platformTrailerTruckCode;
    data['settleViceDriverExpense'] = this.settleViceDriverExpense;
    data['settleLossDeduction'] = this.settleLossDeduction;
    data['ownerOrgName'] = this.ownerOrgName;
    data['loadingUserFullName'] = this.loadingUserFullName;
    data['driverPriceUnitCode'] = this.driverPriceUnitCode;
    data['settleTransportationCost'] = this.settleTransportationCost;
    data['waybillStatus'] = this.waybillStatus;
    data['driverIdentityNumber'] = this.driverIdentityNumber;
    data['goodsNum'] = this.goodsNum;
    data['loadingGoodsNumUnitCode'] = this.loadingGoodsNumUnitCode;
    data['consignOrgCode'] = this.consignOrgCode;
    data['settleGrossProfit'] = this.settleGrossProfit;
    data['driverPrice'] = this.driverPrice;
    data['driverFullName'] = this.driverFullName;
    data['payeeDriverCode'] = this.payeeDriverCode;
    data['loadingAddrLat'] = this.loadingAddrLat;
    data['loadingGoodsWeight'] = this.loadingGoodsWeight;
    data['reportBusinessTypeCode'] = this.reportBusinessTypeCode;
    data['goodsVolume'] = this.goodsVolume;
    data['originalConsignOrgName'] = this.originalConsignOrgName;
    data['loadingUserPhone'] = this.loadingUserPhone;
    data['dispatchUserCode'] = this.dispatchUserCode;
    data['unloadingCountyCode'] = this.unloadingCountyCode;
    data['loadingAttachment'] = this.loadingAttachment;
    data['unloadingOrgName'] = this.unloadingOrgName;
    data['regTonnage'] = this.regTonnage;
    data['unloadingProvinceCode'] = this.unloadingProvinceCode;
    data['unloadingGoodsVolume'] = this.unloadingGoodsVolume;
    data['unloadingGoodsVolumeUnitCode'] = this.unloadingGoodsVolumeUnitCode;
    data['departMileageUnitCode'] = this.departMileageUnitCode;
    data['driverPhone'] = this.driverPhone;
    data['payeePlatformDriverCode'] = this.payeePlatformDriverCode;
    data['waybillNo'] = this.waybillNo;
    return data;
  }
}

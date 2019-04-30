class WaybillDetailPageMode {
  num code;
  WaybillDetailContent content;

  WaybillDetailPageMode({this.code, this.content});

  WaybillDetailPageMode.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    content =
        json['content'] != null ? new WaybillDetailContent.fromJson(json['content']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.content != null) {
      data['content'] = this.content.toJson();
    }
    return data;
  }
}

class WaybillDetailContent {
  String serviceSupplyOrgName;
  String platformOriginalConsignOrgCode;
  String unloadingAddrLat;
  String loadingTime;
  String driverIdentityNumber;
  String reportCapitalStatus;
  String platformDriverCode;
  String platformTruckCode;
  String payeeDriverFullName;
  String truckQty;
  String loadingGoodsNumCount;
  String platformCarrierOrgCode;
  String loadingCountyName;
  String loadingAddr;
  String unloadingAddr;
  String meterageType;
  String loadingAttachmentExecuteOrgCode;
  String unloadingCountyName;
  String unloadingInputTime;
  String loadingInputTime;
  String unloadingAddress;
  String unloadingGoodsWeightUnitCode;
  String unloadingAttachmentExecuteTime;
  String unloadingAttachment;
  num id;
  String goodsName;
  String carrierOwnerPlatformUserCode;
  String loadingProvinceName;
  String routeCode;
  String trailerTruckLicenseNo;
  String driverConfirmTime;
  String consignOrgName;
  String logisticsExternalNo1;
  String creatorUserCode;
  String cargoTypeClassificationCode;
  String ownerUserCode;
  String ip;
  String synchronousId;
  String unloadingAttachmentExecuteUserFullName;
  String unloadingCityName;
  String unloadingUserPhone;
  String loadingAttachmentExecuteUserCode;
  String platformClientOrgCode;
  String dispatchOrgName;
  String goodsWeightUnitCode;
  String ownerOrgCode;
  String scheduleType;
  String loadingCityName;
  String clientSettleMethod;
  String loadingOrgName;
  String driverReferPriceUnitCode;
  String currentActionCode;
  String truckLicenseNo;
  String unloadingAttachmentExecuteOrgCode;
  String goodsLossMethod;
  String platformDispatchOrgCode;
  String loadingAttachmentExecuteTime;
  String settleStatus;
  String standardDistanceUnitCode;
  String loadingAddrLon;
  num unloadingGoodsWeight;
  num goodsWeight;
  String carrierOrgName;
  String driverCode;
  num waybillType;
  String clientFreightPriceUnitCode;
  bool disabled;
  String settleMethod;
  String unloadingAttachmentExecuteOrgName;
  String moduleCode;
  String loadingGoodsWeightUnitCode;
  String unloadingProvinceName;
  String payeeDriverPhone;
  String updateTime;
  String platformConsignOrgCode;
  String businessTypeCode;
  String unloadingInputUserFullName;
  bool deleted;
  String createTime;
  String downSettleStatus;
  num loadingGoodsVolume;
  num clientFreightPrice;
  String consignStartTime;
  String clientOrgName;
  String unloadingAddrLon;
  String clientContractName;
  String unloadingUserFullName;
  String originalConsignOrgCode;
  String platformDispatchUserCode;
  String carrierOwnerUserCode;
  String settlePaymentPayStatus;
  String consignEvaluation;
  String unloadingCityCode;
  String complianceStatus;
  String upSettleStatus;
  String loadingGoodsVolumeUnitCode;
  String routeName;
  String loadingCountyCode;
  String clientOrgCode;
  num unloadingGoodsNum;
  String unloadingAttachmentExecuteUserCode;
  String unloadingTime;
  String dispatchOrgCode;
  String currentActionName;
  String loadingCityCode;
  String truckCode;
  String unloadingGoodsNumUnitCode;
  String remainTruckQty;
  String carrierOwnerUserFullname;
  String loadingAttachmentExecuteUserFullName;
  String dispatchPrintStatus;
  String trailerTruckCode;
  String driverConfirmStatus;
  String logisticsCode;
  String reportStatus;
  String serviceSupplyOrgCode;
  String goodsVolumeUnitCode;
  String updateUserCode;
  String loadingAttachmentExecuteOrgName;
  String creatorUsername;
  String updateUsername;
  String logisticsNo;
  String loadingProvinceCode;
  String logisticsPlanEndTime;
  String goodsNumUnitCode;
  String loadingInputUserFullName;
  num loadingGoodsNum;
  String dispatchUserFullName;
  String driverReferPrice;
  String code;
  String platformTrailerTruckCode;
  String ownerOrgName;
  String loadingUserFullName;
  String driverPriceUnitCode;
  String clientContractCode;
  String waybillStatus;
  String ratesDescription;
  num goodsNum;
  String loadingGoodsNumUnitCode;
  String consignOrgCode;
  String paymentStatus;
  num driverPrice;
  String driverFullName;
  String payeeDriverCode;
  String loadingAddrLat;
  String informationFeeSet;
  num loadingGoodsWeight;
  num goodsVolume;
  String originalConsignOrgName;
  String loadingAddress;
  String loadingUserPhone;
  String dispatchUserCode;
  String shuntedNum;
  String unloadingCountyCode;
  String loadingAttachment;
  String unloadingOrgName;
  String unloadingProvinceCode;
  num unloadingGoodsVolume;
  String unloadingGoodsVolumeUnitCode;
  String loadingNum;
  String carrierOrgCode;
  String driverPhone;
  String truckQtyUnitCode;
  String goingNum;
  String logisticsPlanStartTime;
  String logisticsStatus;
  String payeePlatformDriverCode;
  String waybillNo;

  WaybillDetailContent(
      {this.serviceSupplyOrgName,
      this.platformOriginalConsignOrgCode,
      this.unloadingAddrLat,
      this.loadingTime,
      this.reportCapitalStatus,
      this.driverIdentityNumber,
      this.platformDriverCode,
      this.platformTruckCode,
      this.payeeDriverFullName,
      this.truckQty,
      this.loadingGoodsNumCount,
      this.platformCarrierOrgCode,
      this.loadingCountyName,
      this.meterageType,
      this.loadingAttachmentExecuteOrgCode,
      this.unloadingCountyName,
      this.unloadingInputTime,
      this.loadingInputTime,
      this.unloadingAddress,
      this.loadingAddr,
      this.unloadingAddr,
      this.unloadingGoodsWeightUnitCode,
      this.unloadingAttachmentExecuteTime,
      this.unloadingAttachment,
      this.id,
      this.goodsName,
      this.carrierOwnerPlatformUserCode,
      this.loadingProvinceName,
      this.routeCode,
      this.trailerTruckLicenseNo,
      this.driverConfirmTime,
      this.consignOrgName,
      this.logisticsExternalNo1,
      this.creatorUserCode,
      this.cargoTypeClassificationCode,
      this.ownerUserCode,
      this.ip,
      this.synchronousId,
      this.unloadingAttachmentExecuteUserFullName,
      this.unloadingCityName,
      this.unloadingUserPhone,
      this.loadingAttachmentExecuteUserCode,
      this.platformClientOrgCode,
      this.dispatchOrgName,
      this.goodsWeightUnitCode,
      this.ownerOrgCode,
      this.scheduleType,
      this.loadingCityName,
      this.clientSettleMethod,
      this.loadingOrgName,
      this.driverReferPriceUnitCode,
      this.currentActionCode,
      this.truckLicenseNo,
      this.unloadingAttachmentExecuteOrgCode,
      this.goodsLossMethod,
      this.platformDispatchOrgCode,
      this.loadingAttachmentExecuteTime,
      this.settleStatus,
      this.standardDistanceUnitCode,
      this.loadingAddrLon,
      this.unloadingGoodsWeight,
      this.goodsWeight,
      this.carrierOrgName,
      this.driverCode,
      this.waybillType,
      this.clientFreightPriceUnitCode,
      this.disabled,
      this.settleMethod,
      this.unloadingAttachmentExecuteOrgName,
      this.moduleCode,
      this.loadingGoodsWeightUnitCode,
      this.unloadingProvinceName,
      this.payeeDriverPhone,
      this.updateTime,
      this.platformConsignOrgCode,
      this.businessTypeCode,
      this.unloadingInputUserFullName,
      this.deleted,
      this.createTime,
      this.downSettleStatus,
      this.loadingGoodsVolume,
      this.clientFreightPrice,
      this.consignStartTime,
      this.clientOrgName,
      this.unloadingAddrLon,
      this.clientContractName,
      this.unloadingUserFullName,
      this.originalConsignOrgCode,
      this.platformDispatchUserCode,
      this.carrierOwnerUserCode,
      this.settlePaymentPayStatus,
      this.consignEvaluation,
      this.unloadingCityCode,
      this.complianceStatus,
      this.upSettleStatus,
      this.loadingGoodsVolumeUnitCode,
      this.routeName,
      this.loadingCountyCode,
      this.clientOrgCode,
      this.unloadingGoodsNum,
      this.unloadingAttachmentExecuteUserCode,
      this.unloadingTime,
      this.dispatchOrgCode,
      this.currentActionName,
      this.loadingCityCode,
      this.truckCode,
      this.unloadingGoodsNumUnitCode,
      this.remainTruckQty,
      this.carrierOwnerUserFullname,
      this.loadingAttachmentExecuteUserFullName,
      this.dispatchPrintStatus,
      this.trailerTruckCode,
      this.driverConfirmStatus,
      this.logisticsCode,
      this.reportStatus,
      this.serviceSupplyOrgCode,
      this.goodsVolumeUnitCode,
      this.updateUserCode,
      this.loadingAttachmentExecuteOrgName,
      this.creatorUsername,
      this.updateUsername,
      this.logisticsNo,
      this.loadingProvinceCode,
      this.logisticsPlanEndTime,
      this.goodsNumUnitCode,
      this.loadingInputUserFullName,
      this.loadingGoodsNum,
      this.dispatchUserFullName,
      this.driverReferPrice,
      this.code,
      this.platformTrailerTruckCode,
      this.ownerOrgName,
      this.loadingUserFullName,
      this.driverPriceUnitCode,
      this.clientContractCode,
      this.waybillStatus,
      this.ratesDescription,
      this.goodsNum,
      this.loadingGoodsNumUnitCode,
      this.consignOrgCode,
      this.paymentStatus,
      this.driverPrice,
      this.driverFullName,
      this.payeeDriverCode,
      this.loadingAddrLat,
      this.informationFeeSet,
      this.loadingGoodsWeight,
      this.goodsVolume,
      this.originalConsignOrgName,
      this.loadingAddress,
      this.loadingUserPhone,
      this.dispatchUserCode,
      this.shuntedNum,
      this.unloadingCountyCode,
      this.loadingAttachment,
      this.unloadingOrgName,
      this.unloadingProvinceCode,
      this.unloadingGoodsVolume,
      this.unloadingGoodsVolumeUnitCode,
      this.loadingNum,
      this.carrierOrgCode,
      this.driverPhone,
      this.truckQtyUnitCode,
      this.goingNum,
      this.logisticsPlanStartTime,
      this.logisticsStatus,
      this.payeePlatformDriverCode,
      this.waybillNo});

  WaybillDetailContent.fromJson(Map<String, dynamic> json) {
    serviceSupplyOrgName = json['serviceSupplyOrgName'];
    platformOriginalConsignOrgCode = json['platformOriginalConsignOrgCode'];
    unloadingAddrLat = json['unloadingAddrLat'];
    loadingTime = json['loadingTime'];
    reportCapitalStatus = json['reportCapitalStatus'];
    platformDriverCode = json['platformDriverCode'];
    platformTruckCode = json['platformTruckCode'];
    payeeDriverFullName = json['payeeDriverFullName'];
    truckQty = json['truckQty'];
    loadingAddr = json['loadingAddr'];
    driverIdentityNumber =json['driverIdentityNumber'];
    unloadingAddr =json['unloadingAddr'];
    loadingGoodsNumCount = json['loadingGoodsNumCount'];
    platformCarrierOrgCode = json['platformCarrierOrgCode'];
    loadingCountyName = json['loadingCountyName'];
    meterageType = json['meterageType'];
    loadingAttachmentExecuteOrgCode = json['loadingAttachmentExecuteOrgCode'];
    unloadingCountyName = json['unloadingCountyName'];
    unloadingInputTime = json['unloadingInputTime'];
    loadingInputTime = json['loadingInputTime'];
    unloadingAddress = json['unloadingAddress'];
    unloadingGoodsWeightUnitCode = json['unloadingGoodsWeightUnitCode'];
    unloadingAttachmentExecuteTime = json['unloadingAttachmentExecuteTime'];
    unloadingAttachment = json['unloadingAttachment'];
    id = json['id'];
    goodsName = json['goodsName'];
    carrierOwnerPlatformUserCode = json['carrierOwnerPlatformUserCode'];
    loadingProvinceName = json['loadingProvinceName'];
    routeCode = json['routeCode'];
    trailerTruckLicenseNo = json['trailerTruckLicenseNo'];
    driverConfirmTime = json['driverConfirmTime'];
    consignOrgName = json['consignOrgName'];
    logisticsExternalNo1 = json['logisticsExternalNo1'];
    creatorUserCode = json['creatorUserCode'];
    cargoTypeClassificationCode = json['cargoTypeClassificationCode'];
    ownerUserCode = json['ownerUserCode'];
    ip = json['ip'];
    synchronousId = json['synchronousId'];
    unloadingAttachmentExecuteUserFullName =
        json['unloadingAttachmentExecuteUserFullName'];
    unloadingCityName = json['unloadingCityName'];
    unloadingUserPhone = json['unloadingUserPhone'];
    loadingAttachmentExecuteUserCode = json['loadingAttachmentExecuteUserCode'];
    platformClientOrgCode = json['platformClientOrgCode'];
    dispatchOrgName = json['dispatchOrgName'];
    goodsWeightUnitCode = json['goodsWeightUnitCode'];
    ownerOrgCode = json['ownerOrgCode'];
    scheduleType = json['scheduleType'];
    loadingCityName = json['loadingCityName'];
    clientSettleMethod = json['clientSettleMethod'];
    loadingOrgName = json['loadingOrgName'];
    driverReferPriceUnitCode = json['driverReferPriceUnitCode'];
    currentActionCode = json['currentActionCode'];
    truckLicenseNo = json['truckLicenseNo'];
    unloadingAttachmentExecuteOrgCode =
        json['unloadingAttachmentExecuteOrgCode'];
    goodsLossMethod = json['goodsLossMethod'];
    platformDispatchOrgCode = json['platformDispatchOrgCode'];
    loadingAttachmentExecuteTime = json['loadingAttachmentExecuteTime'];
    settleStatus = json['settleStatus'];
    standardDistanceUnitCode = json['standardDistanceUnitCode'];
    loadingAddrLon = json['loadingAddrLon'];
    unloadingGoodsWeight = json['unloadingGoodsWeight'];
    goodsWeight = json['goodsWeight'];
    carrierOrgName = json['carrierOrgName'];
    driverCode = json['driverCode'];
    waybillType = json['waybillType'];
    clientFreightPriceUnitCode = json['clientFreightPriceUnitCode'];
    disabled = json['disabled'];
    settleMethod = json['settleMethod'];
    unloadingAttachmentExecuteOrgName =
        json['unloadingAttachmentExecuteOrgName'];
    moduleCode = json['moduleCode'];
    loadingGoodsWeightUnitCode = json['loadingGoodsWeightUnitCode'];
    unloadingProvinceName = json['unloadingProvinceName'];
    payeeDriverPhone = json['payeeDriverPhone'];
    updateTime = json['updateTime'];
    platformConsignOrgCode = json['platformConsignOrgCode'];
    businessTypeCode = json['businessTypeCode'];
    unloadingInputUserFullName = json['unloadingInputUserFullName'];
    deleted = json['deleted'];
    createTime = json['createTime'];
    downSettleStatus = json['downSettleStatus'];
    loadingGoodsVolume = json['loadingGoodsVolume'];
    clientFreightPrice = json['clientFreightPrice'];
    consignStartTime = json['consignStartTime'];
    clientOrgName = json['clientOrgName'];
    unloadingAddrLon = json['unloadingAddrLon'];
    clientContractName = json['clientContractName'];
    unloadingUserFullName = json['unloadingUserFullName'];
    originalConsignOrgCode = json['originalConsignOrgCode'];
    platformDispatchUserCode = json['platformDispatchUserCode'];
    carrierOwnerUserCode = json['carrierOwnerUserCode'];
    settlePaymentPayStatus = json['settlePaymentPayStatus'];
    consignEvaluation = json['consignEvaluation'];
    unloadingCityCode = json['unloadingCityCode'];
    complianceStatus = json['complianceStatus'];
    upSettleStatus = json['upSettleStatus'];
    loadingGoodsVolumeUnitCode = json['loadingGoodsVolumeUnitCode'];
    routeName = json['routeName'];
    loadingCountyCode = json['loadingCountyCode'];
    clientOrgCode = json['clientOrgCode'];
    unloadingGoodsNum = json['unloadingGoodsNum'];
    unloadingAttachmentExecuteUserCode =
        json['unloadingAttachmentExecuteUserCode'];
    unloadingTime = json['unloadingTime'];
    dispatchOrgCode = json['dispatchOrgCode'];
    currentActionName = json['currentActionName'];
    loadingCityCode = json['loadingCityCode'];
    truckCode = json['truckCode'];
    unloadingGoodsNumUnitCode = json['unloadingGoodsNumUnitCode'];
    remainTruckQty = json['remainTruckQty'];
    carrierOwnerUserFullname = json['carrierOwnerUserFullname'];
    loadingAttachmentExecuteUserFullName =
        json['loadingAttachmentExecuteUserFullName'];
    dispatchPrintStatus = json['dispatchPrintStatus'];
    trailerTruckCode = json['trailerTruckCode'];
    driverConfirmStatus = json['driverConfirmStatus'];
    logisticsCode = json['logisticsCode'];
    reportStatus = json['reportStatus'];
    serviceSupplyOrgCode = json['serviceSupplyOrgCode'];
    goodsVolumeUnitCode = json['goodsVolumeUnitCode'];
    updateUserCode = json['updateUserCode'];
    loadingAttachmentExecuteOrgName = json['loadingAttachmentExecuteOrgName'];
    creatorUsername = json['creatorUsername'];
    updateUsername = json['updateUsername'];
    logisticsNo = json['logisticsNo'];
    loadingProvinceCode = json['loadingProvinceCode'];
    logisticsPlanEndTime = json['logisticsPlanEndTime'];
    goodsNumUnitCode = json['goodsNumUnitCode'];
    loadingInputUserFullName = json['loadingInputUserFullName'];
    loadingGoodsNum = json['loadingGoodsNum'];
    dispatchUserFullName = json['dispatchUserFullName'];
    driverReferPrice = json['driverReferPrice'];
    code = json['code'];
    platformTrailerTruckCode = json['platformTrailerTruckCode'];
    ownerOrgName = json['ownerOrgName'];
    loadingUserFullName = json['loadingUserFullName'];
    driverPriceUnitCode = json['driverPriceUnitCode'];
    clientContractCode = json['clientContractCode'];
    waybillStatus = json['waybillStatus'];
    ratesDescription = json['ratesDescription'];
    goodsNum = json['goodsNum'];
    loadingGoodsNumUnitCode = json['loadingGoodsNumUnitCode'];
    consignOrgCode = json['consignOrgCode'];
    paymentStatus = json['paymentStatus'];
    driverPrice = json['driverPrice'];
    driverFullName = json['driverFullName'];
    payeeDriverCode = json['payeeDriverCode'];
    loadingAddrLat = json['loadingAddrLat'];
    informationFeeSet = json['informationFeeSet'];
    loadingGoodsWeight = json['loadingGoodsWeight'];
    goodsVolume = json['goodsVolume'];
    originalConsignOrgName = json['originalConsignOrgName'];
    loadingAddress = json['loadingAddress'];
    loadingUserPhone = json['loadingUserPhone'];
    dispatchUserCode = json['dispatchUserCode'];
    shuntedNum = json['shuntedNum'];
    unloadingCountyCode = json['unloadingCountyCode'];
    loadingAttachment = json['loadingAttachment'];
    unloadingOrgName = json['unloadingOrgName'];
    unloadingProvinceCode = json['unloadingProvinceCode'];
    unloadingGoodsVolume = json['unloadingGoodsVolume'];
    unloadingGoodsVolumeUnitCode = json['unloadingGoodsVolumeUnitCode'];
    loadingNum = json['loadingNum'];
    carrierOrgCode = json['carrierOrgCode'];
    driverPhone = json['driverPhone'];
    truckQtyUnitCode = json['truckQtyUnitCode'];
    goingNum = json['goingNum'];
    logisticsPlanStartTime = json['logisticsPlanStartTime'];
    logisticsStatus = json['logisticsStatus'];
    payeePlatformDriverCode = json['payeePlatformDriverCode'];
    waybillNo = json['waybillNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serviceSupplyOrgName'] = this.serviceSupplyOrgName;
    data['platformOriginalConsignOrgCode'] =
        this.platformOriginalConsignOrgCode;
    data['unloadingAddrLat'] = this.unloadingAddrLat;
    data['loadingTime'] = this.loadingTime;
    data['reportCapitalStatus'] = this.reportCapitalStatus;
    data['platformDriverCode'] = this.platformDriverCode;
    data['platformTruckCode'] = this.platformTruckCode;
    data['payeeDriverFullName'] = this.payeeDriverFullName;
    data['truckQty'] = this.truckQty;
    data['loadingGoodsNumCount'] = this.loadingGoodsNumCount;
    data['platformCarrierOrgCode'] = this.platformCarrierOrgCode;
    data['loadingCountyName'] = this.loadingCountyName;
    data['meterageType'] = this.meterageType;
    data['loadingAttachmentExecuteOrgCode'] =
        this.loadingAttachmentExecuteOrgCode;
    data['unloadingCountyName'] = this.unloadingCountyName;
    data['unloadingInputTime'] = this.unloadingInputTime;
    data['loadingInputTime'] = this.loadingInputTime;
    data['unloadingAddress'] = this.unloadingAddress;
    data['unloadingGoodsWeightUnitCode'] = this.unloadingGoodsWeightUnitCode;
    data['unloadingAttachmentExecuteTime'] =
        this.unloadingAttachmentExecuteTime;
    data['unloadingAttachment'] = this.unloadingAttachment;
    data['id'] = this.id;
    data['goodsName'] = this.goodsName;
    data['carrierOwnerPlatformUserCode'] = this.carrierOwnerPlatformUserCode;
    data['loadingProvinceName'] = this.loadingProvinceName;
    data['routeCode'] = this.routeCode;
    data['trailerTruckLicenseNo'] = this.trailerTruckLicenseNo;
    data['driverConfirmTime'] = this.driverConfirmTime;
    data['consignOrgName'] = this.consignOrgName;
    data['logisticsExternalNo1'] = this.logisticsExternalNo1;
    data['creatorUserCode'] = this.creatorUserCode;
    data['cargoTypeClassificationCode'] = this.cargoTypeClassificationCode;
    data['ownerUserCode'] = this.ownerUserCode;
    data['ip'] = this.ip;
    data['synchronousId'] = this.synchronousId;
    data['unloadingAttachmentExecuteUserFullName'] =
        this.unloadingAttachmentExecuteUserFullName;
    data['unloadingCityName'] = this.unloadingCityName;
    data['unloadingUserPhone'] = this.unloadingUserPhone;
    data['loadingAttachmentExecuteUserCode'] =
        this.loadingAttachmentExecuteUserCode;
    data['platformClientOrgCode'] = this.platformClientOrgCode;
    data['dispatchOrgName'] = this.dispatchOrgName;
    data['goodsWeightUnitCode'] = this.goodsWeightUnitCode;
    data['ownerOrgCode'] = this.ownerOrgCode;
    data['scheduleType'] = this.scheduleType;
    data['loadingCityName'] = this.loadingCityName;
    data['clientSettleMethod'] = this.clientSettleMethod;
    data['loadingOrgName'] = this.loadingOrgName;
    data['driverReferPriceUnitCode'] = this.driverReferPriceUnitCode;
    data['currentActionCode'] = this.currentActionCode;
    data['truckLicenseNo'] = this.truckLicenseNo;
    data['unloadingAttachmentExecuteOrgCode'] =
        this.unloadingAttachmentExecuteOrgCode;
    data['goodsLossMethod'] = this.goodsLossMethod;
    data['platformDispatchOrgCode'] = this.platformDispatchOrgCode;
    data['loadingAttachmentExecuteTime'] = this.loadingAttachmentExecuteTime;
    data['settleStatus'] = this.settleStatus;
    data['standardDistanceUnitCode'] = this.standardDistanceUnitCode;
    data['loadingAddrLon'] = this.loadingAddrLon;
    data['unloadingGoodsWeight'] = this.unloadingGoodsWeight;
    data['goodsWeight'] = this.goodsWeight;
    data['carrierOrgName'] = this.carrierOrgName;
    data['driverCode'] = this.driverCode;
    data['waybillType'] = this.waybillType;
    data['clientFreightPriceUnitCode'] = this.clientFreightPriceUnitCode;
    data['disabled'] = this.disabled;
    data['settleMethod'] = this.settleMethod;
    data['unloadingAttachmentExecuteOrgName'] =
        this.unloadingAttachmentExecuteOrgName;
    data['moduleCode'] = this.moduleCode;
    data['loadingGoodsWeightUnitCode'] = this.loadingGoodsWeightUnitCode;
    data['unloadingProvinceName'] = this.unloadingProvinceName;
    data['payeeDriverPhone'] = this.payeeDriverPhone;
    data['updateTime'] = this.updateTime;
    data['platformConsignOrgCode'] = this.platformConsignOrgCode;
    data['businessTypeCode'] = this.businessTypeCode;
    data['unloadingInputUserFullName'] = this.unloadingInputUserFullName;
    data['deleted'] = this.deleted;
    data['createTime'] = this.createTime;
    data['downSettleStatus'] = this.downSettleStatus;
    data['loadingGoodsVolume'] = this.loadingGoodsVolume;
    data['clientFreightPrice'] = this.clientFreightPrice;
    data['consignStartTime'] = this.consignStartTime;
    data['clientOrgName'] = this.clientOrgName;
    data['unloadingAddrLon'] = this.unloadingAddrLon;
    data['clientContractName'] = this.clientContractName;
    data['unloadingUserFullName'] = this.unloadingUserFullName;
    data['originalConsignOrgCode'] = this.originalConsignOrgCode;
    data['platformDispatchUserCode'] = this.platformDispatchUserCode;
    data['carrierOwnerUserCode'] = this.carrierOwnerUserCode;
    data['settlePaymentPayStatus'] = this.settlePaymentPayStatus;
    data['consignEvaluation'] = this.consignEvaluation;
    data['unloadingCityCode'] = this.unloadingCityCode;
    data['complianceStatus'] = this.complianceStatus;
    data['upSettleStatus'] = this.upSettleStatus;
    data['loadingGoodsVolumeUnitCode'] = this.loadingGoodsVolumeUnitCode;
    data['routeName'] = this.routeName;
    data['loadingCountyCode'] = this.loadingCountyCode;
    data['clientOrgCode'] = this.clientOrgCode;
    data['unloadingGoodsNum'] = this.unloadingGoodsNum;
    data['unloadingAttachmentExecuteUserCode'] =
        this.unloadingAttachmentExecuteUserCode;
    data['unloadingTime'] = this.unloadingTime;
    data['dispatchOrgCode'] = this.dispatchOrgCode;
    data['currentActionName'] = this.currentActionName;
    data['loadingCityCode'] = this.loadingCityCode;
    data['truckCode'] = this.truckCode;
    data['unloadingGoodsNumUnitCode'] = this.unloadingGoodsNumUnitCode;
    data['remainTruckQty'] = this.remainTruckQty;
    data['carrierOwnerUserFullname'] = this.carrierOwnerUserFullname;
    data['loadingAttachmentExecuteUserFullName'] =
        this.loadingAttachmentExecuteUserFullName;
    data['dispatchPrintStatus'] = this.dispatchPrintStatus;
    data['trailerTruckCode'] = this.trailerTruckCode;
    data['driverConfirmStatus'] = this.driverConfirmStatus;
    data['logisticsCode'] = this.logisticsCode;
    data['reportStatus'] = this.reportStatus;
    data['serviceSupplyOrgCode'] = this.serviceSupplyOrgCode;
    data['goodsVolumeUnitCode'] = this.goodsVolumeUnitCode;
    data['updateUserCode'] = this.updateUserCode;
    data['loadingAttachmentExecuteOrgName'] =
        this.loadingAttachmentExecuteOrgName;
    data['creatorUsername'] = this.creatorUsername;
    data['updateUsername'] = this.updateUsername;
    data['logisticsNo'] = this.logisticsNo;
    data['loadingProvinceCode'] = this.loadingProvinceCode;
    data['logisticsPlanEndTime'] = this.logisticsPlanEndTime;
    data['goodsNumUnitCode'] = this.goodsNumUnitCode;
    data['loadingInputUserFullName'] = this.loadingInputUserFullName;
    data['loadingGoodsNum'] = this.loadingGoodsNum;
    data['dispatchUserFullName'] = this.dispatchUserFullName;
    data['driverReferPrice'] = this.driverReferPrice;
    data['code'] = this.code;
    data['platformTrailerTruckCode'] = this.platformTrailerTruckCode;
    data['ownerOrgName'] = this.ownerOrgName;
    data['loadingUserFullName'] = this.loadingUserFullName;
    data['driverPriceUnitCode'] = this.driverPriceUnitCode;
    data['clientContractCode'] = this.clientContractCode;
    data['waybillStatus'] = this.waybillStatus;
    data['ratesDescription'] = this.ratesDescription;
    data['goodsNum'] = this.goodsNum;
    data['loadingGoodsNumUnitCode'] = this.loadingGoodsNumUnitCode;
    data['consignOrgCode'] = this.consignOrgCode;
    data['paymentStatus'] = this.paymentStatus;
    data['driverPrice'] = this.driverPrice;
    data['driverFullName'] = this.driverFullName;
    data['payeeDriverCode'] = this.payeeDriverCode;
    data['loadingAddrLat'] = this.loadingAddrLat;
    data['informationFeeSet'] = this.informationFeeSet;
    data['loadingGoodsWeight'] = this.loadingGoodsWeight;
    data['goodsVolume'] = this.goodsVolume;
    data['originalConsignOrgName'] = this.originalConsignOrgName;
    data['loadingAddress'] = this.loadingAddress;
    data['loadingUserPhone'] = this.loadingUserPhone;
    data['dispatchUserCode'] = this.dispatchUserCode;
    data['shuntedNum'] = this.shuntedNum;
    data['unloadingCountyCode'] = this.unloadingCountyCode;
    data['loadingAttachment'] = this.loadingAttachment;
    data['unloadingOrgName'] = this.unloadingOrgName;
    data['unloadingProvinceCode'] = this.unloadingProvinceCode;
    data['unloadingGoodsVolume'] = this.unloadingGoodsVolume;
    data['unloadingGoodsVolumeUnitCode'] = this.unloadingGoodsVolumeUnitCode;
    data['loadingNum'] = this.loadingNum;
    data['carrierOrgCode'] = this.carrierOrgCode;
    data['driverPhone'] = this.driverPhone;
    data['truckQtyUnitCode'] = this.truckQtyUnitCode;
    data['goingNum'] = this.goingNum;
    data['logisticsPlanStartTime'] = this.logisticsPlanStartTime;
    data['logisticsStatus'] = this.logisticsStatus;
    data['payeePlatformDriverCode'] = this.payeePlatformDriverCode;
    data['waybillNo'] = this.waybillNo;
    return data;
  }
}

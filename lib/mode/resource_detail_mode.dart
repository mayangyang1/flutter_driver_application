class ResourceDetailMode {
  num code;
  DetailMode content;

  ResourceDetailMode({this.code, this.content});

  ResourceDetailMode.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    content =
        json['content'] != null ? new DetailMode.fromJson(json['content']) : null;
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

class DetailMode {
  String unloadingUserFullName;
  String platformOriginalConsignOrgCode;
  String informationFeeUnitCode;
  String originalConsignOrgCode;
  String truckModelRequire;
  num goodsAmount;
  num goodsLoss;
  String unloadingCityCode;
  String quotePriceUnitCode;
  String freightNo;
  num truckQty;
  String description;
  String loadingCountyCode;
  String routeName;
  String loadingCountyName;
  String meterageType;
  String clientOrgCode;
  num informationFee;
  String loadingCityCode;
  String unloadingCountyName;
  String unloadingAddress;
  num id;
  String goodsName;
  String loadingProvinceName;
  String routeCode;
  String publishTime;
  num dispatchTruckNumber;
  String consignOrgName;
  String creatorUserCode;
  String cargoTypeClassificationCode;
  String truckLengthRequires;
  num goodsVolume;
  String ip;
  String ownerUserCode;
  String synchronousId;
  bool allowAcceptWaybill;
  String logisticsCode;
  String goodsVolumeUnitCode;
  String dispatchMode;
  String unloadingCityName;
  String publishUserFullName;
  num quotePrice;
  String unloadingUserPhone;
  String updateUserCode;
  String platformClientOrgCode;
  String goodsWeightUnitCode;
  String scheduleType;
  String ownerOrgCode;
  String loadingCityName;
  num goodsPrice;
  String creatorUsername;
  String loadingOrgName;
  String logisticsNo;
  String updateUsername;
  String loadingProvinceCode;
  String contactUserFullName;
  String status;
  String goodsLossMethod;
  String code;
  String quoteType;
  num goodsWeight;
  String ownerOrgName;
  String loadingUserFullName;
  String goodsPriceUnitCode;
  String clientFreightPriceUnitCode;
  bool disabled;
  String settleMethod;
  String consignOrgCode;
  String moduleCode;
  num acceptTruckNumber;
  String unloadingProvinceName;
  String goodsAmountUnitCode;
  String informationFeeSet;
  String updateTime;
  String originalConsignOrgName;
  String platformConsignOrgCode;
  String businessTypeCode;
  String releaseRange;
  String freightEndTime;
  String loadingAddress;
  String loadingUserPhone;
  String unloadingCountyCode;
  String unloadingOrgName;
  bool deleted;
  String createTime;
  String unloadingProvinceCode;
  String goodsLossUnitCode;
  String publishUserCode;
  num clientFreightPrice;
  String truckQtyUnitCode;
  String contactPhone;
  String clientOrgName;

  DetailMode(
      {this.unloadingUserFullName,
      this.platformOriginalConsignOrgCode,
      this.informationFeeUnitCode,
      this.originalConsignOrgCode,
      this.goodsLoss,
      this.unloadingCityCode,
      this.quotePriceUnitCode,
      this.freightNo,
      this.description,
      this.truckQty,
      this.goodsVolume,
      this.loadingCountyCode,
      this.truckModelRequire,
      this.routeName,
      this.goodsAmount,
      this.loadingCountyName,
      this.meterageType,
      this.clientOrgCode,
      this.informationFee,
      this.loadingCityCode,
      this.unloadingCountyName,
      this.unloadingAddress,
      this.id,
      this.goodsName,
      this.loadingProvinceName,
      this.routeCode,
      this.publishTime,
      this.dispatchTruckNumber,
      this.consignOrgName,
      this.creatorUserCode,
      this.cargoTypeClassificationCode,
      this.ip,
      this.ownerUserCode,
      this.synchronousId,
      this.allowAcceptWaybill,
      this.logisticsCode,
      this.goodsVolumeUnitCode,
      this.dispatchMode,
      this.unloadingCityName,
      this.publishUserFullName,
      this.quotePrice,
      this.unloadingUserPhone,
      this.updateUserCode,
      this.platformClientOrgCode,
      this.goodsWeightUnitCode,
      this.scheduleType,
      this.ownerOrgCode,
      this.loadingCityName,
      this.goodsPrice,
      this.creatorUsername,
      this.loadingOrgName,
      this.logisticsNo,
      this.updateUsername,
      this.loadingProvinceCode,
      this.contactUserFullName,
      this.truckLengthRequires,
      this.status,
      this.goodsLossMethod,
      this.code,
      this.quoteType,
      this.goodsWeight,
      this.ownerOrgName,
      this.loadingUserFullName,
      this.goodsPriceUnitCode,
      this.clientFreightPriceUnitCode,
      this.disabled,
      this.settleMethod,
      this.consignOrgCode,
      this.moduleCode,
      this.acceptTruckNumber,
      this.unloadingProvinceName,
      this.goodsAmountUnitCode,
      this.informationFeeSet,
      this.updateTime,
      this.originalConsignOrgName,
      this.platformConsignOrgCode,
      this.businessTypeCode,
      this.releaseRange,
      this.freightEndTime,
      this.loadingAddress,
      this.loadingUserPhone,
      this.unloadingCountyCode,
      this.unloadingOrgName,
      this.deleted,
      this.createTime,
      this.unloadingProvinceCode,
      this.goodsLossUnitCode,
      this.publishUserCode,
      this.clientFreightPrice,
      this.truckQtyUnitCode,
      this.contactPhone,
      this.clientOrgName});

  DetailMode.fromJson(Map<String, dynamic> json) {
    unloadingUserFullName = json['unloadingUserFullName'];
    platformOriginalConsignOrgCode = json['platformOriginalConsignOrgCode'];
    informationFeeUnitCode = json['informationFeeUnitCode'];
    originalConsignOrgCode = json['originalConsignOrgCode'];
    goodsLoss = json['goodsLoss'];
    unloadingCityCode = json['unloadingCityCode'];
    quotePriceUnitCode = json['quotePriceUnitCode'];
    freightNo = json['freightNo'];
    truckQty = json['truckQty'];
    description =json['description'];
    loadingCountyCode = json['loadingCountyCode'];
    routeName = json['routeName'];
    goodsAmount = json['goodsAmount'];
    loadingCountyName = json['loadingCountyName'];
    meterageType = json['meterageType'];
    clientOrgCode = json['clientOrgCode'];
    informationFee = json['informationFee'];
    loadingCityCode = json['loadingCityCode'];
    unloadingCountyName = json['unloadingCountyName'];
    unloadingAddress = json['unloadingAddress'];
    id = json['id'];
    goodsVolume = json['goodsVolume'];
    truckModelRequire = json['truckModelRequire'];
    truckLengthRequires =json['truckLengthRequires'];
    goodsName = json['goodsName'];
    loadingProvinceName = json['loadingProvinceName'];
    routeCode = json['routeCode'];
    publishTime = json['publishTime'];
    dispatchTruckNumber = json['dispatchTruckNumber'];
    consignOrgName = json['consignOrgName'];
    creatorUserCode = json['creatorUserCode'];
    cargoTypeClassificationCode = json['cargoTypeClassificationCode'];
    ip = json['ip'];
    ownerUserCode = json['ownerUserCode'];
    synchronousId = json['synchronousId'];
    allowAcceptWaybill = json['allowAcceptWaybill'];
    logisticsCode = json['logisticsCode'];
    goodsVolumeUnitCode = json['goodsVolumeUnitCode'];
    dispatchMode = json['dispatchMode'];
    unloadingCityName = json['unloadingCityName'];
    publishUserFullName = json['publishUserFullName'];
    quotePrice = json['quotePrice'];
    unloadingUserPhone = json['unloadingUserPhone'];
    updateUserCode = json['updateUserCode'];
    platformClientOrgCode = json['platformClientOrgCode'];
    goodsWeightUnitCode = json['goodsWeightUnitCode'];
    scheduleType = json['scheduleType'];
    ownerOrgCode = json['ownerOrgCode'];
    loadingCityName = json['loadingCityName'];
    goodsPrice = json['goodsPrice'];
    creatorUsername = json['creatorUsername'];
    loadingOrgName = json['loadingOrgName'];
    logisticsNo = json['logisticsNo'];
    updateUsername = json['updateUsername'];
    loadingProvinceCode = json['loadingProvinceCode'];
    contactUserFullName = json['contactUserFullName'];
    status = json['status'];
    goodsLossMethod = json['goodsLossMethod'];
    code = json['code'];
    quoteType = json['quoteType'];
    goodsWeight = json['goodsWeight'];
    ownerOrgName = json['ownerOrgName'];
    loadingUserFullName = json['loadingUserFullName'];
    goodsPriceUnitCode = json['goodsPriceUnitCode'];
    clientFreightPriceUnitCode = json['clientFreightPriceUnitCode'];
    disabled = json['disabled'];
    settleMethod = json['settleMethod'];
    consignOrgCode = json['consignOrgCode'];
    moduleCode = json['moduleCode'];
    acceptTruckNumber = json['acceptTruckNumber'];
    unloadingProvinceName = json['unloadingProvinceName'];
    goodsAmountUnitCode = json['goodsAmountUnitCode'];
    informationFeeSet = json['informationFeeSet'];
    updateTime = json['updateTime'];
    originalConsignOrgName = json['originalConsignOrgName'];
    platformConsignOrgCode = json['platformConsignOrgCode'];
    businessTypeCode = json['businessTypeCode'];
    releaseRange = json['releaseRange'];
    freightEndTime = json['freightEndTime'];
    loadingAddress = json['loadingAddress'];
    loadingUserPhone = json['loadingUserPhone'];
    unloadingCountyCode = json['unloadingCountyCode'];
    unloadingOrgName = json['unloadingOrgName'];
    deleted = json['deleted'];
    createTime = json['createTime'];
    unloadingProvinceCode = json['unloadingProvinceCode'];
    goodsLossUnitCode = json['goodsLossUnitCode'];
    publishUserCode = json['publishUserCode'];
    clientFreightPrice = json['clientFreightPrice'];
    truckQtyUnitCode = json['truckQtyUnitCode'];
    contactPhone = json['contactPhone'];
    clientOrgName = json['clientOrgName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unloadingUserFullName'] = this.unloadingUserFullName;
    data['platformOriginalConsignOrgCode'] =
        this.platformOriginalConsignOrgCode;
    data['informationFeeUnitCode'] = this.informationFeeUnitCode;
    data['originalConsignOrgCode'] = this.originalConsignOrgCode;
    data['goodsLoss'] = this.goodsLoss;
    data['unloadingCityCode'] = this.unloadingCityCode;
    data['quotePriceUnitCode'] = this.quotePriceUnitCode;
    data['freightNo'] = this.freightNo;
    data['truckQty'] = this.truckQty;
    data['loadingCountyCode'] = this.loadingCountyCode;
    data['routeName'] = this.routeName;
    data['loadingCountyName'] = this.loadingCountyName;
    data['meterageType'] = this.meterageType;
    data['clientOrgCode'] = this.clientOrgCode;
    data['informationFee'] = this.informationFee;
    data['loadingCityCode'] = this.loadingCityCode;
    data['unloadingCountyName'] = this.unloadingCountyName;
    data['unloadingAddress'] = this.unloadingAddress;
    data['id'] = this.id;
    data['goodsName'] = this.goodsName;
    data['loadingProvinceName'] = this.loadingProvinceName;
    data['routeCode'] = this.routeCode;
    data['publishTime'] = this.publishTime;
    data['dispatchTruckNumber'] = this.dispatchTruckNumber;
    data['consignOrgName'] = this.consignOrgName;
    data['creatorUserCode'] = this.creatorUserCode;
    data['cargoTypeClassificationCode'] = this.cargoTypeClassificationCode;
    data['ip'] = this.ip;
    data['ownerUserCode'] = this.ownerUserCode;
    data['synchronousId'] = this.synchronousId;
    data['allowAcceptWaybill'] = this.allowAcceptWaybill;
    data['logisticsCode'] = this.logisticsCode;
    data['goodsVolumeUnitCode'] = this.goodsVolumeUnitCode;
    data['dispatchMode'] = this.dispatchMode;
    data['unloadingCityName'] = this.unloadingCityName;
    data['publishUserFullName'] = this.publishUserFullName;
    data['quotePrice'] = this.quotePrice;
    data['unloadingUserPhone'] = this.unloadingUserPhone;
    data['updateUserCode'] = this.updateUserCode;
    data['platformClientOrgCode'] = this.platformClientOrgCode;
    data['goodsWeightUnitCode'] = this.goodsWeightUnitCode;
    data['scheduleType'] = this.scheduleType;
    data['ownerOrgCode'] = this.ownerOrgCode;
    data['loadingCityName'] = this.loadingCityName;
    data['goodsPrice'] = this.goodsPrice;
    data['creatorUsername'] = this.creatorUsername;
    data['loadingOrgName'] = this.loadingOrgName;
    data['logisticsNo'] = this.logisticsNo;
    data['updateUsername'] = this.updateUsername;
    data['loadingProvinceCode'] = this.loadingProvinceCode;
    data['contactUserFullName'] = this.contactUserFullName;
    data['status'] = this.status;
    data['goodsLossMethod'] = this.goodsLossMethod;
    data['code'] = this.code;
    data['quoteType'] = this.quoteType;
    data['goodsWeight'] = this.goodsWeight;
    data['ownerOrgName'] = this.ownerOrgName;
    data['loadingUserFullName'] = this.loadingUserFullName;
    data['goodsPriceUnitCode'] = this.goodsPriceUnitCode;
    data['clientFreightPriceUnitCode'] = this.clientFreightPriceUnitCode;
    data['disabled'] = this.disabled;
    data['settleMethod'] = this.settleMethod;
    data['consignOrgCode'] = this.consignOrgCode;
    data['moduleCode'] = this.moduleCode;
    data['acceptTruckNumber'] = this.acceptTruckNumber;
    data['unloadingProvinceName'] = this.unloadingProvinceName;
    data['goodsAmountUnitCode'] = this.goodsAmountUnitCode;
    data['informationFeeSet'] = this.informationFeeSet;
    data['updateTime'] = this.updateTime;
    data['originalConsignOrgName'] = this.originalConsignOrgName;
    data['platformConsignOrgCode'] = this.platformConsignOrgCode;
    data['businessTypeCode'] = this.businessTypeCode;
    data['releaseRange'] = this.releaseRange;
    data['freightEndTime'] = this.freightEndTime;
    data['loadingAddress'] = this.loadingAddress;
    data['loadingUserPhone'] = this.loadingUserPhone;
    data['unloadingCountyCode'] = this.unloadingCountyCode;
    data['unloadingOrgName'] = this.unloadingOrgName;
    data['deleted'] = this.deleted;
    data['createTime'] = this.createTime;
    data['unloadingProvinceCode'] = this.unloadingProvinceCode;
    data['goodsLossUnitCode'] = this.goodsLossUnitCode;
    data['publishUserCode'] = this.publishUserCode;
    data['clientFreightPrice'] = this.clientFreightPrice;
    data['truckQtyUnitCode'] = this.truckQtyUnitCode;
    data['contactPhone'] = this.contactPhone;
    data['clientOrgName'] = this.clientOrgName;
    return data;
  }
}

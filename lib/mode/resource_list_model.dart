class ResourceListMode {
  int code;
  List<Content> content;
  int mark;
  int total;

  ResourceListMode({this.code, this.content, this.mark, this.total});

  ResourceListMode.fromJson(Map<String, dynamic> json) {
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
  String originalConsignOrgCode;
  num goodsLoss;
  String unloadingCityCode;
  String quotePriceUnitCode;
  String freightNo;
  num truckQty;
  String loadingCountyCode;
  String routeName;
  String loadingCountyName;
  String meterageType;
  String clientOrgCode;
  String loadingCityCode;
  String unloadingCountyName;
  String unloadingAddress;
  num id;
  String goodsName;
  String loadingProvinceName;
  String routeCode;
  String publishTime;
  String consignOrgName;
  String creatorUserCode;
  String cargoTypeClassificationCode;
  String ip;
  String ownerUserCode;
  String logisticsCode;
  String synchronousId;
  String goodsVolumeUnitCode;
  String dispatchMode;
  String publishUserFullName;
  String unloadingCityName;
  num quotePrice;
  String updateUserCode;
  String platformClientOrgCode;
  String goodsWeightUnitCode;
  String scheduleType;
  String ownerOrgCode;
  String loadingCityName;
  String creatorUsername;
  num goodsPrice;
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
  String goodsPriceUnitCode;
  String clientFreightPriceUnitCode;
  bool disabled;
  String settleMethod;
  String consignOrgCode;
  String moduleCode;
  String unloadingProvinceName;
  String goodsAmountUnitCode;
  String originalConsignOrgName;
  String updateTime;
  String platformConsignOrgCode;
  String businessTypeCode;
  String releaseRange;
  String freightEndTime;
  String loadingAddress;
  String unloadingCountyCode;
  bool deleted;
  String unloadingProvinceCode;
  String createTime;
  String goodsLossUnitCode;
  String publishUserCode;
  String truckQtyUnitCode;
  num clientFreightPrice;
  String contactPhone;
  String clientOrgName;

  Content(
      {this.platformOriginalConsignOrgCode,
      this.originalConsignOrgCode,
      this.goodsLoss,
      this.unloadingCityCode,
      this.quotePriceUnitCode,
      this.freightNo,
      this.truckQty,
      this.loadingCountyCode,
      this.routeName,
      this.loadingCountyName,
      this.meterageType,
      this.clientOrgCode,
      this.loadingCityCode,
      this.unloadingCountyName,
      this.unloadingAddress,
      this.id,
      this.goodsName,
      this.loadingProvinceName,
      this.routeCode,
      this.publishTime,
      this.consignOrgName,
      this.creatorUserCode,
      this.cargoTypeClassificationCode,
      this.ip,
      this.ownerUserCode,
      this.logisticsCode,
      this.synchronousId,
      this.goodsVolumeUnitCode,
      this.dispatchMode,
      this.publishUserFullName,
      this.unloadingCityName,
      this.quotePrice,
      this.updateUserCode,
      this.platformClientOrgCode,
      this.goodsWeightUnitCode,
      this.scheduleType,
      this.ownerOrgCode,
      this.loadingCityName,
      this.creatorUsername,
      this.goodsPrice,
      this.logisticsNo,
      this.updateUsername,
      this.loadingProvinceCode,
      this.contactUserFullName,
      this.status,
      this.goodsLossMethod,
      this.code,
      this.quoteType,
      this.goodsWeight,
      this.ownerOrgName,
      this.goodsPriceUnitCode,
      this.clientFreightPriceUnitCode,
      this.disabled,
      this.settleMethod,
      this.consignOrgCode,
      this.moduleCode,
      this.unloadingProvinceName,
      this.goodsAmountUnitCode,
      this.originalConsignOrgName,
      this.updateTime,
      this.platformConsignOrgCode,
      this.businessTypeCode,
      this.releaseRange,
      this.freightEndTime,
      this.loadingAddress,
      this.unloadingCountyCode,
      this.deleted,
      this.unloadingProvinceCode,
      this.createTime,
      this.goodsLossUnitCode,
      this.publishUserCode,
      this.truckQtyUnitCode,
      this.clientFreightPrice,
      this.contactPhone,
      this.clientOrgName});

  Content.fromJson(Map<String, dynamic> json) {
    platformOriginalConsignOrgCode = json['platformOriginalConsignOrgCode'];
    originalConsignOrgCode = json['originalConsignOrgCode'];
    goodsLoss = json['goodsLoss'];
    unloadingCityCode = json['unloadingCityCode'];
    quotePriceUnitCode = json['quotePriceUnitCode'];
    freightNo = json['freightNo'];
    truckQty = json['truckQty'];
    loadingCountyCode = json['loadingCountyCode'];
    routeName = json['routeName'];
    loadingCountyName = json['loadingCountyName'];
    meterageType = json['meterageType'];
    clientOrgCode = json['clientOrgCode'];
    loadingCityCode = json['loadingCityCode'];
    unloadingCountyName = json['unloadingCountyName'];
    unloadingAddress = json['unloadingAddress'];
    id = json['id'];
    goodsName = json['goodsName'];
    loadingProvinceName = json['loadingProvinceName'];
    routeCode = json['routeCode'];
    publishTime = json['publishTime'];
    consignOrgName = json['consignOrgName'];
    creatorUserCode = json['creatorUserCode'];
    cargoTypeClassificationCode = json['cargoTypeClassificationCode'];
    ip = json['ip'];
    ownerUserCode = json['ownerUserCode'];
    logisticsCode = json['logisticsCode'];
    synchronousId = json['synchronousId'];
    goodsVolumeUnitCode = json['goodsVolumeUnitCode'];
    dispatchMode = json['dispatchMode'];
    publishUserFullName = json['publishUserFullName'];
    unloadingCityName = json['unloadingCityName'];
    quotePrice = json['quotePrice'];
    updateUserCode = json['updateUserCode'];
    platformClientOrgCode = json['platformClientOrgCode'];
    goodsWeightUnitCode = json['goodsWeightUnitCode'];
    scheduleType = json['scheduleType'];
    ownerOrgCode = json['ownerOrgCode'];
    loadingCityName = json['loadingCityName'];
    creatorUsername = json['creatorUsername'];
    goodsPrice = json['goodsPrice'];
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
    goodsPriceUnitCode = json['goodsPriceUnitCode'];
    clientFreightPriceUnitCode = json['clientFreightPriceUnitCode'];
    disabled = json['disabled'];
    settleMethod = json['settleMethod'];
    consignOrgCode = json['consignOrgCode'];
    moduleCode = json['moduleCode'];
    unloadingProvinceName = json['unloadingProvinceName'];
    goodsAmountUnitCode = json['goodsAmountUnitCode'];
    originalConsignOrgName = json['originalConsignOrgName'];
    updateTime = json['updateTime'];
    platformConsignOrgCode = json['platformConsignOrgCode'];
    businessTypeCode = json['businessTypeCode'];
    releaseRange = json['releaseRange'];
    freightEndTime = json['freightEndTime'];
    loadingAddress = json['loadingAddress'];
    unloadingCountyCode = json['unloadingCountyCode'];
    deleted = json['deleted'];
    unloadingProvinceCode = json['unloadingProvinceCode'];
    createTime = json['createTime'];
    goodsLossUnitCode = json['goodsLossUnitCode'];
    publishUserCode = json['publishUserCode'];
    truckQtyUnitCode = json['truckQtyUnitCode'];
    clientFreightPrice = json['clientFreightPrice'];
    contactPhone = json['contactPhone'];
    clientOrgName = json['clientOrgName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['platformOriginalConsignOrgCode'] =
        this.platformOriginalConsignOrgCode;
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
    data['loadingCityCode'] = this.loadingCityCode;
    data['unloadingCountyName'] = this.unloadingCountyName;
    data['unloadingAddress'] = this.unloadingAddress;
    data['id'] = this.id;
    data['goodsName'] = this.goodsName;
    data['loadingProvinceName'] = this.loadingProvinceName;
    data['routeCode'] = this.routeCode;
    data['publishTime'] = this.publishTime;
    data['consignOrgName'] = this.consignOrgName;
    data['creatorUserCode'] = this.creatorUserCode;
    data['cargoTypeClassificationCode'] = this.cargoTypeClassificationCode;
    data['ip'] = this.ip;
    data['ownerUserCode'] = this.ownerUserCode;
    data['logisticsCode'] = this.logisticsCode;
    data['synchronousId'] = this.synchronousId;
    data['goodsVolumeUnitCode'] = this.goodsVolumeUnitCode;
    data['dispatchMode'] = this.dispatchMode;
    data['publishUserFullName'] = this.publishUserFullName;
    data['unloadingCityName'] = this.unloadingCityName;
    data['quotePrice'] = this.quotePrice;
    data['updateUserCode'] = this.updateUserCode;
    data['platformClientOrgCode'] = this.platformClientOrgCode;
    data['goodsWeightUnitCode'] = this.goodsWeightUnitCode;
    data['scheduleType'] = this.scheduleType;
    data['ownerOrgCode'] = this.ownerOrgCode;
    data['loadingCityName'] = this.loadingCityName;
    data['creatorUsername'] = this.creatorUsername;
    data['goodsPrice'] = this.goodsPrice;
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
    data['goodsPriceUnitCode'] = this.goodsPriceUnitCode;
    data['clientFreightPriceUnitCode'] = this.clientFreightPriceUnitCode;
    data['disabled'] = this.disabled;
    data['settleMethod'] = this.settleMethod;
    data['consignOrgCode'] = this.consignOrgCode;
    data['moduleCode'] = this.moduleCode;
    data['unloadingProvinceName'] = this.unloadingProvinceName;
    data['goodsAmountUnitCode'] = this.goodsAmountUnitCode;
    data['originalConsignOrgName'] = this.originalConsignOrgName;
    data['updateTime'] = this.updateTime;
    data['platformConsignOrgCode'] = this.platformConsignOrgCode;
    data['businessTypeCode'] = this.businessTypeCode;
    data['releaseRange'] = this.releaseRange;
    data['freightEndTime'] = this.freightEndTime;
    data['loadingAddress'] = this.loadingAddress;
    data['unloadingCountyCode'] = this.unloadingCountyCode;
    data['deleted'] = this.deleted;
    data['unloadingProvinceCode'] = this.unloadingProvinceCode;
    data['createTime'] = this.createTime;
    data['goodsLossUnitCode'] = this.goodsLossUnitCode;
    data['publishUserCode'] = this.publishUserCode;
    data['truckQtyUnitCode'] = this.truckQtyUnitCode;
    data['clientFreightPrice'] = this.clientFreightPrice;
    data['contactPhone'] = this.contactPhone;
    data['clientOrgName'] = this.clientOrgName;
    return data;
  }
}
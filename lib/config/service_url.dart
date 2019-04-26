const serviceUrl = 'https://rltx2-yfb-gateway.rltx.com';

const servicePath = {
  'apiFreightlist' : '$serviceUrl/driver-api/driver-api/freight/list', //货源列表
  'configOther' : '$serviceUrl/platform/platform/core/config/other', //other配置信息
  'selfInfo' : '$serviceUrl/driver-api/driver-api/person/self/info', //司机信息
  'accountLogin' : '$serviceUrl/account/driverLogin', //司机登录
  'provinceList' : '$serviceUrl/org-config/org-config/province/list', //省列表
  'cityList' : '$serviceUrl/org-config/org-config/city/list', //市列表
  'countyList' : '$serviceUrl/org-config/org-config/county/list', //区列表
  'loginOut' : '$serviceUrl/account/logout', //退出登录
  'verifyCode' : '$serviceUrl/account/account/send/verify_code', //获取验证码
  'resetVerifyCode' : '$serviceUrl/account/account/reset_password/send/verify_code', //获取验证码 忘记密码
  'accountRegistry' : '$serviceUrl/account/account/mobile/registry', //注册
  'resetPassword' : '$serviceUrl/account/account/reset_password', //重置密码
  'waybillList' : '$serviceUrl/driver-api/driver-api/waybill/list', //运单列表数据
  'waybillActionList' : '$serviceUrl/driver-api/driverApi/action/list', //运单业务动作列表
  'mainTruckMessage' : '$serviceUrl/driver-api/driver-api/truck/list',// 获取主车信息
  'trailerTruckMessage' : '$serviceUrl/driver-api/driver-api/trailer_truck/get', //获取挂车信息
  'getEWMImage' : '$serviceUrl/driver-api/driver-api/generate_user_qr_code', //获取二维码
  'myBankCardAccount' : '$serviceUrl/driver-api/driver-api/person/bank/account', //我的银行卡
  'myBankCardAccountAdd' : '$serviceUrl/driver-api/driver-api/person/bank/account/add', //新增我的银行卡信息
  'myBankCardAccountEdit' : '$serviceUrl/driver-api/driver-api/person/bank/account/edit', //编辑我的银行卡信息
  'getPertainOrg' : '$serviceUrl/transport/transport/query/pertain/org', //获取已挂靠的公司列表
  'addCompany' : '$serviceUrl/transport/transport/set/pertain/org/by/driver', //添加挂靠公司
  'manageList' : '$serviceUrl/platform/org/manager/list', //查询伙伴列表
  'editeFuelCard' : '$serviceUrl/driver-api/driver-api/person/edit/fuel_card_no', //修改油卡信息
  'recodeList' : '$serviceUrl/driver-api/driver-api/freight_collect_record/list', //我的收藏列表
  'resourceRouteSubscribe': '$serviceUrl/resource/resource/resource_route_subscribe/getList', //获取订阅线路列表
  'addSubscribeRoure' : '$serviceUrl/resource/resource/resource_route_subscribe/add', //添加订阅线路
  'modifyLoginAccount' : '$serviceUrl/account/account/modify_login_account', //修改手机号
  'sendSelfVerifyCode' : '$serviceUrl/account/account/send/self/verify_code', //当前账户获取验证码
  'updateImage' : '$serviceUrl/person/fw/image/update', //上传图片
  'personalSelfEdit': '$serviceUrl/driver-api/driver-api/person/self/edit', //暂存司机信息
  'newPersonalSelfCentry': '$serviceUrl/driver-api/driver-api/new/person/self/edit', //司机信息提交认证
  'truckAdd': '$serviceUrl/driver-api/driver-api/truck/add',//新增主车
  'truckEdite': '$serviceUrl/driver-api/driver-api/truck/edit',//更新主车
  'trailerInfo': '$serviceUrl//driver-api/driver-api/trailer_truck/get', //查询挂车信息
  'searchTruckInfo': '$serviceUrl/driver-api/driver-api/truck/all/list',//查询车牌号
  'collectRecordAdd' : '$serviceUrl/driver-api/driver-api/driver_api_collect_record/add',//收藏货源
};

getCookieAndSaveInStorage (res){
  String cookies;
  var  cookiestr = res.headers['set-cookie'][0];
  List  cookiesarr = cookiestr.split(';');
  print('cookiestr');
  print(cookiesarr);
  cookiesarr.forEach((item){
    if(item.indexOf('JSESSIONID') != -1){
      var itemar = item.split('=');
      cookies = itemar[itemar.length - 1];
      
    }
  });
  return cookies;
}

Map truckModel = {
  'H01': '普通货车',
  'H02': '厢式货车',
  'H04': '罐式货车',
  'Q00': '牵引车',
  'G01': '普通挂车',
  'G03': '罐式挂车',
  'G05': '集装箱挂车',
  'H09': '仓栅式货车',
  'H03': '封闭货车',
  'H05': '平板货车',
  'H06': '集装箱车',
  'H07': '自卸货车',
  'H08': '特殊结构货车',
  'Z00': '专项作业车',
  'G02': '厢式挂车',
  'G07': '仓栅式挂车',
  'G04': '平板挂车',
  'G06': '自卸挂车',
  'G09': '专项作业挂车',
  'X91': '车辆运输车',
  'X92': '车辆运输车（单排）'
};

Map gender = {
  'male': '男',
  'female': '女'
};
Map freightStatus = {
  'pushling': '发布中',
  'received': '已接单',
  'finished': '已结束'
};
Map driverAcceptStatus = {
  'undispatched': '待派车',
  'dispatched': '已派车',
  'ignored': '已忽略'
};

Map waybillStatus = {
  'unloading': '待装货',
  'going': '运输中',
  'finish': '运输完成',
  'cancel': '运单取消'
};
Map powerType = {
  'gas': '气车',
  'oil': '油车'
};

Map<String, Map> unit = {
  'cube': {
    'carrier.price': {
      'yuanpersquare': '元/方',
      'yuanpertruck': '元/车',
    },
    'driver.price': {
      'yuanpercube': '元/方',
      'yuanpertruck': '元/车',
    },
    'goods.loss': {
      'cube': '方/车'
    },
    'goods.price': {
      'yuanpercube': '元/方'
    },
    'goods.volume': {
      'cube': '方'
    },
    'settle.volume.unit': {
      'cube': '方'
    },
    'truck.cubage': {
      'cube': '方'
    }
  },
  'day': {
    'route.duration': {
      'day': '天'
    }
  },
  'hour': {
    'route.duration': {
      'hour': '小时'
    }
  },
  'item': {
    'carrier.price': {
      'yuanperitem': '元/件',
      'yuanpertruck': '元/车'
    },
    'driver.price': {
      'yuanperitem': '元/件',
      'yuanpertruck': '元/车'
    },
    'goods.loss': {
      'item': '件/车'
    },
    'goods.number': {
      'item': '件'
    },
    'goods.price': {
      'yuanperitem': '元/件'
    },
    'settle.volume.unit': {
      'item': '件'
    }
  },
  'km': {
    'mileage.number': {
      'km': '公里'
    },
    'standard.distance': {
      'km': '公里'
    }
  },
  'liang': {
    'truckqty.number': {
      'liang': '辆'
    }
  },
  'meter': {
    'truck.size': {
      'meter': '米'
    }
  },
  'millimetre': {
    'truck.size': {
      'millimetre': '毫米'
    }
  },
  'mm': {
    'tyrewrinkles.number': {
      'mm': '毫米'
    }
  },
  'percent': {
    'goods.loss.ration': {
      'percent': '%'
    }
  },
  'ton': {
    'carrier.price': {
      'yuanperton': '元/吨',
      'yuanpertruck': '元/车'
    },
    'driver.price': {
      'yuanperton': '元/吨',
      'yuanpertruck': '元/车'
    },
    'goods.loss': {
      'ton': '吨/车'
    },
    'goods.price': {
      'yuanperton': '元/吨'
    },
    'goods.weight': {
      'ton': '吨'
    },
    'settle.volume.unit': {
      'ton': '吨'
    },
    'truck.carry': {
      'ton': '吨'
    },
  },
  'yuan': {
    'price.unit': {
      'yuan': '元'
    }
  }
};

List carTypes = ["请选择","A1", "A2", "A3", "B1", "B2", "C1", "C2"];



import 'dart:io';

import '../enums/ad_type_enum.dart';

class AdConfig {
  late bool activeAll;
  late AdObjConfig appOpen;
  late AdObjConfig banner;
  late AdObjConfig bannerSmart;
  late AdObjConfig bannerAccordeon;
  late AdObjConfig intersticial;
  late AdObjConfig rewarded;
  late AdObjConfig intersticialRewarded;
  late AdObjConfig intersticialRewardedTransition;
  late AdObjConfig rewardedTransition;
  late AdObjConfig intersticialTransition;

  static bool checkWaterFallErrorCode(int code) => code == 3 || code == 9;

  bool get canShowRewardedAd =>
      (rewarded.active || intersticialRewarded.active || intersticialRewardedTransition.active);

  AdConfig.fromJson(Map<String, dynamic> json) {
    activeAll = json['activeAll'];
    appOpen = AdObjConfig.fromJson(this, json['appOpen']);
    banner = AdObjConfig.fromJson(this, json['banner']);
    bannerSmart = AdObjConfig.fromJson(this, json['bannerSmart']);
    bannerAccordeon = json['bannerAccordeon'] = AdObjConfig.fromJson(this, json['bannerAccordeon']);
    intersticial = AdObjConfig.fromJson(this, json['intersticial']);
    rewarded = AdObjConfig.fromJson(this, json['rewarded']);
    intersticialRewarded = AdObjConfig.fromJson(this, json['intersticialRewarded']);
    intersticialRewardedTransition =
        AdObjConfig.fromJson(this, json['intersticialRewardedTransition']);
    rewardedTransition = AdObjConfig.fromJson(this, json['rewardedTransition']);
    intersticialTransition = AdObjConfig.fromJson(this, json['intersticialTransition']);
  }

  static AdConfig getDefault() => AdConfig.fromJson(configDefault);

  Map<String, dynamic> toJson() => {
        "activeAll": activeAll,
        "appOpen": appOpen.toJson(),
        "banner": banner.toJson(),
        "intersticial": intersticial.toJson(),
        "rewarded": rewarded.toJson(),
        "intersticialRewarded": intersticialRewarded.toJson(),
        "intersticialRewardedTransition": intersticialRewardedTransition.toJson(),
      };

  // static final Map<String, dynamic> configDefault = {
  //   "activeAll": true,
  //   "appOpen": {
  //     "active": true,
  //     "waterfall": true,
  //     "default": "ca-app-pub-3940256099942544/3419835294",
  //     "low": {
  //       "active": true,
  //       "id": "ca-app-pub-3940256099942544/3419835294"
  //     },
  //     "medium": {
  //       "active": true,
  //       "id": "ca-app-pub-3940256099942544/3419835294"
  //     },
  //     "high": {
  //       "active": true,
  //       "id": "ca-app-pub-3940256099942544/3419835294"
  //     }
  //   },
  //   "banner": {
  //     "active": true,
  //     "waterfall": true,
  //     "default": "ca-app-pub-3940256099942544/6300978111",
  //     "low": {
  //       "active": true,
  //       "id": "ca-app-pub-3940256099942544/6300978111"
  //     },
  //     "medium": {
  //       "active": true,
  //       "id": "ca-app-pub-3940256099942544/6300978111"
  //     },
  //     "high": {
  //       "active": true,
  //       "id": "ca-app-pub-3940256099942544/6300978111"
  //     }
  //   },
  //   "bannerSmart": {
  //     "active": true,
  //     "waterfall": true,
  //     "default": "ca-app-pub-3940256099942544/6300978111",
  //     "low": {
  //       "active": true,
  //       "id": "ca-app-pub-3940256099942544/6300978111"
  //     },
  //     "medium": {
  //       "active": true,
  //       "id": "ca-app-pub-3940256099942544/6300978111"
  //     },
  //     "high": {
  //       "active": true,
  //       "id": "ca-app-pub-3940256099942544/6300978111"
  //     }
  //   },
  //   "bannerAccordeon": {
  //     "active": true,
  //     "waterfall": true,
  //     "default": "ca-app-pub-3940256099942544/6300978111",
  //     "low": {
  //       "active": true,
  //       "id": "ca-app-pub-3940256099942544/6300978111"
  //     },
  //     "medium": {
  //       "active": true,
  //       "id": "ca-app-pub-3940256099942544/6300978111"
  //     },
  //     "high": {
  //       "active": true,
  //       "id": "ca-app-pub-3940256099942544/6300978111"
  //     }
  //   },
  //   "intersticial": {
  //     "active": true,
  //     "waterfall": true,
  //     "default": "ca-app-pub-3940256099942544/1033173712",
  //     "low": {
  //       "active": true,
  //       "id": "ca-app-pub-3940256099942544/1033173712"
  //     },
  //     "medium": {
  //       "active": true,
  //       "id": "ca-app-pub-3940256099942544/1033173712"
  //     },
  //     "high": {
  //       "active": true,
  //       "id": "ca-app-pub-3940256099942544/1033173712"
  //     }
  //   },
  //   "rewarded": {
  //     "active": true,
  //     "waterfall": true,
  //     "default": "ca-app-pub-3940256099942544/5224354917",
  //     "low": {
  //       "active": true,
  //       "id": "ca-app-pub-3940256099942544/5224354917"
  //     },
  //     "medium": {
  //       "active": true,
  //       "id": "ca-app-pub-3940256099942544/5224354917"
  //     },
  //     "high": {
  //       "active": true,
  //       "id": "ca-app-pub-3940256099942544/5224354917"
  //     }
  //   },
  //   "intersticialRewarded": {
  //     "active": true,
  //     "waterfall": true,
  //     "default": "ca-app-pub-3940256099942544/5354046379",
  //     "low": {
  //       "active": true,
  //       "id": "ca-app-pub-3940256099942544/5354046379"
  //     },
  //     "medium": {
  //       "active": true,
  //       "id": "ca-app-pub-3940256099942544/5354046379"
  //     },
  //     "high": {
  //       "active": true,
  //       "id": "ca-app-pub-3940256099942544/5354046379"
  //     }
  //   },
  //   "intersticialRewardedTransition": {
  //     "active": true,
  //     "waterfall": true,
  //     "default": "ca-app-pub-3940256099942544/5354046379",
  //     "low": {
  //       "active": true,
  //       "id": "ca-app-pub-3940256099942544/5354046379"
  //     },
  //     "medium": {
  //       "active": true,
  //       "id": "ca-app-pub-3940256099942544/5354046379"
  //     },
  //     "high": {
  //       "active": true,
  //       "id": "ca-app-pub-3940256099942544/5354046379"
  //     }
  //   },
  //   "rewardedTransition": {
  //     "active": true,
  //     "waterfall": true,
  //     "default": "ca-app-pub-3940256099942544/5224354917",
  //     "low": {
  //       "active": true,
  //       "id": "ca-app-pub-3940256099942544/5224354917"
  //     },
  //     "medium": {
  //       "active": true,
  //       "id": "ca-app-pub-3940256099942544/5224354917"
  //     },
  //     "high": {
  //       "active": true,
  //       "id": "ca-app-pub-3940256099942544/5224354917"
  //     }
  //   },
  //   "intersticialTransition": {
  //     "active": true,
  //     "waterfall": true,
  //     "default": "ca-app-pub-3940256099942544/1033173712",
  //     "low": {
  //       "active": true,
  //       "id": "ca-app-pub-3940256099942544/1033173712"
  //     },
  //     "medium": {
  //       "active": true,
  //       "id": "ca-app-pub-3940256099942544/1033173712"
  //     },
  //     "high": {
  //       "active": true,
  //       "id": "ca-app-pub-3940256099942544/1033173712"
  //     }
  //   }
  // };

  static final Map<String, dynamic> configDefault = {
    "activeAll": true,
    "appOpen": {
      "active": true,
      "waterfall": true,
      "default": "ca-app-pub-8419654969814276/2975594962",
      "low": {
        "active": true,
        "id": "ca-app-pub-8419654969814276/2975594962"
      },
      "medium": {
        "active": true,
        "id": "ca-app-pub-8419654969814276/6914839978"
      },
      "high": {
        "active": true,
        "id": "ca-app-pub-8419654969814276/4260756478"
      }
    },
    "banner": {
      "active": true,
      "waterfall": true,
      "default": "ca-app-pub-8419654969814276/4847929892",
      "low": {
        "active": true,
        "id": "ca-app-pub-8419654969814276/4847929892"
      },
      "medium": {
        "active": true,
        "id": "ca-app-pub-8419654969814276/6620956813"
      },
      "high": {
        "active": true,
        "id": "ca-app-pub-8419654969814276/7934038485"
      }
    },
    "bannerSmart": {
      "active": false,
      "waterfall": false,
      "default": "ca-app-pub-8419654969814276/1623781003",
      "low": {
        "active": false,
        "id": "ca-app-pub-8419654969814276/1623781003"
      },
      "medium": {
        "active": false,
        "id": "ca-app-pub-8419654969814276/9270390633"
      },
      "high": {
        "active": false,
        "id": "ca-app-pub-8419654969814276/3994793471"
      }
    },
    "bannerAccordeon": {
      "active": false,
      "waterfall": false,
      "default": "ca-app-pub-8419654969814276/9247120156",
      "low": {
        "active": false,
        "id": "ca-app-pub-8419654969814276/9247120156"
      },
      "medium": {
        "active": false,
        "id": "ca-app-pub-8419654969814276/2873283496"
      },
      "high": {
        "active": false,
        "id": "ca-app-pub-8419654969814276/6161011561"
      }
    },
    "intersticial": {
      "active": false,
      "waterfall": false,
      "default": "ca-app-pub-8419654969814276/6700847863",
      "low": {
        "active": false,
        "id": "ca-app-pub-8419654969814276/6700847863"
      },
      "medium": {
        "active": false,
        "id": "ca-app-pub-8419654969814276/8013929534"
      },
      "high": {
        "active": false,
        "id": "ca-app-pub-8419654969814276/2221766559"
      }
    },
    "rewarded": {
      "active": false,
      "waterfall": false,
      "default": "ca-app-pub-8419654969814276/4948002240",
      "low": {
        "active": false,
        "id": "ca-app-pub-8419654969814276/4948002240"
      },
      "medium": {
        "active": false,
        "id": "ca-app-pub-8419654969814276/7574165584"
      },
      "high": {
        "active": false,
        "id": "ca-app-pub-8419654969814276/6429385122"
      }
    },
    "intersticialRewarded": {
      "active": false,
      "waterfall": false,
      "default": "ca-app-pub-8419654969814276/7087860672",
      "low": {
        "active": false,
        "id": "ca-app-pub-8419654969814276/7087860672"
      },
      "medium": {
        "active": false,
        "id": "ca-app-pub-8419654969814276/9714024018"
      },
      "high": {
        "active": false,
        "id": "ca-app-pub-8419654969814276/7882067596"
      }
    },
    "intersticialRewardedTransition": {
      "active": false,
      "waterfall": false,
      "default": "ca-app-pub-8419654969814276/1835533990",
      "low": {
        "active": false,
        "id": "ca-app-pub-8419654969814276/1835533990"
      },
      "medium": {
        "active": false,
        "id": "ca-app-pub-8419654969814276/7698234762"
      },
      "high": {
        "active": false,
        "id": "ca-app-pub-8419654969814276/6568985921"
      }
    },
    "rewardedTransition": {
      "active": false,
      "waterfall": false,
      "default": "ca-app-pub-8419654969814276/8887247258",
      "low": {
        "active": false,
        "id": "ca-app-pub-8419654969814276/8887247258"
      },
      "medium": {
        "active": false,
        "id": "ca-app-pub-8419654969814276/2513410595"
      },
      "high": {
        "active": false,
        "id": "ca-app-pub-8419654969814276/7765737271"
      }
    },
    "intersticialTransition": {
      "active": false,
      "waterfall": false,
      "default": "ca-app-pub-8419654969814276/9011316430",
      "low": {
        "active": false,
        "id": "ca-app-pub-8419654969814276/9011316430"
      },
      "medium": {
        "active": false,
        "id": "ca-app-pub-8419654969814276/2221766559"
      },
      "high": {
        "active": false,
        "id": "ca-app-pub-8419654969814276/9327011208"
      }
    }
  };
}

class AdObjConfig {
  late bool activeAll;
  late bool activeObj;
  late bool waterfall;
  late String defaultId;
  late AdFallConfig low;
  late AdFallConfig medium;
  late AdFallConfig high;

  AdObjConfig.fromJson(AdConfig adConfig, Map<String, dynamic> json) {
    activeAll = adConfig.activeAll;
    activeObj = json['active'];
    waterfall = json['waterfall'];
    defaultId = json['default'];
    low = AdFallConfig.fromJson(json['low']);
    medium = AdFallConfig.fromJson(json['medium']);
    high = AdFallConfig.fromJson(json['high']);
  }

  bool get active => activeAll && activeObj;
  // bool get active => activeAll && activeObj && !RemoteConfigService.useDefaultValues;

  List<String> get id {
    if (waterfall) {
      List<String> ids = [];
      if (high.active) ids.add(high.id);
      if (medium.active) ids.add(medium.id);
      if (low.active) ids.add(low.id);
      return (ids.isNotEmpty ? ids : [defaultId]).toList();
    } else {
      return [defaultId].toList();
    }
  }

  Map<String, dynamic> toJson() => {
        "active": active,
        "waterfall": waterfall,
        "default": defaultId,
        "low": low.toJson(),
        "medium": medium.toJson(),
        "high": high.toJson(),
      };
}

class AdFallConfig {
  late bool active;
  late String id;

  AdFallConfig.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() => {
        "active": active,
        "id": id,
      };
}

class AdEnable {
  bool banner = false;
  bool instersticial = false;
  bool openedApp = false;
  bool reward = false;
  bool query = false;

  AdEnable();

  AdEnable.fromFirebase({
    required this.banner,
    required this.instersticial,
    required this.openedApp,
    required this.reward,
    required this.query,
  });

  //PROD
  // factory AdEnable.fromMap(Map<String, dynamic> map) {
  //   return AdEnable.fromFirebase(
  //     reward: map['reward'] as bool,
  //     query: map['query'] as bool,
  //     instersticial: map['instersticial'] as bool,
  //     banner: map['banner'] as bool,
  //     openedApp: map['openedApp'] as bool,
  //   );
  // }

  // TEST
  factory AdEnable.fromMap(Map<String, dynamic> map) {
    return AdEnable.fromFirebase(
      reward: true,
      query: true,
      instersticial: true,
      banner: true,
      openedApp: true,
    );
  }
}

class AdType {
  late String id;
  late String locale;
  late AdTypeEnum type;

  AdType();

  AdType.fromFirebase({
    required this.id,
    required this.locale,
    required this.type,
  });

  factory AdType.fromMap(Map<String, dynamic> map) {
    return AdType.fromFirebase(
      id: map['id'] as String,
      locale: map['locale'] as String,
      type: (map['type'] as String).toAdTypeEnum(),
    );
  }
}

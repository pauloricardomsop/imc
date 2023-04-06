import '../enums/ad_type_enum.dart';

class AdConfig {
  late bool activeAll;
  late AdObjConfig appOpen;
  late AdObjConfig banner;
  late AdObjConfig intersticial;
  late AdObjConfig rewarded;
  late AdObjConfig intersticialRewarded;

  static bool checkWaterFallErrorCode(int code) => code == 3 || code == 9;

  bool get canShowRewardedAd => rewarded.active || intersticialRewarded.active;

  AdConfig.fromJson(Map<String, dynamic> json) {
    activeAll = json['activeAll'];
    appOpen = json['appOpen'] = AdObjConfig.fromJson(this, json['appOpen']);
    banner = json['banner'] = AdObjConfig.fromJson(this, json['banner']);
    intersticial = AdObjConfig.fromJson(this, json['intersticial']);
    rewarded = AdObjConfig.fromJson(this, json['rewarded']);
    intersticialRewarded = AdObjConfig.fromJson(this, json['intersticialRewarded']);
  }

  static AdConfig getDefault() => AdConfig.fromJson(configDefault);

  Map<String, dynamic> toJson() => {
        "activeAll": activeAll,
        "appOpen": appOpen.toJson(),
        "banner": banner.toJson(),
        "intersticial": intersticial.toJson(),
        "rewarded": rewarded.toJson(),
        "intersticialRewarded": intersticialRewarded.toJson(),
      };

  static final Map<String, dynamic> configDefault = {
    "activeAll": true,
    "appOpen": {
      "active": true,
      "waterfall": true,
      "default": "ca-app-pub-8419654969814276/5179306302",
      "low": {"active": true, "id": "ca-app-pub-8419654969814276/5179306302"},
      "medium": {"active": true, "id": "ca-app-pub-8419654969814276/7656198350"},
      "high": {"active": true, "id": "ca-app-pub-8419654969814276/4869133355"}
    },
    "banner": {
      "active": true,
      "waterfall": true,
      "default": "ca-app-pub-8419654969814276/1971523182",
      "low": {"active": true, "id": "ca-app-pub-8419654969814276/1971523182"},
      "medium": {"active": true, "id": "ca-app-pub-8419654969814276/3727457981"},
      "high": {"active": true, "id": "ca-app-pub-8419654969814276/3284604853"}
    },
    "intersticial": {
      "active": true,
      "waterfall": true,
      "default": "ca-app-pub-8419654969814276/7512728125",
      "low": {"active": true, "id": "ca-app-pub-8419654969814276/7512728125"},
      "medium": {"active": true, "id": "ca-app-pub-8419654969814276/7033930567"},
      "high": {"active": true, "id": "ca-app-pub-8419654969814276/8405069592"}
    },
    "rewarded": {
      "active": true,
      "waterfall": true,
      "default": "ca-app-pub-8419654969814276/5252292645",
      "low": {"active": true, "id": "ca-app-pub-8419654969814276/5252292645"},
      "medium": {"active": true, "id": "ca-app-pub-8419654969814276/4846750927"},
      "high": {"active": true, "id": "ca-app-pub-8419654969814276/9256769221"}
    },
    "intersticialRewarded": {
      "active": true,
      "waterfall": true,
      "default": "ca-app-pub-8419654969814276/8594424243",
      "low": {"active": true, "id": "ca-app-pub-8419654969814276/8594424243"},
      "medium": {"active": true, "id": "ca-app-pub-8419654969814276/9943164935"},
      "high": {"active": true, "id": "ca-app-pub-8419654969814276/9907505917"}
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

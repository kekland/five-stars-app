class VehicleTypeUtils {
  static Map<VehicleType, String> vehicleTypeNames = {
    VehicleType.autoTransporter: "Автотранспортер",
    VehicleType.onboard: "Бортовой",
    VehicleType.jumbo: "Джамбо",
    VehicleType.closed: "Закрытый",
    VehicleType.isotherm: "Изотермический",
    VehicleType.isothermRefrigerated: "Изотерм. реф.",
    VehicleType.containerTransporter: "Контейнеровоз",
    VehicleType.mega: "Мега",
    VehicleType.open: "Открытый",
    VehicleType.refrigerator: "Рефрижератор",
    VehicleType.dumpTruck: "Самосвал",
    VehicleType.tent: "Тент",
    VehicleType.trawl: "Трал",
    VehicleType.allMetal: "Цельнометаллический",
    VehicleType.curtain: "Шторка",
    VehicleType.other: "Другой",
  };

  static Map<String, VehicleType> vehicleTypeNamesReversed = {
    "Автотранспортер": VehicleType.autoTransporter,
    "Бортовой": VehicleType.onboard,
    "Джамбо": VehicleType.jumbo,
    "Закрытый": VehicleType.closed,
    "Изотермический": VehicleType.isotherm,
    "Изотерм. реф.": VehicleType.isothermRefrigerated,
    "Контейнеровоз": VehicleType.containerTransporter,
    "Мега": VehicleType.mega,
    "Открытый": VehicleType.open,
    "Рефрижератор": VehicleType.refrigerator,
    "Самосвал": VehicleType.dumpTruck,
    "Тент": VehicleType.tent,
    "Трал": VehicleType.trawl,
    "Цельнометаллический": VehicleType.allMetal,
    "Шторка": VehicleType.curtain,
    "Другой": VehicleType.other,
  };

  static VehicleType fromJson(String json) {
    switch (json) {
      case "autoTransporter":
        return VehicleType.autoTransporter;
      case "onboard":
        return VehicleType.onboard;
      case "jumbo":
        return VehicleType.jumbo;
      case "closed":
        return VehicleType.closed;
      case "isotherm":
        return VehicleType.isotherm;
      case "isothermRefrigerated":
        return VehicleType.isothermRefrigerated;
      case "containerTransporter":
        return VehicleType.containerTransporter;
      case "mega":
        return VehicleType.mega;
      case "open":
        return VehicleType.open;
      case "refrigerator":
        return VehicleType.refrigerator;
      case "dumpTruck":
        return VehicleType.dumpTruck;
      case "tent":
        return VehicleType.tent;
      case "trawl":
        return VehicleType.trawl;
      case "allMetal":
        return VehicleType.allMetal;
      case "curtain":
        return VehicleType.curtain;
      default:
        return VehicleType.other;
    }
  }

  static String toJson(VehicleType json) {
    switch (json) {
      case VehicleType.autoTransporter:
        return "autoTransporter";
      case VehicleType.onboard:
        return "onboard";
      case VehicleType.jumbo:
        return "jumbo";
      case VehicleType.closed:
        return "closed";
      case VehicleType.isotherm:
        return "isotherm";
      case VehicleType.isothermRefrigerated:
        return "isothermRefrigerated";
      case VehicleType.containerTransporter:
        return "containerTransporter";
      case VehicleType.mega:
        return "mega";
      case VehicleType.open:
        return "open";
      case VehicleType.refrigerator:
        return "refrigerator";
      case VehicleType.dumpTruck:
        return "dumpTruck";
      case VehicleType.tent:
        return "tent";
      case VehicleType.trawl:
        return "trawl";
      case VehicleType.allMetal:
        return "allMetal";
      case VehicleType.curtain:
        return "curtain";
      default:
        return "other";
    }
  }
}

enum VehicleType {
  autoTransporter,
  onboard,
  jumbo,
  closed,
  isotherm,
  isothermRefrigerated,
  containerTransporter,
  mega,
  open,
  refrigerator,
  dumpTruck,
  tent,
  trawl,
  allMetal,
  curtain,
  other,
}

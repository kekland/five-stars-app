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

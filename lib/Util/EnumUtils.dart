class EnumUtil {

  static List<String> extractEnumValues(List<Object> enumeration){
    return enumeration.map(
            (v) => v.toString().substring(v.toString().indexOf('.') + 1)
    ).toList();
  }

  static List<String> extractEnumValuesForCountry(List<Object> enumeration, String country){
    List<String> cities = extractEnumValues(enumeration);
    return cities.where((city) => city.startsWith(country)).map((city) => city.replaceAll(country,"").replaceAll("_", "")).toList();
  }

  static bool isValueExistInEnum(String value,List<Object> enumeration){
    List<String> values = extractEnumValues(enumeration);
    for(int i = 0 ; i < values.length;i++){
      if(values[i]==value){
        return true;
      }
    }
    return false;
  }
}
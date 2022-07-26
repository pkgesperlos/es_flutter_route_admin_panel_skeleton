class Converter {
  static String getCategoryTypeTitle(String type) {
    switch (type) {
      case "0":
        return "چک لیست";
    }

    return "";
  }

  static String getMediaTypeTitle(String type) {
    switch (type) {
      case "1":
        return "تصاویر";
      case "0":
        return "ویدئو ها";
    }

    return "";
  }

  static String getChecklistItemsFormType(String type) {
    switch (type) {
      case "0":
        return "تک انتخابی";
      case "1":
        return "چند انتخابی";
      case "2":
        return "متنی";
    }

    return "";
  }

  static List<Map> checklistItemsFormType = [
    {"title": "تک انتخابی", "_id": "0"},
    {"title": "چند انتخابی", "_id": "1"},
    {"title": "متنی", "_id": "2"}
  ];
}

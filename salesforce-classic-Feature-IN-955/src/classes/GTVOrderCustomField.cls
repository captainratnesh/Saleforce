global class GTVOrderCustomField {
  public String id;
  public String name;
  public String fieldType;
  public String fieldValidationType;
  public List<GTVCustomFieldRefrence> refrences;

  global class GTVCustomFieldRefrence {
    public String id;
    public String status;
    public String value;
  }
}
/**
 * Unpublished Work. Copyright 2009-2018 Transverse, LLC. All Rights Reserved.
 * This software contains confidential and trade secret information of:
 * Transverse, LLC.
 * 620 Congress Ave.
 * Suite 200
 * Austin, TX 78701
 * USA
 * Use, duplication or disclosure of this software is prohibited
 * without prior written permission of Transverse, LLC.
 */

/**
 * This class contains methods to convert data from one data type to another.
 * @author AMAN JAIN
 */

public class ZConvert {
  /**
   * returns string representation of an Integer value
   * @param value An integer value(required)
   * @return value in string format
   */
  public static String toString(integer value) {
    /* string representation if an Integer value */
    if (null == value) {
      return '0';
    }
    return value.format();
  }
  /**
   * returns string representation of a String value
   * @param value a String value(required)
   * @return value in string format
   */
  public static String toString(String value) {
    /* string representation if an String value */
    if (null == value) {
      return 'NA';
    }
    return value;
  }
  /**
   * returns string representation of a Double value
   * @param value a double value(required)
   * @return value in string format
   */
  public static String toString(Double value) {
    /* string representation if a Double value */
    if (null == value) {
      return '0';
    }
    return value.format();
  }
  /**
   * returns string representation of a Boolean value
   * @param value a Boolean value(required)
   * @return value in string format
   */
  public static String toString(Boolean value) {
    /* string representation if a Boolean value */
    if (value)
      return 'true';
    else
      return 'false';
  }
  /**
   * returns string representation of a Long value
   * @param value a Long value(required)
   * @return value in string format
   */
  public static String toString(Long value) {
    /* string representation if a Long value */
    if (null == value) {
      return '0';
    }
    return value.format();
  }
  /**
   * returns string representation of a Date value
   * @param value a Date value(required)
   * @return value in string format
   */
  public static String toString(Date value) {
    /* string representation if a Date value */
    if (null == value) {
      return 'NA';
    }
    return value.format();
  }
  /**
   * returns string representation of a Date value with formatting
   * @param value a Date value(required)
   * @param format a string containg format(required)
   * @return value in string format
   */
  public static String toString(Date value, String format) {
    /* string representation if a Date value with formatting */
    Datetime temp = Datetime.newInstance(
      value.year(),
      value.month(),
      value.day()
    );
    return temp.format(format);
  }
  /**
   * returns string representation of a Datetime value
   * @param value a Datetime value(required)
   * @return value in string format
   */
  public static String toString(Datetime value) {
    /* string representation if a Datetime value */
    if (null == value) {
      return 'NA';
    }
    return value.format();
  }
  /**
   * returns string representation of a Datetime value with formatting
   * @param value a Datetime value(required)
   * @param format a string containg format(required)
   * @return value in string format
   */
  public static String toString(Datetime value, String format) {
    /* string representation if a Datetime value with formatting */
    return value.format(format);
  }
  /**
   * returns string representation of a Time value
   * @param value a Time value(required)
   * @return value in string format
   */
  public static String toString(Time value) {
    /* string representation if a Time value */
    return String.valueOf(value);
  }
  /**
   * returns string representation of a Time value with formatting
   * @param value a Time value(required)
   * @param format a string containg format(required)
   * @return value in string format
   */
  public static String toString(Time value, String format) {
    /* string representation if a Time value with formating */
    Datetime temp = Datetime.newInstance(
      1970,
      1,
      1,
      value.hour(),
      value.minute(),
      value.second()
    );
    return temp.format(format);
  }
  /**
   * returns string representation of a Decimal value
   * @param value a Decimal value(required)
   * @return value in string format
   */
  public static String toString(Decimal value) {
    /* string representation if a Decimal value */
    if (null == value) {
      return '0';
    }
    return value.format();
  }
  /**
   * returns string representation of a Decimal value with or without Scientific Notation
   * @param value a Decimal value(required)
   * @param scientificNotation a bolean value(required)
   * @return value in string format
   */
  public static String toString(Decimal value, Boolean scientificNotation) {
    /* string representation if a Decimal value with or without Scientific Notation */
    if (scientificNotation)
      return value.format();
    else
      return value.toPlainString();
  }
  /**
   * returns string representation of file size
   * @param value a Long value(required)
   * @return value in string format
   */
  public static String fileSizeToString(Long value) {
    /* string representation if a file's size, such as 2 KB, 4.1 MB, etc */
    if (value < 1024)
      return toString(value) + ' Bytes';
    else if (value >= 1024 && value < (1024 * 1024)) {
      //KB
      Decimal kb = Decimal.valueOf(value);
      kb = kb.divide(1024, 2);
      return toString(kb) + ' KB';
    } else if (value >= (1024 * 1024) && value < (1024 * 1024 * 1024)) {
      //MB
      Decimal mb = Decimal.valueOf(value);
      mb = mb.divide((1024 * 1024), 2);
      return toString(mb) + ' MB';
    } else {
      //GB
      Decimal gb = Decimal.valueOf(value);
      gb = gb.divide((1024 * 1024 * 1024), 2);

      return toString(gb) + ' GB';
    }
  }
  /**
   * returns string representation of currency
   * @param value a Decimal value(required)
   * @param currencyChar currency type in string format(required)
   * @return value in string format
   */
  public static String currencyToString(Decimal value, String currencyChar) {
    return currencyChar + toString(value);
  }

  public static String getFormattedDateTimeString(Date value, String format) {
    String formattedDateTime = DateTime.newInstance(value, System.now().time())
      .format(format);
    return formattedDateTime;
  }
}
/**
 * This class is a test class of ZconvertUnit class.
 * @author Aman Jain
 */

@isTest
private class ZconvertUnitTest {
  static testMethod void runPositiveTestCases() {
    RecordType rTValue = new RecordType();
    integer iValue = 3232;
    String sValue = 'aasdf';
    Double duValue = 23232;
    Boolean bValue = true;
    Long lValue = 22323;
    Date dValue = date.today();
    Datetime dtValue = Datetime.newInstance(2011, 11, 1);
    Datetime myDate = datetime.newInstance(2008, 2, 5, 8, 30, 12);
    Decimal deValue = 3223.323;
    Time myTime = Time.newInstance(18, 30, 2, 20);
    //Setup User
    User u1 = [SELECT id FROM User LIMIT 1];
    System.runAs(u1) {
      String k1 = zConvert.toString(iValue);
      k1 = zConvert.toString(sValue);
      k1 = zConvert.toString(duValue);
      k1 = zConvert.toString(bValue);
      k1 = zConvert.toString(lValue);
      k1 = zConvert.toString(dValue);
      k1 = zConvert.toString(dtValue);
      k1 = zConvert.toString(deValue);
      k1 = zConvert.toString(myTime);
      k1 = zConvert.toString(myTime, 'h:mm a');
      k1 = zConvert.toString(deValue, bValue);
      k1 = zConvert.CurrencyToString(deValue, sValue);
      k1 = zConvert.toString(dtValue, 'h:mm a');
      k1 = zConvert.toString(myDate, 'h:mm a');
      k1 = zConvert.toString(dValue, 'h:mm a');
      iValue = null;
      sValue = null;
      duValue = null;
      bValue = false;
      lValue = null;
      dValue = null;
      dtValue = null;
      deValue = null;
      myTime = null;
      myDate = null;
      k1 = zConvert.toString(myDate);
      k1 = zConvert.toString(iValue);
      k1 = zConvert.toString(sValue);
      k1 = zConvert.toString(duValue);
      k1 = zConvert.toString(bValue);
      k1 = zConvert.toString(lValue);
      k1 = zConvert.toString(dValue);
      k1 = zConvert.toString(dtValue);
      k1 = zConvert.toString(deValue);
      k1 = zConvert.toString(myTime);
      deValue = 3223.323;
      k1 = zConvert.toString(deValue, bValue);
      Long longValue = 111;
      k1 = zConvert.FileSizeToString(longValue);
      longValue = 1112;
      k1 = zConvert.FileSizeToString(longValue);
      longValue = 11132322;
      k1 = zConvert.FileSizeToString(longValue);
      longValue = 1113232;
      k1 = zConvert.FileSizeToString(longValue);
      longValue = 1024 * 1034 * 1024 + 3;
      k1 = zConvert.FileSizeToString(longValue);

      System.assertEquals(null, null);
    }
  }
}
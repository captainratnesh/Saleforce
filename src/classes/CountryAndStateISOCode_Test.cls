/**
 * This class is a test class of CountryAndStateISOCode class.
 * @author Aman Jain
 */

@isTest
public with sharing class CountryAndStateISOCode_Test {
  @isTest
  public static void myUnitTest() {
    CountryAndStateISOCode.getStateCode('MORELOS');
    CountryAndStateISOCode.getCountryCode('DOMINICA');
    String countryFromIsoCode = CountryAndStateISOCode.getCountryCodeISo2('AD');
    System.assertEquals(countryFromIsoCode, 'AND');
  }
}
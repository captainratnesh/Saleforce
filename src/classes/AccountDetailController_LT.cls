/*
 *  Unpublished Work. Copyright 2009-2018 Transverse, LLC. All Rights Reserved.
 *  This software contains confidential and trade secret information of:
 *  Transverse, LLC.
 *  620 Congress Ave.
 *  Suite 200
 *  Austin, TX 78701
 *  USA
 *  Use, duplication or disclosure of this software is prohibited
 *  without prior written permission of Transverse, LLC.
 */

/**
 * @author Aman Jain <amanj.jain@algoworks.com>
 * Used to show data and handle actions performed on account detail lightning component.
 */

public class AccountDetailController_LT {
  private static list<SelectOption> selectStatusList { get; set; }
  private static list<SelectOption> productUsageRuleList { get; set; }
  private static list<SelectOption> rateTypeList { get; set; }
  private static list<SelectOption> chargesPicklist { get; set; }
  private static list<SelectOption> allowanceTypeList { get; set; }
  private static list<SelectOption> roleOverList { get; set; }
  private static list<SelectOption> formulaField { get; set; }
  private static list<SelectOption> operationList { get; set; }
  private static list<SelectOption> operationListAPI2 { get; set; }
  private static list<SelectOption> passThroughChargeList { get; set; }
  private static list<SelectOption> productUsageRuleListAPI2 { get; set; }
  private static list<SelectOption> countryList { get; set; }
  private static list<SelectOption> stateUsa { get; set; }
  private static list<SelectOption> stateMex { get; set; }
  private static list<SelectOption> stateCan { get; set; }
  private static Map<String, List<ProductPriceWrapper>> productIdToProductPriceMap {
    get;
    set;
  }
  private static Map<String, List<ProductPriceRangeWrapper>> productPriceIdtoPriceRangesMap {
    get;
    set;
  }
  private static Map<String, Decimal> productPriceIdToPriceValueMap {
    get;
    set;
  }
  private static Map<String, Decimal> mapOfAgreementPeriod { get; set; }
  private static Boolean enablePreserveAgreement;
  private static Boolean canUpdateQty;
  static {
    selectStatusList = new List<SelectOption>();
    productUsageRuleList = new List<SelectOption>();
    rateTypeList = new List<SelectOption>();
    chargesPicklist = new List<SelectOption>();
    allowanceTypeList = new List<SelectOption>();
    roleOverList = new List<SelectOption>();
    formulaField = new List<SelectOption>();
    operationList = new List<SelectOption>();
    operationListAPI2 = new List<SelectOption>();
    passThroughChargeList = new List<SelectOption>();
    productUsageRuleListAPI2 = new List<SelectOption>();
    productPriceIdtoPriceRangesMap = new Map<String, List<ProductPriceRangeWrapper>>();
    productPriceIdToPriceValueMap = new Map<String, Decimal>();
    productIdToProductPriceMap = new Map<String, List<ProductPriceWrapper>>();
    mapOfAgreementPeriod = new Map<String, Decimal>();

    selectStatusList.add(new SelectOption('Draft', 'Draft'));
    selectStatusList.add(new SelectOption('Active', 'Active'));

    productUsageRuleList.add(
      new SelectOption('Match All Events', 'Match All Events')
    );
    productUsageRuleList.add(new SelectOption('Formula', 'Formula'));
    productUsageRuleList.add(new SelectOption('Global', 'Global'));

    productUsageRuleListAPI2.add(
      new SelectOption('Match All Events', 'Match All Events')
    );
    productUsageRuleListAPI2.add(new SelectOption('Formula', 'Formula'));

    rateTypeList.add(new SelectOption('Flat', 'Flat'));
    rateTypeList.add(new SelectOption('Table Rate', 'Table Rate'));
    rateTypeList.add(new SelectOption('Pass Through', 'Pass Through'));

    chargesPicklist.add(new SelectOption('Choose One', 'Choose One'));
    chargesPicklist.add(new SelectOption('Millisecond', 'Millisecond'));
    chargesPicklist.add(new SelectOption('Second', 'Second'));
    chargesPicklist.add(new SelectOption('Minute', 'Minute'));
    chargesPicklist.add(new SelectOption('Hour', 'Hour'));
    chargesPicklist.add(new SelectOption('Day', 'Day'));
    chargesPicklist.add(new SelectOption('Week', 'Week'));
    chargesPicklist.add(new SelectOption('Event', 'Event'));
    chargesPicklist.add(new SelectOption('Byte', 'Byte'));
    chargesPicklist.add(new SelectOption('Kilobyte', 'Kilobyte'));
    chargesPicklist.add(new SelectOption('Megabyte', 'Megabyte'));
    chargesPicklist.add(new SelectOption('Gigabyte', 'Gigabyte'));
    chargesPicklist.add(new SelectOption('Terabyte', 'Terabyte'));
    chargesPicklist.add(new SelectOption('Count', 'Count'));
    chargesPicklist.add(new SelectOption('Currency', 'Currency'));
    chargesPicklist.add(new SelectOption('BITS_PER_SECOND', 'Bits/Second'));
    chargesPicklist.add(
      new SelectOption('KILOBITS_PER_SECOND', 'Kilobits/Second')
    );
    chargesPicklist.add(
      new SelectOption('MEGABITS_PER_SECOND', 'Megabits/Second')
    );
    chargesPicklist.add(
      new SelectOption('GIGABITS_PER_SECOND', 'Gigabits/Second')
    );

    formulaField.add(new SelectOption('Choose One', 'Choose One'));
    formulaField.add(new SelectOption('text01', 'text01'));
    formulaField.add(new SelectOption('text02', 'text02'));
    formulaField.add(new SelectOption('text03', 'text03'));
    formulaField.add(new SelectOption('text04', 'text04'));
    formulaField.add(new SelectOption('text05', 'text05'));
    formulaField.add(new SelectOption('number01', 'number01'));
    formulaField.add(new SelectOption('number02', 'number02'));
    formulaField.add(new SelectOption('number03', 'number03'));
    formulaField.add(new SelectOption('number04', 'number04'));
    formulaField.add(new SelectOption('number05', 'number05'));
    formulaField.add(new SelectOption('boolean01', 'boolean01'));
    formulaField.add(new SelectOption('boolean02', 'boolean02'));
    formulaField.add(new SelectOption('boolean03', 'boolean03'));
    formulaField.add(new SelectOption('boolean04', 'boolean04'));
    formulaField.add(new SelectOption('boolean05', 'boolean05'));
    formulaField.add(new SelectOption('date01', 'date01'));
    formulaField.add(new SelectOption('date02', 'date02'));
    formulaField.add(new SelectOption('date03', 'date03'));
    formulaField.add(new SelectOption('date04', 'date04'));
    formulaField.add(new SelectOption('date05', 'date05'));

    passThroughChargeList.add(new SelectOption('Choose One', 'Choose One'));
    passThroughChargeList.add(new SelectOption('number01', 'number01'));
    passThroughChargeList.add(new SelectOption('number02', 'number02'));
    passThroughChargeList.add(new SelectOption('number03', 'number03'));
    passThroughChargeList.add(new SelectOption('number04', 'number04'));
    passThroughChargeList.add(new SelectOption('number05', 'number05'));

    operationList.add(new SelectOption('Choose One', 'Choose One'));
    operationList.add(new SelectOption('Equals', '='));
    operationList.add(new SelectOption('NotEquals', '<>'));
    operationList.add(new SelectOption('GreaterThan', '>'));
    operationList.add(new SelectOption('GreaterThanEquals', '>='));
    operationList.add(new SelectOption('LessThan', '<'));
    operationList.add(new SelectOption('LessThanEquals', '<='));
    operationList.add(new SelectOption('Lookup', 'Lookup'));

    operationListAPI2.add(new SelectOption('Choose One', 'Choose One'));
    operationListAPI2.add(new SelectOption('EQUALS', '='));
    operationListAPI2.add(new SelectOption('NOT_EQUALS', '<>'));
    operationListAPI2.add(new SelectOption('GREATER_THAN', '>'));
    operationListAPI2.add(new SelectOption('GREATER_THAN_EQUALS', '>='));
    operationListAPI2.add(new SelectOption('LESS_THAN', '<'));
    operationListAPI2.add(new SelectOption('LESS_THAN_EQUALS', '<='));
    operationListAPI2.add(new SelectOption('LOOKUP', 'Lookup'));

    allowanceTypeList.add(new SelectOption('Recurring', 'Recurring'));
    allowanceTypeList.add(new SelectOption('Unlimited', 'Unlimited'));
    allowanceTypeList.add(new SelectOption('OneTime', 'One Time'));

    roleOverList.add(new SelectOption('None', 'None'));
    roleOverList.add(new SelectOption('Uncapped', 'Uncapped'));

    countryList = new List<SelectOption>();
    stateUsa = new List<SelectOption>();
    stateMex = new List<SelectOption>();
    stateCan = new List<SelectOption>();
    countryList.add(new SelectOption('undefined', 'Choose One'));
    countryList.add(new SelectOption('USA', 'UNITED STATES'));
    countryList.add(new SelectOption('AFG', 'AFGHANISTAN'));
    countryList.add(new SelectOption('ALA', 'ALAND ISLANDS'));
    countryList.add(new SelectOption('ALB', 'ALBANIA'));
    countryList.add(new SelectOption('DZA', 'ALGERIA'));
    countryList.add(new SelectOption('ASM', 'AMERICAN SAMOA'));
    countryList.add(new SelectOption('AND', 'ANDORRA'));
    countryList.add(new SelectOption('AGO', 'ANGOLA'));
    countryList.add(new SelectOption('AIA', 'ANGUILLA'));
    countryList.add(new SelectOption('ATA', 'ANTARCTICA'));
    countryList.add(new SelectOption('ATG', 'ANTIGUA AND BARBUDA'));
    countryList.add(new SelectOption('ARG', 'ARGENTINA'));
    countryList.add(new SelectOption('ARM', 'ARMENIA'));
    countryList.add(new SelectOption('ABW', 'ARUBA'));
    countryList.add(new SelectOption('AUS', 'AUSTRALIA'));
    countryList.add(new SelectOption('AUT', 'AUSTRIA'));
    countryList.add(new SelectOption('AZE', 'AZERBAIJAN'));
    countryList.add(new SelectOption('BHS', 'BAHAMAS'));
    countryList.add(new SelectOption('BHR', 'BAHRAIN'));
    countryList.add(new SelectOption('BGD', 'BANGLADESH'));
    countryList.add(new SelectOption('BRB', 'BARBADOS'));
    countryList.add(new SelectOption('BLR', 'BELARUS'));
    countryList.add(new SelectOption('BEL', 'BELGIUM'));
    countryList.add(new SelectOption('BLZ', 'BELIZE'));
    countryList.add(new SelectOption('BEN', 'BENIN'));
    countryList.add(new SelectOption('BMU', 'BERMUDA'));
    countryList.add(new SelectOption('BTN', 'BHUTAN'));
    countryList.add(new SelectOption('BM', 'BOLIVIA'));
    countryList.add(
      new SelectOption('BES', 'BONAIRE SAINT EUSTATIUS AND SABA')
    );
    countryList.add(new SelectOption('BIH', 'BOSNIA AND HERZEGOVINA'));
    countryList.add(new SelectOption('BWA', 'BOTSWANA'));
    countryList.add(new SelectOption('BVT', 'BOUVET ISLAND'));
    countryList.add(new SelectOption('BRA', 'BRAZIL'));
    countryList.add(new SelectOption('IOT', 'BRITISH INDIAN OCEAN TERRITORY'));
    countryList.add(new SelectOption('BRN', 'BRUNEI DARUSSALAM'));
    countryList.add(new SelectOption('BGR', 'BULGARIA'));
    countryList.add(new SelectOption('BFA', 'BURKINA FASO'));
    countryList.add(new SelectOption('BDI', 'BURUNDI'));
    countryList.add(new SelectOption('KHM', 'CAMBODIA'));
    countryList.add(new SelectOption('CMR', 'CAMEROON'));
    countryList.add(new SelectOption('CAN', 'CANADA'));
    countryList.add(new SelectOption('CPV', 'CAPE VERDE'));
    countryList.add(new SelectOption('CYM', 'CAYMAN ISLANDS'));
    countryList.add(new SelectOption('CAF', 'CENTRAL AFRICAN REPUBLIC'));
    countryList.add(new SelectOption('TCD', 'CHAD'));
    countryList.add(new SelectOption('CHL', 'CHILE'));
    countryList.add(new SelectOption('CHN', 'CHINA'));
    countryList.add(new SelectOption('CXR', 'CHRISTMAS ISLAND'));
    countryList.add(new SelectOption('CCK', 'COCOS ISLANDS'));
    countryList.add(new SelectOption('COL', 'COLOMBIA'));
    countryList.add(new SelectOption('COM', 'COMOROS'));
    countryList.add(new SelectOption('COD', 'CONGO'));
    countryList.add(new SelectOption('COG', 'CONGO'));
    countryList.add(new SelectOption('COK', 'COOK ISLANDS'));
    countryList.add(new SelectOption('CRI', 'COSTA RICA'));
    countryList.add(new SelectOption('CIV', 'COTE DIVOIRE'));
    countryList.add(new SelectOption('HRV', 'CROATIA'));
    countryList.add(new SelectOption('CUB', 'CUBA'));
    countryList.add(new SelectOption('CUW', 'CURACAO'));
    countryList.add(new SelectOption('CYP', 'CYPRUS'));
    countryList.add(new SelectOption('CZE', 'CZECH REPUBLIC'));
    countryList.add(new SelectOption('DNK', 'DENMARK'));
    countryList.add(new SelectOption('DJI', 'DJIBOUTI'));
    countryList.add(new SelectOption('DMA', 'DOMINICA'));
    countryList.add(new SelectOption('DOM', 'DOMINICAN REPUBLIC'));
    countryList.add(new SelectOption('ECU', 'ECUADOR'));
    countryList.add(new SelectOption('EGY', 'EGYPT'));
    countryList.add(new SelectOption('SLV', 'EL SALVADOR'));
    countryList.add(new SelectOption('GNQ', 'EQUATORIAL GUINEA'));
    countryList.add(new SelectOption('ERI', 'ERITREA'));
    countryList.add(new SelectOption('EST', 'ESTONIA'));
    countryList.add(new SelectOption('ETH', 'ETHIOPIA'));
    countryList.add(new SelectOption('FLK', 'FALKLAND ISLANDS'));
    countryList.add(new SelectOption('FRO', 'FAROE ISLANDS'));
    countryList.add(new SelectOption('FJI', 'FIJI'));
    countryList.add(new SelectOption('FIN', 'FINLAND'));
    countryList.add(new SelectOption('FRA', 'FRANCE'));
    countryList.add(new SelectOption('GUF', 'FRENCH GUIANA'));
    countryList.add(new SelectOption('PYF', 'FRENCH POLYNESIA'));
    countryList.add(new SelectOption('ATF', 'FRENCH SOUTHERN TERRITORIES'));
    countryList.add(new SelectOption('GAB', 'GABON'));
    countryList.add(new SelectOption('GMB', 'GAMBIA'));
    countryList.add(new SelectOption('GEO', 'GEORGIA'));
    countryList.add(new SelectOption('DEU', 'GERMANY'));
    countryList.add(new SelectOption('GHA', 'GHANA'));
    countryList.add(new SelectOption('GIB', 'GIBRALTAR'));
    countryList.add(new SelectOption('GRC', 'GREECE'));
    countryList.add(new SelectOption('GRL', 'GREENLAND'));
    countryList.add(new SelectOption('GRD', 'GRENADA'));
    countryList.add(new SelectOption('GLP', 'GUADELOUPE'));
    countryList.add(new SelectOption('GUM', 'GUAM'));
    countryList.add(new SelectOption('GTM', 'GUATEMALA'));
    countryList.add(new SelectOption('GGY', 'GUERNSEY'));
    countryList.add(new SelectOption('GIN', 'GUINEA'));
    countryList.add(new SelectOption('GNB', 'GUINEA-BISSAU'));
    countryList.add(new SelectOption('GUY', 'GUYANA'));
    countryList.add(new SelectOption('HTI', 'HAITI'));
    countryList.add(new SelectOption('HMD', 'HEARD AND MCDONALD ISLANDS'));
    countryList.add(new SelectOption('HND', 'HONDURAS'));
    countryList.add(new SelectOption('HKG', 'HONG KONG'));
    countryList.add(new SelectOption('HUN', 'HUNGARY'));
    countryList.add(new SelectOption('ISL', 'ICELAND'));
    countryList.add(new SelectOption('IND', 'INDIA'));
    countryList.add(new SelectOption('IDN', 'INDONESIA'));
    countryList.add(new SelectOption('IRN', 'IRAN'));
    countryList.add(new SelectOption('IRQ', 'IRAQ'));
    countryList.add(new SelectOption('IRL', 'IRELAND'));
    countryList.add(new SelectOption('IMN', 'ISLE OF MAN'));
    countryList.add(new SelectOption('ISR', 'ISRAEL'));
    countryList.add(new SelectOption('ITA', 'ITALY'));
    countryList.add(new SelectOption('JAM', 'JAMAICA'));
    countryList.add(new SelectOption('JPN', 'JAPAN'));
    countryList.add(new SelectOption('JEY', 'JERSEY'));
    countryList.add(new SelectOption('JOR', 'JORDAN'));
    countryList.add(new SelectOption('KAZ', 'KAZAKHSTAN'));
    countryList.add(new SelectOption('KEN', 'KENYA'));
    countryList.add(new SelectOption('KIR', 'KIRIBATI'));
    countryList.add(new SelectOption('KOR', 'KOREA'));
    countryList.add(new SelectOption('PRK', 'KOREA'));
    countryList.add(new SelectOption('KWT', 'KUWAIT'));
    countryList.add(new SelectOption('KGZ', 'KYRGYZSTAN'));
    countryList.add(new SelectOption('LAO', 'LAO'));
    countryList.add(new SelectOption('LVA', 'LATVIA'));
    countryList.add(new SelectOption('LBN', 'LEBANON'));
    countryList.add(new SelectOption('LSO', 'LESOTHO'));
    countryList.add(new SelectOption('LBR', 'LIBERIA'));
    countryList.add(new SelectOption('LBY', 'LIBYAN ARAB JAMAHIRIYA'));
    countryList.add(new SelectOption('LIE', 'LIECHTENSTEIN'));
    countryList.add(new SelectOption('LTU', 'LITHUANIA'));
    countryList.add(new SelectOption('LUX', 'LUXEMBOURG'));
    countryList.add(new SelectOption('MAC', 'MACAO'));
    countryList.add(new SelectOption('MKD', 'MACEDONIA'));
    countryList.add(new SelectOption('MDG', 'MADAGASCAR'));
    countryList.add(new SelectOption('MWI', 'MALAWI'));
    countryList.add(new SelectOption('MYS', 'MALAYSIA'));
    countryList.add(new SelectOption('MDV', 'MALDIVES'));
    countryList.add(new SelectOption('MLI', 'MALI'));
    countryList.add(new SelectOption('MLT', 'MALTA'));
    countryList.add(new SelectOption('MHL', 'MARSHALL ISLANDS'));
    countryList.add(new SelectOption('MTQ', 'MARTINIQUE'));
    countryList.add(new SelectOption('MRT', 'MAURITANIA'));
    countryList.add(new SelectOption('MUS', 'MAURITIUS'));
    countryList.add(new SelectOption('MYT', 'MAYOTTE'));
    countryList.add(new SelectOption('MEX', 'MEXICO'));
    countryList.add(new SelectOption('FSM', 'MICRONESIA'));
    countryList.add(new SelectOption('MDA', 'MOLDOVA'));
    countryList.add(new SelectOption('MCO', 'MONACO'));
    countryList.add(new SelectOption('MNG', 'MONGOLIA'));
    countryList.add(new SelectOption('MNE', 'MONTENEGRO'));
    countryList.add(new SelectOption('MSR', 'MONTSERRAT'));
    countryList.add(new SelectOption('MAR', 'MOROCCO'));
    countryList.add(new SelectOption('MOZ', 'MOZAMBIQUE'));
    countryList.add(new SelectOption('MMR', 'MYANMAR'));
    countryList.add(new SelectOption('NAM', 'NAMIBIA'));
    countryList.add(new SelectOption('NPL', 'NEPAL'));
    countryList.add(new SelectOption('NLD', 'NETHERLANDS'));
    countryList.add(new SelectOption('NCL', 'NEW CALEDONIA'));
    countryList.add(new SelectOption('NZL', 'NEW ZEALAND'));
    countryList.add(new SelectOption('NIC', 'NICARAGUA'));
    countryList.add(new SelectOption('NER', 'NIGER'));
    countryList.add(new SelectOption('NGA', 'NIGERIA'));
    countryList.add(new SelectOption('NIU', 'NIUE'));
    countryList.add(new SelectOption('NFK', 'NORFOLK ISLAND'));
    countryList.add(new SelectOption('MNP', 'NORTHERN MARIANA ISLANDS'));
    countryList.add(new SelectOption('NOR', 'NORWAY'));
    countryList.add(new SelectOption('OMN', 'OMAN'));
    countryList.add(new SelectOption('PAK', 'PAKISTAN'));
    countryList.add(new SelectOption('PLW', 'PALAU'));
    countryList.add(new SelectOption('PSE', 'PALESTINIAN TERRITORY'));
    countryList.add(new SelectOption('PAN', 'PANAMA'));
    countryList.add(new SelectOption('PNG', 'PAPUA NEW GUINEA'));
    countryList.add(new SelectOption('PRY', 'PARAGUAY'));
    countryList.add(new SelectOption('PER', 'PERU'));
    countryList.add(new SelectOption('PHL', 'PHILIPPINES'));
    countryList.add(new SelectOption('PCN', 'PITCAIRN'));
    countryList.add(new SelectOption('POL', 'POLAND'));
    countryList.add(new SelectOption('PRT', 'PORTUGAL'));
    countryList.add(new SelectOption('PRI', 'PUERTO RICO'));
    countryList.add(new SelectOption('QAT', 'QATAR'));
    countryList.add(new SelectOption('REU', 'REUNION'));
    countryList.add(new SelectOption('ROU', 'ROMANIA'));
    countryList.add(new SelectOption('RUS', 'RUSSIAN FEDERATION'));
    countryList.add(new SelectOption('RWA', 'RWANDA'));
    countryList.add(new SelectOption('BLM', 'SAINT BARTHELEMY'));
    countryList.add(new SelectOption('SHN', 'SAINT HELENA'));
    countryList.add(new SelectOption('KNA', 'SAINT KITTS AND NEVIS'));
    countryList.add(new SelectOption('LCA', 'SAINT LUCIA'));
    countryList.add(new SelectOption('MAF', 'SAINT MARTIN'));
    countryList.add(new SelectOption('SPM', 'SAINT PIERRE AND MIQUELON'));
    countryList.add(
      new SelectOption('VCT', 'SAINT VINCENT AND THE GRENADINES')
    );
    countryList.add(new SelectOption('WSM', 'SAMOA'));
    countryList.add(new SelectOption('SMR', 'SAN MARINO'));
    countryList.add(new SelectOption('STP', 'SAO TOME AND PRINCIPE'));
    countryList.add(new SelectOption('SAU', 'SAUDI ARABIA'));
    countryList.add(new SelectOption('SEN', 'SENEGAL'));
    countryList.add(new SelectOption('SRB', 'SERBIA'));
    countryList.add(new SelectOption('SYC', 'SEYCHELLES'));
    countryList.add(new SelectOption('SLE', 'SIERRA LEONE'));
    countryList.add(new SelectOption('SGP', 'SINGAPORE'));
    countryList.add(new SelectOption('SXM', 'SINT MAARTEN'));
    countryList.add(new SelectOption('SVK', 'SLOVAKIA'));
    countryList.add(new SelectOption('SVN', 'SLOVENIA'));
    countryList.add(new SelectOption('SLB', 'SOLOMON ISLANDS'));
    countryList.add(new SelectOption('SOM', 'SOMALIA'));
    countryList.add(new SelectOption('ZAF', 'SOUTH AFRICA'));
    countryList.add(new SelectOption('SGS', 'SOUTH GEORGIA ISLANDS'));
    countryList.add(new SelectOption('ESP', 'SPAIN'));
    countryList.add(new SelectOption('LKA', 'SRI LANKA'));
    countryList.add(new SelectOption('SDN', 'SUDAN'));
    countryList.add(new SelectOption('SUR', 'SURINAME'));
    countryList.add(new SelectOption('SJM', 'SVALBARD AND JAN MAYEN'));
    countryList.add(new SelectOption('SWZ', 'SWAZILAND'));
    countryList.add(new SelectOption('SWE', 'SWEDEN'));
    countryList.add(new SelectOption('CHE', 'SWITZERLAND'));
    countryList.add(new SelectOption('SYR', 'SYRIAN ARAB REPUBLIC'));
    countryList.add(new SelectOption('TWN', 'TAIWAN'));
    countryList.add(new SelectOption('TJK', 'TAJIKISTAN'));
    countryList.add(new SelectOption('TZA', 'TANZANIA'));
    countryList.add(new SelectOption('THA', 'THAILAND'));
    countryList.add(new SelectOption('TLS', 'TIMOR-LESTE'));
    countryList.add(new SelectOption('TGO', 'TOGO'));
    countryList.add(new SelectOption('TKL', 'TOKELAU'));
    countryList.add(new SelectOption('TON', 'TONGA'));
    countryList.add(new SelectOption('TTO', 'TRINIDAD AND TOBAGO'));
    countryList.add(new SelectOption('TUN', 'TUNISIA'));
    countryList.add(new SelectOption('TUR', 'TURKEY'));
    countryList.add(new SelectOption('TKM', 'TURKMENISTAN'));
    countryList.add(new SelectOption('TCA', 'TURKS AND CAICOS ISLANDS'));
    countryList.add(new SelectOption('TUV', 'TUVALU'));
    countryList.add(new SelectOption('UGA', 'UGANDA'));
    countryList.add(new SelectOption('UKR', 'UKRAINE'));
    countryList.add(new SelectOption('ARE', 'UNITED ARAB EMIRATES'));
    countryList.add(new SelectOption('GBR', 'UNITED KINGDOM'));
    countryList.add(new SelectOption('USA', 'UNITED STATES'));
    countryList.add(new SelectOption('URY', 'URUGUAY'));
    countryList.add(new SelectOption('UMI', 'US MINOR OUTLYING ISLANDS'));
    countryList.add(new SelectOption('UZB', 'UZBEKISTAN'));
    countryList.add(new SelectOption('VUT', 'VANUATU'));
    countryList.add(new SelectOption('VAT', 'VATICAN CITY STATE'));
    countryList.add(new SelectOption('VEN', 'VENEZUELA'));
    countryList.add(new SelectOption('VNM', 'VIET NAM'));
    countryList.add(new SelectOption('VGB', 'VIRGIN ISLANDS (BRITISH)'));
    countryList.add(new SelectOption('VIR', 'VIRGIN ISLANDS (U.S.)'));
    countryList.add(new SelectOption('WLF', 'WALLIS AND FUTUNA'));
    countryList.add(new SelectOption('ESH', 'WESTERN SAHARA'));
    countryList.add(new SelectOption('YEM', 'YEMEN'));
    countryList.add(new SelectOption('ZMB', 'ZAMBIA'));
    countryList.add(new SelectOption('ZWE', 'ZIMBABWE'));

    stateUsa.add(new SelectOption('undefined', 'Choose One'));
    stateUsa.add(new SelectOption('AL', 'ALABAMA'));
    stateUsa.add(new SelectOption('AK', 'ALASKA'));
    stateUsa.add(new SelectOption('AZ', 'ARIZONA'));
    stateUsa.add(new SelectOption('AR', 'ARKANSAS'));
    stateUsa.add(
      new SelectOption('AE', 'ARMED FORCES AFRICA, CANADA, EUROPE, MIDDLE EAST')
    );
    stateUsa.add(new SelectOption('AA', 'ARMED FORCES AMERICA'));
    stateUsa.add(new SelectOption('AP', 'ARMED FORCES PACIFIC'));
    stateUsa.add(new SelectOption('CA', 'CALIFORNIA'));
    stateUsa.add(new SelectOption('CT', 'CONNECTICUT'));
    stateUsa.add(new SelectOption('DC', 'DISTRICT OF COLUMBIA'));
    stateUsa.add(new SelectOption('DE', 'DELAWARE'));
    stateUsa.add(new SelectOption('FL', 'FLORIDA'));
    stateUsa.add(new SelectOption('GA', 'GEORGIA'));
    stateUsa.add(new SelectOption('HI', 'HAWAII'));
    stateUsa.add(new SelectOption('ID', 'IDAHO'));
    stateUsa.add(new SelectOption('IL', 'ILLINOIS'));
    stateUsa.add(new SelectOption('IA', 'IOWA'));
    stateUsa.add(new SelectOption('IN', 'INDIANA'));
    stateUsa.add(new SelectOption('KS', 'KANSAS'));
    stateUsa.add(new SelectOption('KY', 'KENTUCKY'));
    stateUsa.add(new SelectOption('LA', 'LOUISIANA'));
    stateUsa.add(new SelectOption('ME', 'MAINE'));
    stateUsa.add(new SelectOption('MB', 'MANITOBA'));
    stateUsa.add(new SelectOption('MD', 'MARYLAND'));
    stateUsa.add(new SelectOption('MA', 'MASSACHUSETTS'));
    stateUsa.add(new SelectOption('MI', 'MICHIGAN'));
    stateUsa.add(new SelectOption('MN', 'MINNESOTA'));
    stateUsa.add(new SelectOption('MS', 'MISSISSIPPI'));
    stateUsa.add(new SelectOption('MO', 'MISSOURI'));
    stateUsa.add(new SelectOption('MT', 'MONTANA'));
    stateUsa.add(new SelectOption('NE', 'NEBRASKA'));
    stateUsa.add(new SelectOption('NV', 'NEVADA'));
    stateUsa.add(new SelectOption('NH', 'NEW HAMPSHIRE'));
    stateUsa.add(new SelectOption('NJ', 'NEW JERSEY'));
    stateUsa.add(new SelectOption('NM', 'NEW MEXICO'));
    stateUsa.add(new SelectOption('NY', 'NEW YORK'));
    stateUsa.add(new SelectOption('NC', 'NORTH CAROLINA'));
    stateUsa.add(new SelectOption('ND', 'NORTH DAKOTA'));
    stateUsa.add(new SelectOption('OH', 'OHIO'));
    stateUsa.add(new SelectOption('OK', 'OKLAHOMA'));
    stateUsa.add(new SelectOption('OR', 'OREGON'));
    stateUsa.add(new SelectOption('PA', 'PENNSYLVANIA'));
    stateUsa.add(new SelectOption('PR', 'PUERTO RICO'));
    stateUsa.add(new SelectOption('RI', 'RHODE ISLAND'));
    stateUsa.add(new SelectOption('SC', 'SOUTH CAROLINA'));
    stateUsa.add(new SelectOption('SD', 'SOUTH DAKOTA'));
    stateUsa.add(new SelectOption('TN', 'TENNESSEE'));
    stateUsa.add(new SelectOption('TX', 'TEXAS'));
    stateUsa.add(new SelectOption('UT', 'UTAH'));
    stateUsa.add(new SelectOption('VT', 'VERMONT'));
    stateUsa.add(new SelectOption('VA', 'VIRGINIA'));
    stateUsa.add(new SelectOption('WA', 'WASHINGTON'));
    stateUsa.add(new SelectOption('WV', 'WEST VIRGINIA'));
    stateUsa.add(new SelectOption('WI', 'WISCONSIN'));
    stateUsa.add(new SelectOption('WY', 'WYOMING'));

    stateMex.add(new SelectOption('undefined', 'Choose One'));
    stateMex.add(new SelectOption('AG', 'AGUASCALIENTES'));
    stateMex.add(new SelectOption('BN', 'BAJA CALIFORNIA'));
    stateMex.add(new SelectOption('BS', 'BAJA CALIFORNIA SUR'));
    stateMex.add(new SelectOption('CM', 'CAMPECHE'));
    stateMex.add(new SelectOption('CP', 'CHIAPAS'));
    stateMex.add(new SelectOption('CH', 'CHIHUAHUA'));
    stateMex.add(new SelectOption('CAA', 'COAHUILA'));
    stateMex.add(new SelectOption('CL', 'COLIMA'));
    stateMex.add(new SelectOption('DF', 'DISTRITO FEDERAL'));
    stateMex.add(new SelectOption('DU', 'DURANGO'));
    stateMex.add(new SelectOption('GJ', 'GUANAJUATO'));
    stateMex.add(new SelectOption('GR', 'GUERRERO'));
    stateMex.add(new SelectOption('HII', 'HIDALGO'));
    stateMex.add(new SelectOption('JA', 'JALISCO'));
    stateMex.add(new SelectOption('MX', 'MEXICO'));
    stateMex.add(new SelectOption('MC', 'MICHOACAN'));
    stateMex.add(new SelectOption('MR', 'MORELOS'));
    stateMex.add(new SelectOption('NA', 'NAYARIT'));
    stateMex.add(new SelectOption('NL', 'NUEVO LEON'));
    stateMex.add(new SelectOption('OA', 'OAXACA'));
    stateMex.add(new SelectOption('PU', 'PUEBLA'));
    stateMex.add(new SelectOption('QE', 'QUERETARO'));
    stateMex.add(new SelectOption('QR', 'QUINTANA ROO'));
    stateMex.add(new SelectOption('SL', 'SAN LUIS POTOSI'));
    stateMex.add(new SelectOption('SI', 'SINALOA'));
    stateMex.add(new SelectOption('SO', 'SONORA'));
    stateMex.add(new SelectOption('TB', 'TABASCO'));
    stateMex.add(new SelectOption('TM', 'TAMAULIPAS'));
    stateMex.add(new SelectOption('TL', 'TLAXCALA'));
    stateMex.add(new SelectOption('VE', 'VERACRUZ'));
    stateMex.add(new SelectOption('YU', 'YUCATAN'));
    stateMex.add(new SelectOption('ZA', 'ZACATECAS'));

    stateCan.add(new SelectOption('undefined', 'Choose One'));
    stateCan.add(new SelectOption('AB', 'ALBERTA'));
    stateCan.add(new SelectOption('BC', 'BRITISH COLUMBIA'));
    stateCan.add(new SelectOption('MB', 'MANITOBA'));
    stateCan.add(new SelectOption('NB', 'NEW BRUNSWICK'));
    stateCan.add(new SelectOption('NL', 'NEWFOUNDLAND AND LABRADOR'));
    stateCan.add(new SelectOption('NT', 'NORTHWEST TERRITORIES '));
    stateCan.add(new SelectOption('NS', 'NOVA SCOTIA'));
    stateCan.add(new SelectOption('NU', 'NUNAVUT'));
    stateCan.add(new SelectOption('ON', 'ONTARIO'));
    stateCan.add(new SelectOption('PE', 'PRINCE EDWARD ISLAND'));
    stateCan.add(new SelectOption('QC', 'QUEBEC'));
    stateCan.add(new SelectOption('SK', 'SASKATCHEWAN'));
    stateCan.add(new SelectOption('YT', 'YUKON'));
  }

  /**
   * Query Accounts from SF db
   * @param accountId The name of the parameter (required)
   * @param pageNumber (required)
   * @return Account The billing account
   *
   */
  @AuraEnabled(cacheable=true)
  public static Account getBillingAccount(String accountId) {
    Account thisAccount;
    thisAccount = [
      SELECT
        Id,
        Name,
        BillingStreet,
        BillingCity,
        BillingPostalCode,
        BillingState,
        NumberOfEmployees,
        BillingCountry,
        ShippingStreet,
        ShippingCity,
        ShippingPostalCode,
        ShippingState,
        ShippingCountry,
        Phone,
        Currency_Type__c,
        Tract_Billing_Account__c,
        Email__c
      FROM Account
      WHERE id = :accountId
      LIMIT 1
    ];
    return thisAccount;
  }
  /**
   * Query Accounts from SF db and return UI wrapper after mapping the response
   * @param accountId The name of the parameter (required)
   * @return TRACTAccountWrapper The billing account wrapper
   *
   */
  @AuraEnabled(cacheable=true)
  public static TRACTAccountWrapper getConfigDetails(String accountId) {
    Account thisAccount;
    thisAccount = [
      SELECT
        Id,
        Name,
        BillingStreet,
        BillingCity,
        BillingPostalCode,
        BillingState,
        NumberOfEmployees,
        BillingCountry,
        ShippingStreet,
        ShippingCity,
        ShippingPostalCode,
        ShippingState,
        ShippingCountry,
        Phone,
        Currency_Type__c,
        Tract_Billing_Account__c,
        Email__c,
        GTV_Account_Category__c,
        GTV_Bill_Cycle__c,
        Tax_Exempt__c,
        GTV_Payment_Term__c,
        Account_Create_Date__c,
        Gotransverse_Bill_Type__c
      FROM Account
      WHERE id = :accountId
      LIMIT 1
    ];
    AccountMappingWrapper accountMapDetails = AccountMappingController.showAccountMap(
      accountId
    );
    thisAccount.Name = accountMapDetails.mapOfNamesVsVales.get('AccountName');
    TRACTAccountWrapper configDetailsWrapper = new TRACTAccountWrapper();
    configDetailsWrapper.billingAccount = thisAccount;
    configDetailsWrapper.accountCurrency = thisAccount.TRACT3__Currency_Type__c;
    configDetailsWrapper.paymentTerm = thisAccount.TRACT3__GTV_Payment_Term__c;
    configDetailsWrapper.validFrom = thisAccount.TRACT3__Account_Create_Date__c;
    configDetailsWrapper.taxExempt = thisAccount.TRACT3__Tax_Exempt__c;
    configDetailsWrapper.billCycleName = thisAccount.TRACT3__GTV_Bill_Cycle__c;
    configDetailsWrapper.accountCategory = thisAccount.TRACT3__GTV_Account_Category__c;
    configDetailsWrapper.Email = accountMapDetails.mapOfNamesVsVales.get(
      'GotransverseEmail'
    );
    configDetailsWrapper.billType = TractSFDC_Util.convertInvoiceTypeToCamelCase(
      thisAccount.Gotransverse_Bill_Type__c,
      '_'
    );
    return configDetailsWrapper;
  }

  /**
   * Query Accounts from SF db and return UI wrapper after mapping the API response
   * @param accountId The name of the parameter (required)
   * @return TRACTAccountWrapper The billing account wrapper
   *
   */
  @AuraEnabled(cacheable=true)
  public static TRACTAccountWrapper getBillingAccountdetail(String accountId) {
    TRACT_Setup__c tractList = new TRACT_Setup__c();
    tractList = [
      SELECT id, TPassword__c, Tract_User_Name__c, TRACT_URL__c, Api_Version__c
      FROM TRACT_Setup__c
      LIMIT 1
    ];
    Account thisAccount = getBillingAccount(accountId);
    APIDataService dataService = GTVDataService.getService();
    TRACTAccountWrapper billingAccount = dataService.getBillingAccount(
      thisAccount.id
    );
    billingAccount.APIVersion = tractList.Api_Version__c;
    return billingAccount;
  }

  /**
   * Query Accounts from SF db and return UI wrapper after mapping the API response
   * @return Map<String,Boolean> The permisssion set containing name and boolean true or false to whether or not show it on UI
   */
  @AuraEnabled
  public static Map<String, Boolean> getpermissions() {
    Map<String, GetPermissionSet__c> getAllPermissionSet = GetPermissionSet__c.getAll();
    Map<string, boolean> mapOfPermissionSetVSCheck = new Map<string, boolean>();
    Set<string> setOfPermissionAssignment = new Set<String>();
    list<PermissionSetAssignment> permissionSetAssignmentList = [
      SELECT
        Id,
        PermissionSetId,
        PermissionSet.Name,
        PermissionSet.ProfileId,
        PermissionSet.Profile.Name,
        AssigneeId,
        Assignee.Name
      FROM PermissionSetAssignment
      WHERE Assignee.Id = :UserInfo.getUserId()
    ];
    for (PermissionSetAssignment str : permissionSetAssignmentList) {
      setOfPermissionAssignment.add(str.PermissionSet.Name);
    }
    for (GetPermissionSet__c getPermissionSet : getAllPermissionSet.values()) {
      if (
        (getPermissionSet.SetStatus__c == true &&
        getPermissionSet.SetName__c == null) ||
        (getPermissionSet.SetStatus__c == true &&
        setOfPermissionAssignment.contains(getPermissionSet.SetName__c))
      ) {
        mapOfPermissionSetVSCheck.put(getPermissionSet.Name, true);
      }
    }
    /* For temporary time till the APIs are not available */
    TRACT_Setup__c tractList = new TRACT_Setup__c();
    tractList = [
      SELECT id, TPassword__c, Tract_User_Name__c, TRACT_URL__c, Api_Version__c
      FROM TRACT_Setup__c
      LIMIT 1
    ];

    if (tractList.Api_Version__c == 'API Version 2.0') {
      mapOfPermissionSetVSCheck.put(tractList.Api_Version__c, false);
    } else {
      mapOfPermissionSetVSCheck.put(tractList.Api_Version__c, true);
    }
    return mapOfPermissionSetVSCheck;
  }

  /**
   * @param accountId Id of the salesforce Account
   * @param pagenumber to be set while Querying Entity
   * @return TractServiceWrapper Service Details
   **/
  @AuraEnabled(cacheable=true)
  public static TractServiceWrapper setUpServices(
    String accountWrapper,
    Integer pagenumber
  ) {
    list<Account> accList = new List<Account>();
    TRACTAccountWrapper tractBillingAccount = (TRACTAccountWrapper) JSON.deserialize(
      accountWrapper,
      TRACTAccountWrapper.class
    );
    TRACT_Setup__c tract = [
      SELECT
        id,
        TPassword__c,
        Tract_User_Name__c,
        TRACT_URL__c,
        Active__c,
        Api_Version__c,
        TRACT_URL2_0__c
      FROM TRACT_Setup__c
      WHERE Active__c = TRUE
      LIMIT 1
    ];
    Account thisAccount = tractBillingAccount.billingAccount;
    accList.add(thisAccount);
    List<SelectOption> serviceReasons = getServiceReason();

    List<SelectOption> suspendServicesReason = getSuspendServiceReason();

    ChargeRulesWrapper chargeRules = new ChargeRulesWrapper();
    chargeRules.selectStatusList1 = selectStatusList;
    chargeRules.selectStatusListValue = 'Draft';
    if (tract.Api_Version__c == 'API Version 2.0') {
      chargeRules.productUsageRuleList1 = productUsageRuleListAPI2;
      chargeRules.operationList1 = operationListAPI2;
    } else {
      chargeRules.productUsageRuleList1 = productUsageRuleList;
      chargeRules.operationList1 = operationList;
    }
    chargeRules.productUsageRuleListValue = 'Match All Events';
    chargeRules.rateTypeList1 = rateTypeList;
    chargeRules.rateTypeListValue = 'Flat';
    chargeRules.chargesPicklist1 = chargesPicklist;
    chargeRules.chargesPicklistValue = ' ';
    chargeRules.allowanceTypeList1 = allowanceTypeList;
    chargeRules.allowanceTypeListValue = 'Recurring';
    chargeRules.roleOverList1 = roleOverList;
    chargeRules.roleOverListValue = 'None';
    chargeRules.formulaField1 = formulaField;
    chargeRules.formulaFieldValue = ' ';
    chargeRules.operationListValue = ' ';
    chargeRules.passThroughChargeList1 = passThroughChargeList;
    chargeRules.passThroughChargeListValue = ' ';
    chargeRules.formulaUsageRuleList = getFormulaUsageRuleSpecificationListMethod();
    chargeRules.formulaUsageRuleListValue = ' ';
    chargeRules.chargeListBytes = getchargeListBytesMethod();
    chargeRules.chargeListBytesValue = ' ';
    chargeRules.chargeCategoryList = getchargeCategoryListMethod();
    chargeRules.chargeCategoryListValue = ' ';
    chargeRules.serviceUsageRuleName = ' ';
    chargeRules.chargeValue = 0;
    chargeRules.ammountValue = 0;
    chargeRules.activityFormulaValue = ' ';
    chargeRules.prorateOnOrder = false;
    chargeRules.prorateOnCancel = false;

    TractServiceWrapper serviceWrapper = new TractServiceWrapper();
    APIDataService dataService = GTVDataService.getService();
    serviceWrapper = dataService.setUpServices(
      accList,
      stateCan,
      stateMex,
      stateUsa,
      countryList,
      serviceReasons,
      suspendServicesReason,
      tractBillingAccount,
      chargeRules,
      tract,
      pagenumber
    );
    return serviceWrapper;
  }
  /**
   * @param tract tractBilling information
   * @param thisAccount SF Account
   * @return TractServiceWrapper Service Detailsvoid
   **/
  public static void getBillingAccount(
    TRACT_Setup__c tract,
    Account thisAccount
  ) {
    list<Account> accList = new List<Account>();
    accList.add(thisAccount);
    APIDataService dataService = GTVDataService.getService();
    dataService.getAccount(accList);
  }
  /**
   *@param accountId Id of the salesforce Account
   *@param pagenumber to be set while Querying Entity
   *@return TractSalesOrderWrapper
   */
  @AuraEnabled(cacheable=true)
  public static TractSalesOrderWrapper getSalesOrder(
    String accountString,
    Integer pagenumber
  ) {
    TRACTAccountWrapper tractBillingAccount = (TRACTAccountWrapper) JSON.deserialize(
      accountString,
      TRACTAccountWrapper.class
    );
    TractSalesOrderWrapper orderWrapper = new TractSalesOrderWrapper();
    APIDataService dataService = GTVDataService.getService();
    orderWrapper = dataService.getSalesOrders(tractBillingAccount, pagenumber);
    return orderWrapper;
  }

  /**
   *@param accountId Id of the salesforce Account
   *@param pagenumber to be set while Querying Entity
   *@return TractSalesOrderWrapper
   */
  @AuraEnabled(cacheable=true)
  public static TractPaymentWrapper setUpPayments(
    String accountWrapper,
    Integer pageNumber
  ) {
    TractPaymentWrapper paymentwrap = new TractPaymentWrapper();
    TRACTAccountWrapper tractBillingAccount = (TRACTAccountWrapper) JSON.deserialize(
      accountWrapper,
      TRACTAccountWrapper.class
    );
    APIDataService dataService = GTVDataService.getService();
    paymentwrap = dataService.getPayments(tractBillingAccount, pageNumber);
    return paymentwrap;
  }

  /**
   *@param accountId Id of the salesforce Account
   *@param pagenumber to be set while Querying Entity
   *@return TractAdjustmentWrapper
   */
  @AuraEnabled(cacheable=true)
  public static TractAdjustmentWrapper setUpDebitAdjustment(
    String accountWrapper,
    Integer pageNumber
  ) {
    TRACTAccountWrapper tractBillingAccount = (TRACTAccountWrapper) JSON.deserialize(
      accountWrapper,
      TRACTAccountWrapper.class
    );
    TractAdjustmentWrapper adjustmentWrap = new TractAdjustmentWrapper();
    APIDataService dataService = GTVDataService.getService();
    adjustmentWrap = dataService.getDebitAdjustments(
      tractBillingAccount,
      pageNumber
    );
    return adjustmentWrap;
  }

  /**
   *@param accountId Id of the salesforce Account
   *@param pagenumber to be set while Querying Entity
   *@return TractAdjustmentWrapper
   */
  @AuraEnabled(cacheable=true)
  public static TractAdjustmentWrapper setUpCreditAdjustment(
    String accountWrapper,
    Integer pageNumber
  ) {
    TRACTAccountWrapper tractBillingAccount = (TRACTAccountWrapper) JSON.deserialize(
      accountWrapper,
      TRACTAccountWrapper.class
    );
    TractAdjustmentWrapper adjustmentWrap = new TractAdjustmentWrapper();
    APIDataService dataService = GTVDataService.getService();
    adjustmentWrap = dataService.getCreditAdjustments(
      tractBillingAccount,
      pageNumber
    );
    return adjustmentWrap;
  }
  /**
   *@param accountId Id of the salesforce Account
   *@param pagenumber to be set while Querying Entity
   *@return ActivityEventsWrapper
   */
  @AuraEnabled(cacheable=true)
  public static ActivityEventsWrapper setUpUsagesEvents(
    String accountString,
    Integer pagenumber
  ) {
    TRACTAccountWrapper tractBillingAccount = (TRACTAccountWrapper) JSON.deserialize(
      accountString,
      TRACTAccountWrapper.class
    );
    ActivityEventsWrapper usageWrap = new ActivityEventsWrapper();
    APIDataService dataService = GTVDataService.getService();
    usageWrap = dataService.getUsagesEvents(tractBillingAccount, pageNumber);
    return usageWrap;
  }

  /**
   *@param accountId Id of the salesforce Account
   *@param pagenumber to be set while Querying Entity
   *@return TractInvoiceWrapper
   */
  @AuraEnabled(cacheable=true)
  public static TractInvoiceWrapper setUpInvoices(
    String accountString,
    Integer pageNumber
  ) {
    TRACTAccountWrapper tractBillingAccount = (TRACTAccountWrapper) JSON.deserialize(
      accountString,
      TRACTAccountWrapper.class
    );
    TractInvoiceWrapper invoiceWrap = new TractInvoiceWrapper();
    APIDataService dataService = GTVDataService.getService();
    invoiceWrap = dataService.getInvoices(tractBillingAccount, pageNumber);
    return invoiceWrap;
  }
  /**
   *Method to show the new services to UI
   *@param Account salesforce Account
   *@param serviceRenewEid
   *@return RenewServiceWrapper
   */
  @AuraEnabled
  public static RenewServiceWrapper showServices(
    Account thisAccount,
    String serviceRenewEid
  ) {
    String serviceProductEid;
    list<Account> accList = new List<Account>();
    accList.add(thisAccount);
    RenewServiceWrapper serviceWrapper = new RenewServiceWrapper();
    APIDataService dataService = GTVDataService.getService();
    serviceWrapper = dataService.showServices(accList, serviceRenewEid);
    return serviceWrapper;
  }
  /**
   *Method to get the services by Service Id
   *@param serviceWrap JSON formatted information
   *@return ServiceDetailWrapper
   */
  @AuraEnabled
  public static ServiceDetailWrapper getServiceDetail(String serviceWrap) {
    ProductServiceWrapper serviceWrapper = (ProductServiceWrapper) JSON.deserialize(
      serviceWrap,
      ProductServiceWrapper.class
    );
    ServiceDetailWrapper detail = new ServiceDetailWrapper();
    APIDataService dataService = GTVDataService.getService();
    detail = dataService.getServiceById(serviceWrapper);
    return detail;
  }
  /**
   *Method to get the services by Service Id
   *@param renewAgreementEid JSON formatted information
   *@param tract JSON formatted information
   *@param thisAccount JSON formatted information
   *@param tract JSON formatted information
   *@param tract JSON formatted information
   *@return ServiceDetailWrapper
   */
  @AuraEnabled
  public static string savePopupRenew(
    String renewAgreementEid,
    TRACT_Setup__c tract,
    Account thisAccount,
    String serviceRenewEid,
    String recurringPriceString,
    String oneTimePriceString,
    Boolean dateOverridden,
    String deactivateDateString
  ) {
    String error = 'NoError';
    list<Account> accList = new List<Account>();
    accList.add(thisAccount);
    try {
      APIDataService dataService = GTVDataService.getService();
      dataService.savePopupRenew(
        renewAgreementEid,
        accList,
        serviceRenewEid,
        recurringPriceString,
        oneTimePriceString,
        dateOverridden,
        deactivateDateString
      );
    } catch (Exception e) {
      if (e.getmessage().contains('Web service callout failed')) {
        return e.getmessage()
          .substringBetween(
            'Web service callout failed: WebService returned a SOAP Fault:',
            ' faultcode=soap:Server faultactor='
          );
      } else {
        if (e.getmessage().contains('Validation error')) {
          return e.getmessage().substringAfter('Validation error:');
        }
      }
    }
    return error;
  }

  @AuraEnabled
  public static String saveDeactivateService(
    String serviceEid,
    String reasonEid,
    String deactivationDate
  ) {
    String emessage;
    APIDataService dataService = GTVDataService.getService();
    emessage = dataService.saveDeactivateService(
      serviceEid,
      reasonEid,
      deactivationDate
    );
    return emessage;
  }
  /**
   * @param reasonFor, get reason for
   * @return List<SelectOption>, reason option list list to show on UI
   * @description - This method is used to get reason option list to change status of billing account
   **/
  @AuraEnabled
  public static List<SelectOption> getBillingAccountStatusChangeReason(
    String reasonFor
  ) {
    List<SelectOption> reasonList = new List<SelectOption>();
    APIDataService dataService = GTVDataService.getService();
    reasonList = dataService.getBillingAccountStatus(reasonFor);
    return reasonList;
  }

  /**
   * @param accountString, serialized Billing Account
   * @param effectiveDate, Effective date
   * @return String, error message, if any
   * @description - This method is used to resume the billing account
   **/
  @AuraEnabled
  public static String resumeBillingAccount(String accountString) {
    TRACTAccountWrapper tractBillingAccount = (TRACTAccountWrapper) JSON.deserialize(
      accountString,
      TRACTAccountWrapper.class
    );
    try {
      APIDataService dataService = GTVDataService.getService();
      dataService.resumeBillingAccount(tractBillingAccount);
    } catch (Exception e) {
      if (e.getmessage().contains('Web service callout failed')) {
        return e.getmessage()
          .substringBetween(
            'Web service callout failed: WebService returned a SOAP Fault:',
            ' faultcode=soap:Server faultactor='
          );
      } else {
        if (e.getmessage().contains('Validation error')) {
          return e.getmessage().substringAfter('Validation error:');
        }
      }
    }
    return 'NoError';
  }

  /**
   * @param accountString, serialized Billing Account
   * @param reasonEid, the reason eid for deactivate the billing account
   * @param effectiveDate, Effective date
   * @return String, error message, if any
   * @description - This method is used to deactivate the billing account
   **/
  @AuraEnabled
  public static String deactivateBillingAccount(
    String accountString,
    String reasonEid
  ) {
    TRACTAccountWrapper tractBillingAccount = (TRACTAccountWrapper) JSON.deserialize(
      accountString,
      TRACTAccountWrapper.class
    );
    try {
      APIDataService dataService = GTVDataService.getService();
      dataService.deactivateBillingAccount(tractBillingAccount, reasonEid);
    } catch (Exception e) {
      if (e.getmessage().contains('Web service callout failed')) {
        return e.getmessage()
          .substringBetween(
            'Web service callout failed: WebService returned a SOAP Fault:',
            ' faultcode=soap:Server faultactor='
          );
      } else {
        if (e.getmessage().contains('Validation error')) {
          return e.getmessage().substringAfter('Validation error:');
        }
      }
    }
    return 'NoError';
  }

  /**
   * @param accountString, serialized Billing Account
   * @param reasonEid, the reason eid for suspending the billing account
   * @param effectiveDate, Effective date
   * @return String, error message, if any
   * @description - This method is used to suspend the billing account
   **/
  @AuraEnabled
  public static String suspendBillingAccount(
    String accountString,
    String reasonEid
  ) {
    TRACTAccountWrapper tractBillingAccount = (TRACTAccountWrapper) JSON.deserialize(
      accountString,
      TRACTAccountWrapper.class
    );
    try {
      APIDataService dataService = GTVDataService.getService();
      dataService.suspendBillingAccount(tractBillingAccount, reasonEid);
    } catch (Exception e) {
      String emessage = string.valueof(e.getmessage() + e.getLineNumber());
      if (e.getmessage().contains('Web service callout failed')) {
        return e.getmessage()
          .substringBetween(
            'Web service callout failed: WebService returned a SOAP Fault:',
            ' faultcode=soap:Server faultactor='
          );
      } else {
        if (e.getmessage().contains('Validation error')) {
          return e.getmessage().substringAfter('Validation error:');
        }
      }
    }
    return 'NoError';
  }

  /**
   * @param productServiceWrapper, the wrapper
   * @param serviceResourceToBeApplied, The service resource to be applied
   * @param isNewServiceResource, Boolean to check if it's a new Service Resource
   * @param effectiveDate, Effective date for the Service Resource to be applied
   * @description - This method is used to change an aplied service resource on a Service
   **/
  @AuraEnabled
  public static String changeServiceResource(
    String productServiceWrapper,
    String serviceResourceToBeApplied,
    Boolean isNewServiceResource,
    String effectiveDate,
    String parentServiceEid
  ) {
    ProductServiceWrapper wrapperObj = (ProductServiceWrapper) JSON.deserialize(
      productServiceWrapper,
      ProductServiceWrapper.class
    );
    try {
      APIDataService dataService = GTVDataService.getService();
      dataService.changeServiceResource(
        wrapperObj,
        serviceResourceToBeApplied,
        isNewServiceResource,
        effectiveDate,
        parentServiceEid
      );
    } catch (Exception e) {
      if (e.getmessage().contains('Web service callout failed')) {
        return e.getmessage()
          .substringBetween(
            'Web service callout failed: WebService returned a SOAP Fault:',
            ' faultcode=soap:Server faultactor='
          );
      } else {
        if (e.getmessage().contains('Validation error')) {
          return e.getmessage().substringAfter('Validation error:');
        }
      }
    }
    return 'No Error';
  }
  /**
   * @param serviceResourceIdentifier
   * @description - This method is used to validate the existing service resource to be applied on a service
   **/
  @AuraEnabled
  public static String getServiceResource(String serviceResourceIdentifier) {
    String serviceResourcEid = 'NoError';
    ServiceResourceWrapper srWrapper = new ServiceResourceWrapper();
    try {
      APIDataService dataService = GTVDataService.getService();
      srWrapper = dataService.getServiceResource(serviceResourceIdentifier);
    } catch (exception e) {
      serviceResourcEid = 'Error - ' + e.getmessage();
      return serviceResourcEid;
    }
    if (srWrapper.errorMessage == 'NoError') {
      serviceResourcEid = srWrapper.eid;
    } else {
      serviceResourcEid = srWrapper.errorMessage;
    }
    return serviceResourcEid;
  }

  /**
   * @param ServiceEid : The id of service on which the service resource has to be applied
   * @param srId       : Identifier of service resource to be applied
   * @param isNew      : Boolean to check if the service resource is new or existing
   * @effectiveDate    : Effective date
   * @return           : Error String, if any
   * @description      : This method applies new or existing service resources to selected service
   **/
  @AuraEnabled
  public static String applyServiceResourceToService(
    String serviceEid,
    String srId,
    Boolean isNew,
    String effectiveDate
  ) {
    try {
      APIDataService dataService = GTVDataService.getService();
      dataService.applyServiceResourceToService(
        serviceEid,
        srId,
        isNew,
        effectiveDate
      );
    } catch (Exception e) {
      if (e.getmessage().contains('Web service callout failed')) {
        return e.getmessage()
          .substringBetween(
            'Web service callout failed: WebService returned a SOAP Fault:',
            ' faultcode=soap:Server faultactor='
          );
      } else if (e.getmessage().contains('ExecutionException')) {
        return e.getmessage().substringAfter('ExecutionException');
      } else if (e.getmessage().contains('Validation error')) {
        return e.getmessage().substringAfter('Validation error:');
      } else {
        return e.getmessage();
      }
    }
    return 'No Error';
  }
  /**
   * @param invoiceWrap, InvoiceWrapper
   * @return InvoiceDetailWrapper, containing the Invoice Data
   * @description - This method is used to deactivate the billing account
   **/
  @AuraEnabled
  public static InvoiceDetailWrapper getInvoiceData(String invoiceWrap) {
    InvoiceDetailWrapper detail = new InvoiceDetailWrapper();
    InvoiceWrapper wrapperObj = (InvoiceWrapper) JSON.deserialize(
      invoiceWrap,
      InvoiceWrapper.class
    );
    //try{
    APIDataService dataService = GTVDataService.getService();
    detail = dataService.getInvoiceByNumber(wrapperObj);
    /*}
        catch(Exception ex){
        }*/
    return detail;
  }
  /**
   * @param serviceEid, suspend Service EId
   * @param reasonEid, the reason eid for suspending service
   * @return String, error message, if any
   * @description - This method is used to suspend the Service
   **/
  @AuraEnabled
  public static String suspendServiceTract(
    String serviceEid,
    String reasonEid
  ) {
    String emessage = 'NoError';
    try {
      APIDataService dataService = GTVDataService.getService();
      dataService.suspendServiceGTV(serviceEid, reasonEid);
    } catch (Exception e) {
      emessage = string.valueof(e.getmessage() + e.getLineNumber());
      if (emessage.contains('Web service callout failed')) {
        emessage = emessage.substringBetween(
          'Web service callout failed: WebService returned a SOAP Fault:',
          ' faultcode=soap:Server faultactor='
        );
      } else if (e.getmessage().contains('Validation error')) {
        return e.getmessage().substringAfter('Validation error:');
      }
    }
    return emessage;
  }
  /**
   * @param currentProductEid, Id of the product to be Changed
   * @param currencyType, currency type of the product
   * @param preserveAgreement, Checkbbox whihc is either true or false
   * @return ChangeSubscriptionWrapper, wrapper containing the services cased on productEId
   * @description - This method is used to show the services the user can replace the existing service with
   **/
  @AuraEnabled
  public static ChangeSubscriptionWrapper showPopupChangeService(
    String currentProductEid,
    String currencyType,
    Boolean preserveAgreement
  ) {
    ChangeSubscriptionWrapper subscriptionWrapper = new ChangeSubscriptionWrapper();
    String emessage;
    try {
      APIDataService dataService = GTVDataService.getService();
      subscriptionWrapper = dataService.showPopupService(
        currentProductEid,
        currencyType,
        preserveAgreement
      );
    } catch (Exception e) {
      emessage = string.valueof(e.getmessage());
      if (
        emessage.contains(
          'Web service callout failed: WebService returned a SOAP Fault:'
        )
      ) {
        emessage = emessage.substringBetween(
          'Web service callout failed: WebService returned a SOAP Fault:',
          ' faultcode=soap:Server faultactor='
        );
      }
      subscriptionWrapper.errorMessage = emessage;
      return subscriptionWrapper;
    }
    return subscriptionWrapper;
  }
  /*
   * @param ChangeSubscriptionWrapper;
   * Get the Agreement and Pricing Configuration details for the service selected from the dropdows while changing existing service
   * If it requires an agreement, then get the Agreement list and Renew action list and show on the page
   */
  @AuraEnabled
  public static ChangeSubscriptionWrapper getAgreementAndPriceConfigurationForChangedService(
    String changeServiceinfoString,
    String currencyType
  ) {
    ChangeSubscriptionWrapper changeServiceinfo = (ChangeSubscriptionWrapper) JSON.deserialize(
      changeServiceinfoString,
      ChangeSubscriptionWrapper.class
    );
    list<SelectOption> recurringPriceListForChangedService = new List<SelectOption>();
    list<SelectOption> agreementListforChangedService;
    list<SelectOption> renewActionListForChangedServiceAgreement;
    Map<String, String> productPriceIdToEidMap = new Map<String, String>();
    Boolean changedServiceSupportsPriceOverride;
    Boolean changedServiceHasAgreement;
    Decimal recurringPriceForChangedService = null;
    Integer qtyOfChangedService = 1;
    String changedServiceEid;
    ChangeSubscriptionWrapper wrapperObj = new ChangeSubscriptionWrapper();
    if (null != changeServiceinfo.subscriptionId) {
      // Query the Service from Salesforce. Save it in a list so that if the SOQL doesn't returns anything, no exception occurs
      List<Product2> newServices;
      if (
        TRACTAPIUtil.checkFieldLevelSecurity(
          'Product2',
          'id, eid__c,Requires_Agreement__c, Agreement_Information__c,Serialized__c',
          'Query'
        )
      )
        newServices = [
          SELECT
            id,
            eid__c,
            Requires_Agreement__c,
            Serialized__c,
            Agreement_Information__c
          FROM Product2
          WHERE id = :changeServiceinfo.subscriptionId
        ];
      if (newServices.size() > 0) {
        changedServiceEid = newServices[0].eid__c;
        // Show price configuration panel
        canUpdateQty = !newServices[0].Serialized__c;
        if (
          null !=
          changeServiceinfo.productIdToProductPriceMap.get(
            changeServiceinfo.subscriptionId
          )
        ) {
          for (
            ProductPriceWrapper prodPriceObj : changeServiceinfo.productIdToProductPriceMap.get(
              changeServiceinfo.subscriptionId
            )
          ) {
            if (prodPriceObj.priceType == 'Recurring') {
              // Check if the changed service supports price overriding
              changedServiceSupportsPriceOverride = prodPriceObj.priceOverride;
              // Check if thru date is null or greater than today
              if (
                prodPriceObj.thruDate == null ||
                (prodPriceObj.thruDate != null &&
                Date.Today() <
                Date.newinstance(
                  prodPriceObj.thruDate.year(),
                  prodPriceObj.thruDate.month(),
                  prodPriceObj.thruDate.day()
                ))
              ) {
                // prepare the list of Product price recurrence periods to be shown on price configuration panel
                recurringPriceListForChangedService.add(
                  new SelectOption(
                    prodPriceObj.eid,
                    String.valueOf(prodPriceObj.recurrencePeriod)
                  )
                );
                // Map to get Product price id corresponding to the selected Product price recurrence period
                productPriceIdToEidMap.put(prodPriceObj.eid, prodPriceObj.eid);
              }
              if (
                null !=
                changeServiceinfo.productPriceIdtoPriceRangesMap.get(
                  prodPriceObj.eId
                ) &&
                changeServiceinfo.productPriceIdtoPriceRangesMap.get(
                    prodPriceObj.eId
                  )
                  .size() > 0
              ) {
                for (
                  ProductPriceRangeWrapper priceRangeObj : changeServiceinfo.productPriceIdtoPriceRangesMap.get(
                    prodPriceObj.eId
                  )
                ) {
                  if (recurringPriceForChangedService == null) {
                    recurringPriceForChangedService = priceRangeObj.price;
                  }
                  // This map will be used to get price value corresponding to the selected recurring price id
                  productPriceIdToPriceValueMap.put(
                    prodPriceObj.eid,
                    priceRangeObj.price
                  );
                }
              }
            }
          }
        }

        agreementListforChangedService = new List<SelectOption>();
        Decimal changedServiceDecimalEid = Decimal.valueOf(changedServiceEid);
        renewActionListForChangedServiceAgreement = new List<SelectOption>();
        list<ProductAgreementWrapper> agreementList = (list<ProductAgreementWrapper>) JSON.deserialize(
          newServices[0].Agreement_Information__c,
          list<ProductAgreementWrapper>.class
        );
        if (null != agreementList && !agreementList.isEmpty()) {
          // Show the picklist to choose agreement and renew action
          if (!newServices[0].Requires_Agreement__c) {
            agreementListforChangedService.add(
              new SelectOption('', '--None--')
            );
          }
          changedServiceHasAgreement = true;
          for (ProductAgreementWrapper ag : agreementList) {
            if (ag.currencyType == currencyType) {
              agreementListforChangedService.add(
                new SelectOption(ag.eid, ag.name)
              );
              mapOfAgreementPeriod.put(ag.eid, ag.agreementPeriod);
            }
          }
        } else {
          // The service does not have agreements, dont show the picklists to select agreement and agreement renew action
          changedServiceHasAgreement = false;
        }
        // Get agreement renew actions and add it to picklist to be shown on page
        for (
          TractSFDC_Util.AgreementEndAction endAction : TractSFDC_Util.AgreementEndAction.values()
        ) {
          renewActionListForChangedServiceAgreement.add(
            new SelectOption(
              endAction.name(),
              TractSFDC_Util.convertToCamelCase(endAction.name(), '_')
            )
          );
        }
      }
    }
    wrapperObj.recurringPriceList = recurringPriceListForChangedService;
    wrapperObj.productPriceIdToPriceValueMap = productPriceIdToPriceValueMap;
    wrapperObj.recurringPrice = recurringPriceForChangedService;
    wrapperObj.serviceHasAgreement = changedServiceHasAgreement;
    wrapperObj.agreementList = agreementListforChangedService;
    wrapperObj.renewActionList = renewActionListForChangedServiceAgreement;
    wrapperObj.enablePreserveAgreement = enablePreserveAgreement;
    wrapperObj.supportsPriceOverride = changedServiceSupportsPriceOverride;
    wrapperObj.canUpdateQty = canUpdateQty;
    wrapperObj.quantity = qtyOfChangedService;
    wrapperObj.changedServiceEid = changedServiceEid;
    wrapperObj.productPriceIdToEidMap = productPriceIdToEidMap;
    wrapperObj.mapOfAgreementPeriod = mapOfAgreementPeriod;
    return wrapperObj;
  }
  /**
   * @param newSubscriptionId, Id of the new subcsciption
   * @param effectiveDateValue, effective date of the new subscription
   * @param currentServiceEid, Id of the current service
   * @param account, current account
   * @param payonPurchaseValue, Checkbbox which is either true or false
   * @param mapOfAgreementPeriod, Agreement Id vs Agreement Period map
   * @param productPriceIdToEidMap, product Price Id to EId map
   * @param qtyOfChangedService, Change service Quantity
   * @param agreementRenewActionForChangedService, Agreement's Renew Action of the Changed service
   * @param agreementEidForChangedService,  Agreement's Id of the Changed service
   * @param recurringPrice,Recurring Price
   * @param recurringPriceId, Recurring Price Id
   * @param priceOverridden, Price Overridden
   * @return String, Error Message, if any
   *
   * @description - This method is used to save the services the user has replaced the existing service with
   **/
  @AuraEnabled
  public static String saveChangeServicesOnApex(
    String newSubscriptionId,
    String effectiveDateValue,
    String currentServiceEid,
    Account account,
    Boolean payonPurchaseValue,
    Map<String, Decimal> mapOfAgreementPeriod,
    Map<String, String> productPriceIdToEidMap,
    Integer qtyOfChangedService,
    String agreementRenewActionForChangedService,
    String agreementEidForChangedService,
    Decimal recurringPrice,
    String recurringPriceId,
    String priceOverridden
  ) {
    String emessage = 'NoError';
    list<Account> accList = new List<Account>();
    accList.add(account);
    try {
      APIDataService dataService = GTVDataService.getService();
      dataService.saveChangeServicesOnApex(
        newSubscriptionId,
        effectiveDateValue,
        currentServiceEid,
        accList,
        payonPurchaseValue,
        mapOfAgreementPeriod,
        productPriceIdToEidMap,
        qtyOfChangedService,
        agreementRenewActionForChangedService,
        agreementEidForChangedService,
        recurringPrice,
        recurringPriceId,
        priceOverridden
      );
    } catch (Exception e) {
      if (e.getmessage().contains('Web service callout failed')) {
        return e.getmessage()
          .substringBetween(
            'Web service callout failed: WebService returned a SOAP Fault:',
            ' faultcode=soap:Server faultactor='
          );
      } else {
        if (e.getmessage().contains('Validation error')) {
          return e.getmessage().substringAfter('Validation error:');
        }
      }
    }
    return emessage;
  }
  /**
   * @param currentServiceEid, Id of the current service
   * @param countryListValue, Country of the Current service
   * @param BillingCity, Billing City of the Current service
   * @param ShippingCountry,Shippng Country of the Current service
   * @param ShippingCity,Shippng City of the Current service
   * @param ShippingState,Shippng State of the Current service
   * @param ShippingPostalCode,Shippng Code of the Current service
   * @return String, Error Message, if any
   *
   * @description - This method is used to save the Address to the current Service
   **/
  @AuraEnabled
  public static String saveAddAddressTract(
    String currentServiceEid,
    String countryListValue,
    String billingCity,
    String shippingCountry,
    String shippingCity,
    String stateValue,
    String postalCode
  ) {
    String emessage = 'NoError';
    try {
      APIDataService dataService = GTVDataService.getService();
      dataService.saveAddAddressGTV(
        currentServiceEid,
        countryListValue,
        BillingCity,
        ShippingCountry,
        ShippingCity,
        stateValue,
        postalCode
      );
    } catch (Exception e) {
      emessage = string.valueof(e.getmessage());
      if (e.getmessage().contains('Web service callout failed')) {
        emessage = e.getmessage()
          .substringBetween(
            'Web service callout failed: WebService returned a SOAP Fault:',
            ' faultcode=soap:Server faultactor='
          );
      } else if (e.getmessage().contains('Validation error')) {
        return e.getmessage().substringAfter('Validation error:');
      }
    }
    return emessage;
  }
  /*
   * @param activityProductEid, Charge Rule Eid
   * @return  List<ProductUsesWrapper> , All the usage rule applicable to this product
   * @description - This method is used to show the Activity charge rulke for a particular service/product
   **/
  @AuraEnabled
  public static List<ProductUsesWrapper> showActivityChargeRule(
    String activityProductEid
  ) {
    List<ProductUsesWrapper> ruleOverrides = new List<ProductUsesWrapper>();
    APIDataService dataService = GTVDataService.getService();
    ruleOverrides = dataService.showUsageRule(activityProductEid);
    return ruleOverrides;
  }

  /*
   * @param serviceWrapperString,ProductServiceWrapper json String
   * @return  String, error Message, if any
   * @description - This method is used to create a new Activity charge rulke for a particular service/product
   **/
  @AuraEnabled
  public static String createNewActivityChargeRule(
    string serviceWrapperString
  ) {
    String emessage = 'NoError';
    ProductServiceWrapper serviceWrapper = (ProductServiceWrapper) JSON.deserialize(
      serviceWrapperString,
      ProductServiceWrapper.class
    );

    // try{
    APIDataService dataService = GTVDataService.getService();
    dataService.createNewActivityChargeRule(serviceWrapper);

    //}
    //catch(Exception e){
    // emessage = string.valueof(e.getmessage()+e.getLineNumber());
    // emessage = emessage.substringBetween('Web service callout failed: WebService returned a SOAP Fault:',' faultcode=soap:Server faultactor=');
    // }

    return emessage;
  }
  /*
   * @return  List<SelectOption>, Reasons id vs Name options
   * @description - This method is used to store the adjustment reason and show them on UI
   **/
  @AuraEnabled
  public static List<SelectOption> showDebitAdjustment() {
    list<SelectOption> adjustmentReasonList = new List<SelectOption>();
    APIDataService dataService = GTVDataService.getService();
    adjustmentReasonList = dataService.showDebitAdjustment();
    return adjustmentReasonList;
  }
  /*
   * @param accountId,Id of the current Acount
   * @param adjustmentReasonEid,Reason Id
   * @param ammount,adjustment amount
   *   @param description,adjustment reason
   *   @param effectiveDate,date of the adjustment
   * @return  String, error is any
   *
   * @description - This method is used to save the debit adjustments based on what user has entered on UI
   **/
  @AuraEnabled
  public static String saveDebitAdjustmentTract(
    String accountId,
    string adjustmentReasonEid,
    String ammount,
    String description,
    String effectiveDate
  ) {
    String emessage = 'NoError';
    try {
      boolean isCredit = false;
      boolean manualInvoice = false;
      APIDataService dataService = GTVDataService.getService();
      dataService.saveAdjustmentGTV(
        accountId,
        adjustmentReasonEid,
        ammount,
        description,
        effectiveDate,
        manualInvoice,
        isCredit
      );
    } catch (Exception e) {
      if (e.getmessage().contains('Web service callout failed')) {
        return e.getmessage()
          .substringBetween(
            'Web service callout failed: WebService returned a SOAP Fault:',
            ' faultcode=soap:Server faultactor='
          );
      } else if (e.getmessage().contains('ExecutionException:')) {
        return e.getmessage().substringAfter('ExecutionException:');
      } else {
        if (e.getmessage().contains('Validation error')) {
          return e.getmessage().substringAfter('Validation error:');
        } else {
          return e.getmessage();
        }
      }
    }
    return emessage;
  }
  /*
   * @return  List<SelectOption>, Reasons id vs Name options
   * @description - This method is used to store the adjustment reason and show them on UI
   **/
  @AuraEnabled
  public static List<SelectOption> showCreditAdjustment() {
    List<SelectOption> adjustmentReasonList = new List<SelectOption>();
    APIDataService dataService = GTVDataService.getService();
    adjustmentReasonList = dataService.showCreditAdjustment();
    return adjustmentReasonList;
  }
  /*
   * @param accountId,Id of the current Acount
   * @param adjustmentReasonEid,Reason Id
   * @param ammount,adjustment amount
   * @param description,adjustment reason
   * @param effectiveDate,date of the adjustment
   * @return  String, error is any
   * @description - This method is used to save the debit adjustments based on what user has entered on UI
   **/
  @AuraEnabled
  public static String saveCreditAdjustmentTract(
    String accountId,
    string adjustmentReasonEid,
    String ammount,
    String description,
    String effectiveDate,
    boolean manualInvoice
  ) {
    String emessage = 'NoError';
    try {
      boolean isCredit = true;
      APIDataService dataService = GTVDataService.getService();
      dataService.saveAdjustmentGTV(
        accountId,
        adjustmentReasonEid,
        ammount,
        description,
        effectiveDate,
        manualInvoice,
        isCredit
      );
    } catch (Exception e) {
      if (e.getmessage().contains('Web service callout failed')) {
        return e.getmessage()
          .substringBetween(
            'Web service callout failed: WebService returned a SOAP Fault:',
            ' faultcode=soap:Server faultactor='
          );
      } else {
        if (e.getmessage().contains('Validation error')) {
          return e.getmessage().substringAfter('Validation error:');
        } else {
          return e.getmessage();
        }
      }
    }
    return emessage;
  }
  /*
   * @param serviceEidValue,resume services Eid
   * @return  String, error is any
   * @description - This method is used to resume services
   **/
  @AuraEnabled
  public static String resumeServiceTract(String serviceEidValue) {
    String emessage = 'NoError';
    try {
      APIDataService dataService = GTVDataService.getService();
      dataService.resumeServiceGTV(serviceEidValue);
    } catch (Exception e) {
      if (e.getmessage().contains('Web service callout failed')) {
        return e.getmessage()
          .substringBetween(
            'Web service callout failed: WebService returned a SOAP Fault:',
            ' faultcode=soap:Server faultactor='
          );
      } else {
        if (e.getmessage().contains('Validation error')) {
          return e.getmessage().substringAfter('Validation error:');
        }
      }
    }

    return emessage;
  }
  /*
   * @param serviceEidValue,resume services Eid
   * @return  String, error is any
   * @description - This method is used to convert services
   **/
  @AuraEnabled
  public static String convertServiceTract(String serviceEidValue) {
    String emessage = 'NoError';
    try {
      APIDataService dataService = GTVDataService.getService();
      dataService.convertServiceGTV(serviceEidValue);
    } catch (Exception e) {
      if (e.getmessage().contains('Web service callout failed')) {
        return e.getmessage()
          .substringBetween(
            'Web service callout failed: WebService returned a SOAP Fault:',
            ' faultcode=soap:Server faultactor='
          );
      } else {
        if (e.getmessage().contains('Validation error')) {
          return e.getmessage().substringAfter('Validation error:');
        }
      }
    }
    return emessage;
  }
  /*
   * @return  Boolean, true or false
   * @description - This method is used to show update Quantity component
   **/
  @AuraEnabled
  public static Boolean showUpdateQuantity() {
    Boolean displayEffectiveDate = true;
    for (
      System_Setting__c systemsetting : System_Setting__c.getAll().values()
    ) {
      if (
        systemsetting.name == 'Display Effective Date' &&
        null != systemsetting.value__c
      ) {
        displayEffectiveDate = boolean.valueOf(systemsetting.value__c);
      }
    }

    return displayEffectiveDate;
  }
  /*
   * @param serviceEidValue, service whose quantity to update
   * @param newQuantity, new quantity value
   * @param displayEffectiveDate, true/false
   * @param effectiveDate, date when the changes are applied
   * @return  String, errorMessage if any
   * @description - This method is used to update Quantity of a service
   **/
  @AuraEnabled
  public static String UpdateQuantityInTract(
    String serviceEidValue,
    String newQuantity,
    Boolean displayEffectiveDate,
    String effectiveDate
  ) {
    String emessage = 'NoError';
    Decimal updateserviceQuantity;
    updateserviceQuantity = Decimal.valueOf(newQuantity);
    try {
      APIDataService dataService = GTVDataService.getService();
      dataService.updateQuantityInGTV(
        updateserviceQuantity,
        serviceEidValue,
        displayEffectiveDate,
        effectiveDate
      );
    } catch (Exception e) {
      if (e.getmessage().contains('Web service callout failed')) {
        return e.getmessage()
          .substringBetween(
            'Web service callout failed: WebService returned a SOAP Fault:',
            ' faultcode=soap:Server faultactor='
          );
      } else if (e.getmessage().contains('Validation error')) {
        return e.getmessage().substringAfter('Validation error:');
      } else {
        return e.getmessage();
      }
    }

    return emessage;
  }
  /*
   * @param tract, APi version
   * @param activityProductEid, Id of the service
   * @param deletedUsageEid,Id of the deleted usage
   * @param activityRuleName, rule name
   * @return  String, errorMessage if any
   * @description - This method is used to delete usage rule of a service
   **/
  @AuraEnabled
  public static String deleteActivityChargeRule(
    TRACT_Setup__c tract,
    String activityProductEid,
    String deletedUsageEid,
    String activityRuleName
  ) {
    String emessage = 'NoError';
    try {
      APIDataService dataService = GTVDataService.getService();
      dataService.deleteActivityChargeRule(
        activityProductEid,
        deletedUsageEid,
        activityRuleName
      );
    } catch (Exception e) {
      if (e.getmessage().contains('Web service callout failed')) {
        return e.getmessage()
          .substringBetween(
            'Web service callout failed: WebService returned a SOAP Fault:',
            ' faultcode=soap:Server faultactor='
          );
      } else {
        if (e.getmessage().contains('Validation error')) {
          return e.getmessage().substringAfter('Validation error:');
        }
      }
    }
    return emessage;
  }
  /*
   * @param accountId, accoint Id
   * @param downloadURL, invoice generating URL
   * @return  String,URL of the link
   * @description - This method is used to download the Invoice
   **/
  @AuraEnabled
  public static String pdfDownload(String accountId, String downloadURL) {
    String windowOpenUrl;
    String invoiceNumber;
    String invoiceName;

    TRACT_Setup__c tract = [
      SELECT
        id,
        TPassword__c,
        Tract_User_Name__c,
        TRACT_URL__c,
        X_API_Key__c,
        TRACT_URL2_0__c,
        Active__c,
        Api_Version__c
      FROM TRACT_Setup__c
      WHERE Active__c = TRUE
      LIMIT 1
    ];
    if (tract.Api_Version__c == 'API Version 1.0') {
      invoiceNumber = downloadURL.substring(
        downloadURL.indexOf('invoices') + 9,
        downloadURL.indexOf('/p')
      );
      invoiceName = invoiceNumber + '.pdf';
    } else {
      invoiceNumber = downloadURL.substring(
        downloadURL.indexOf('invoices') + 9,
        downloadURL.indexOf('/d')
      );
      invoiceName = invoiceNumber + '.pdf';
    }

    Account thisAccount = [
      SELECT
        Id,
        Name,
        BillingStreet,
        BillingCity,
        BillingPostalCode,
        BillingState,
        NumberOfEmployees,
        BillingCountry,
        ShippingStreet,
        ShippingCity,
        ShippingPostalCode,
        ShippingState,
        ShippingCountry,
        Phone,
        Tract_Billing_Account__c,
        Email__c
      FROM Account
      WHERE id = :accountId
      LIMIT 1
    ];
    set<string> setOfAttachNames = new Set<string>();

    for (Attachment attc : [
      SELECT name, id, ParentId
      FROM Attachment
      WHERE ParentId = :thisAccount.Id
      LIMIT 50000
    ]) {
      setOfAttachNames.add(attc.name);
    }

    if (
      (tract.Api_Version__c == 'API Version 1.0' &&
      tract.Tract_User_Name__c != null &&
      tract.TPassword__c != null &&
      !setOfAttachNames.contains(invoiceName) &&
      invoiceNumber != null) || test.isrunningtest()
    ) {
      HttpRequest req = new HttpRequest();
      req.setEndpoint(downloadURL);
      String username = tract.Tract_User_Name__c;
      String password = tract.TPassword__c;
      Blob headerValue = Blob.valueOf(username + ':' + password);
      String authorizationHeader =
        'Basic ' + EncodingUtil.base64Encode(headerValue);
      req.setHeader('Authorization', authorizationHeader);
      //req.setHeader('Content-Type', 'application/pdf');
      req.setMethod('GET');

      Http http = new Http();
      if (!Test.isRunningTest()) {
        HTTPResponse res = http.send(req);
        Attachment outputFile = new Attachment();
        outputFile.parentId = thisAccount.Id;
        outputFile.name = invoiceNumber + '.pdf';
        outputFile.Body = res.getBodyAsBlob();

        insert outputFile;
        //PageReference page = new PageReference('/servlet/servlet.FileDownload?file=' + outputFile.Id);
        windowOpenUrl = '/servlet/servlet.FileDownload?file=' + outputFile.Id;
        //return null;
      }
    } else if (
      tract.Api_Version__c == 'API Version 2.0' &&
      tract.X_API_Key__c != null
    ) {
      APIDataService dataService = GTVDataService.getService();
      Blob pdfContent = dataService.downloadInvoices(invoiceNumber);
      Attachment outputFile = new Attachment();
      outputFile.parentId = thisAccount.Id;
      outputFile.name = invoiceNumber + '.pdf';
      outputFile.ContentType = 'application/pdf';
      outputFile.Body = (pdfContent);
      insert outputFile;
      windowOpenUrl = '/servlet/servlet.FileDownload?file=' + outputFile.Id;
    } else {
      list<Attachment> attc = new List<Attachment>(
        [
          SELECT name, id, ParentId
          FROM Attachment
          WHERE ParentId = :thisAccount.Id AND name = :invoiceName
          LIMIT 50000
        ]
      );

      if (!attc.isEmpty()) {
        //PageReference page = new PageReference('/servlet/servlet.FileDownload?file=' + attc[0].Id);

        windowOpenUrl = '/servlet/servlet.FileDownload?file=' + attc[0].Id;
      }
    }
    return windowOpenUrl;
  }
  /*
   * @param customFildWrapper, wrapper containing account custom fields details
   * @param accountString, account details
   * @return  String,error message if any
   * @description - This method is used to save the account custom fields configured by the user on UI
   **/
  @AuraEnabled
  public static String saveAccountCustomField(
    String customFildWrapper,
    String accountString
  ) {
    String emessage;
    TRACTAccountWrapper tractBillingAccount = (TRACTAccountWrapper) JSON.deserialize(
      accountString,
      TRACTAccountWrapper.class
    );
    APIDataService dataService = GTVDataService.getService();
    try {
      emessage = dataService.saveAccountCustomField(
        tractBillingAccount,
        customFildWrapper
      );
    } catch (Exception ex) {
      if (
        ex.getmessage().contains('Web service callout failed') &&
        ex.getmessage().contains('Validation error')
      ) {
        return ex.getmessage()
          .substringBetween(
            'Validation error:',
            ' faultcode=soap:Server faultactor='
          );
      } else if (ex.getmessage().contains('Validation error')) {
        return ex.getmessage().substringAfter('Validation error:');
      } else {
        emessage = ex.getmessage();
      }
    }
    return emessage;
  }

  /*
   * @return  List<SelectOption>, get Service deactivate reasons
   * @description - This method is used to get the deactivate reasons
   **/
  public static List<SelectOption> getServiceReason() {
    List<SelectOption> reasonList = new List<SelectOption>();
    APIDataService dataService = GTVDataService.getService();
    reasonList = dataService.getDeactivateReasons();
    return reasonList;
  }
  /*
   * @return  List<SelectOption>, get Service suspend reasons
   * @description - This method is used to get the suspend reasons
   **/
  public static List<SelectOption> getSuspendServiceReason() {
    List<SelectOption> reasonList = new List<SelectOption>();
    APIDataService dataService = GTVDataService.getService();
    reasonList = dataService.getSuspendReasons();
    return reasonList;
  }
  /*
   * @return  List<SelectOption>, map Formula UsageRule Specification List
   * @description - This method is used to get the Formula UsageRule Specification List
   **/
  public static list<SelectOption> getFormulaUsageRuleSpecificationListMethod() {
    list<SelectOption> FormulaUsageRuleSpecificationList = new List<SelectOption>();
    APIDataService dataService = GTVDataService.getService();
    FormulaUsageRuleSpecificationList = dataService.getFormulaUsageRuleSpecificationListMethod();
    return FormulaUsageRuleSpecificationList;
  }
  /*
   * @return  List<SelectOption>, map Charge Lists
   * @description - This method is used to get the Charge List
   **/
  public static list<SelectOption> getchargeListBytesMethod() {
    list<SelectOption> chargeListBytes = new List<SelectOption>();
    APIDataService dataService = GTVDataService.getService();
    chargeListBytes = dataService.getchargeListBytesMethod();

    return chargeListBytes;
  }
  /*
   * @return  List<SelectOption>, map Charge Category Lists
   * @description - This method is used to get the Charge Category List
   **/
  public static list<selectOption> getchargeCategoryListMethod() {
    list<SelectOption> chargeCategoryList = new List<SelectOption>();
    APIDataService dataService = GTVDataService.getService();
    chargeCategoryList = dataService.getchargeCategoryListMethod();
    return chargeCategoryList;
  }
  /*
   * @param  contactId, id the the given Contact
   * @return String, errorMessage if any
   * @description - This method is used to get the Contact details
   **/
  @AuraEnabled
  public static String getContactDetail(String contactId) {
    String error = '';
    Contact currentContact = [
      SELECT
        id,
        Name,
        accountId,
        Tract_Contact_Eid__c,
        MailingPostalCode,
        MailingStreet,
        LastName,
        FirstName,
        Phone,
        MobilePhone,
        Email,
        MailingCity,
        MailingState,
        MailingCountry,
        otherPostalCode,
        otherCity,
        otherState,
        otherCountry,
        otherStreet,
        Shipping_Zip_Postal_Code__c,
        Shipping_City__c,
        Shipping_State_Province__c,
        Shipping_Street__c,
        Shipping_Country__c
      FROM contact
      WHERE id = :contactId
      LIMIT 1
    ];
    if (currentContact.accountId == null) {
      error = 'Parent Account does not exist.';
      return error;
    }
    Account accountNumber = [
      SELECT id, name, Tract_Billing_Account__c
      FROM Account
      WHERE id = :currentContact.accountId
      LIMIT 1
    ];
    if (
      accountNumber.Tract_Billing_Account__c == null ||
      accountNumber.Tract_Billing_Account__c == ''
    ) {
      error = 'Parent Account does not exist.';
      return error;
    }
    if (
      currentContact.Tract_Contact_Eid__c != null &&
      currentContact.Tract_Contact_Eid__c != ''
    ) {
      error = 'This contact has been already moved in TRACT.';
      return error;
    }
    return error;
  }

  /*
   * @param  pageNumber, Page Number of the records
   * @param accountString, account details JSON String
   * @return TRACTPaymentMethodWrapper, payment Methods wrapper records
   * @description - This method is used to get the Payment records
   **/
  @AuraEnabled(cacheable=true)
  public static TRACTPaymentMethodWrapper paymentRecords(
    String accountString,
    Integer pageNumber
  ) {
    TRACTAccountWrapper tractBillingAccount = (TRACTAccountWrapper) JSON.deserialize(
      accountString,
      TRACTAccountWrapper.class
    );
    TRACTPaymentMethodWrapper paymentMethodWrap = new TRACTPaymentMethodWrapper();
    APIDataService dataService = GTVDataService.getService();
    paymentMethodWrap = dataService.getPaymentMethods(
      tractBillingAccount,
      pageNumber
    );
    return paymentMethodWrap;
  }
  /*
   * @param  pageNumber, Page Number of the records
   * @param accountString, account details JSON String
   * @return TRACTNoteWrapper, notes records
   * @description - This method is used to get the notes records for a particular billing account
   **/
  @AuraEnabled(cacheable=true)
  public static TRACTNoteWrapper Notes(
    String accountString,
    Integer pageNumber
  ) {
    TRACTAccountWrapper tractBillingAccount = (TRACTAccountWrapper) JSON.deserialize(
      accountString,
      TRACTAccountWrapper.class
    );
    TRACTNoteWrapper notesWrap = new TRACTNoteWrapper();
    APIDataService dataService = GTVDataService.getService();
    notesWrap = dataService.getNotes(tractBillingAccount, pageNumber);
    return notesWrap;
  }
  /*
   * @param  pageNumber, Page Number of the records
   * @param accountString, account details JSON String
   * @return TRACTContactWrapper, contacts records
   * @description - This method is used to get the contact records for a particular billing account
   **/
  @AuraEnabled(cacheable=true)
  public static TRACTContactWrapper contacts(
    String accountString,
    Integer pageNumber
  ) {
    TRACTAccountWrapper tractBillingAccount = (TRACTAccountWrapper) JSON.deserialize(
      accountString,
      TRACTAccountWrapper.class
    );
    TRACTContactWrapper contactsWrap = new TRACTContactWrapper();
    APIDataService dataService = GTVDataService.getService();
    contactsWrap = dataService.getContacts(tractBillingAccount, pageNumber);
    return contactsWrap;
  }
  /*
   * @param stringToDeserialize, Product Service wrapper String
   * @return ProductServiceWrapper, Product Service wrapper
   * @description - This method is used to deserealize a JSOn string to object
   **/
  @AuraEnabled
  public static ProductServiceWrapper deserializeProductServiceWrapper(
    String stringToDeserialize
  ) {
    ProductServiceWrapper wrapperObj = (ProductServiceWrapper) JSON.deserialize(
      stringToDeserialize,
      ProductServiceWrapper.class
    );
    return wrapperObj;
  }

  /*
   * @param accountId, account id
   * @return list<AccountCustomFieldValueWrapper>, account Custom fields parsed from GTV
   * @description - Used to Query Account Custom Fields From GTV
   *
   */
  @AuraEnabled(cacheable=true)
  public static list<AccountCustomFieldValueWrapper> getAccountCustomFieldValueList(
    String accountId
  ) {
    list<AccountCustomFieldValueWrapper> wrapList = new List<AccountCustomFieldValueWrapper>();
    APIDataService dataService = GTVDataService.getService();
    wrapList = dataService.getAccountCustomFieldValueList(accountId);
    return wrapList;
  }
  /*
   * @param accountId, account id
   * @return list<AccountCustomFieldValueWrapper>, account Custom fields parsed from GTV
   * @description - Used to Query Account Custom Fields From GTV
   **/
  @AuraEnabled
  public static list<AccountCustomFieldWrapper> getAccountCustomFieldsList(
    String accountString
  ) {
    list<AccountCustomFieldWrapper> wrapList = new List<AccountCustomFieldWrapper>();
    TRACTAccountWrapper tractBillingAccount = (TRACTAccountWrapper) JSON.deserialize(
      accountString,
      TRACTAccountWrapper.class
    );
    APIDataService dataService = GTVDataService.getService();
    wrapList = dataService.getAccountCustomFields(tractBillingAccount);
    return wrapList;
  }
  /*
   * @param accountString, account Json String
   * @return list<GTVOneTimeOrderItemWrapper>, GTvone time wrapper
   * @description - Query one time order Items from GTV
   **/
  @AuraEnabled(cacheable=true)
  public static List<GTVOneTimeOrderItemWrapper> getOneTimeOrderItemList(
    String accountString
  ) {
    List<GTVOneTimeOrderItemWrapper> oneTimeOrderItemWrapperList = new List<GTVOneTimeOrderItemWrapper>();
    TRACTAccountWrapper tractBillingAccount = (TRACTAccountWrapper) JSON.deserialize(
      accountString,
      TRACTAccountWrapper.class
    );
    APIDataService dataService = GTVDataService.getService();
    oneTimeOrderItemWrapperList = dataService.getOneTimeOrderItemList(
      tractBillingAccount
    );
    return oneTimeOrderItemWrapperList;
  }
  /*
   *@param accountEditWrap, account Json String
   * @return void
   * @description - used to save the accounts custom fields configured by the user
   **/
  @AuraEnabled
  public static void saveAccountDetails(
    String accountId,
    String accountEditWrap
  ) {
    AccountEditWrapper gtvAccountEdit = (AccountEditWrapper) JSON.deserialize(
      accountEditWrap,
      AccountEditWrapper.class
    );
    Account acc = new Account(Id = accountId);
    acc.Account_Create_Date__c = gtvAccountEdit.createDate;
    acc.Tax_Exempt__c = gtvAccountEdit.taxExempt;
    acc.Currency_Type__c = gtvAccountEdit.selectedCurrency;
    acc.Gotransverse_Bill_Type__c = gtvAccountEdit.billType;
    acc.Email__c = gtvAccountEdit.email;
    list<TRACTBillingAccountCategory__c> billingAccountCategory = [
      SELECT Id, eid__c, description__c, type_x__c, status__c
      FROM TRACTBillingAccountCategory__c
      WHERE eid__c = :gtvAccountEdit.accountCategory
      LIMIT 1
    ];
    if (!billingAccountCategory.isEmpty()) {
      acc.GTV_Account_Category__c = billingAccountCategory[0].type_x__c;
    }
    list<TRACT_Bill_Cycle__c> billCycle = [
      SELECT
        id,
        Name,
        Billing_Account_Category_Eid__c,
        TRACT_Bill_Cycle_Currency_Type__c,
        Bill_Cycle_Type__c
      FROM TRACT_Bill_Cycle__c
      WHERE Name = :gtvAccountEdit.billCycleName
      LIMIT 1
    ];

    if (!billCycle.isEmpty()) {
      acc.GTV_Bill_Cycle__c = billCycle[0].Name;
    }
    list<Payment_Term__c> paymentTerm = [
      SELECT id, Name
      FROM Payment_Term__c
      WHERE Name = :gtvAccountEdit.paymentTerm
      LIMIT 1
    ];
    if (!paymentTerm.isEmpty()) {
      acc.GTV_Payment_Term__c = paymentTerm[0].Name;
    }
    update acc;
  }

  /*
   *@param accountId, Account Id
   * @return AccountEditWrapper, account related information
   * @description - used to get the accounts details
   **/
  @AuraEnabled
  public static AccountEditWrapper getAccountEntityData(String accountId) {
    AccountEditWrapper editWrapper = new AccountEditWrapper();
    list<SelectOption> SelectOptionList;
    APIDataService dataService = GTVDataService.getService();
    editWrapper.currencyType = dataService.getCurrencyType();
    Account acc = [
      SELECT
        id,
        Name,
        Tract_Billing_Account__c,
        Currency_Type__c,
        Account_Create_Date__c,
        GTV_Account_Category__c,
        Tax_Exempt__c,
        GTV_Bill_Cycle__c,
        GTV_Payment_Term__c,
        Email__c,
        Gotransverse_Bill_Type__c
      FROM Account
      WHERE id = :accountId
      LIMIT 1
    ];
    editWrapper.billCycleName = acc.GTV_Bill_Cycle__c;
    editWrapper.paymentTerm = acc.GTV_Payment_Term__c;
    editWrapper.billType = acc.Gotransverse_Bill_Type__c;
    editWrapper.email = acc.Email__c;
    if (acc.Currency_Type__c != null) {
      editWrapper.selectedCurrency = acc.Currency_Type__c;
    }
    editWrapper.taxExempt = acc.Tax_Exempt__c;
    editWrapper.createDate = acc.Account_Create_Date__c;
    list<Payment_Term__c> paymentTermList = [
      SELECT id, Name
      FROM TRACT3__Payment_Term__c
      ORDER BY Name ASC
    ];
    if (!paymentTermList.isEmpty()) {
      SelectOptionList = new List<SelectOption>();
      SelectOptionList.add(new SelectOption('', '--None--'));
      for (Payment_Term__c term : paymentTermList) {
        SelectOptionList.add(new SelectOption(term.Name, term.Name));
      }
    }
    editWrapper.paymentTermList = SelectOptionList;

    list<TRACTBillingAccountCategory__c> billingAccountCategoryList = [
      SELECT Id, eid__c, description__c, type_x__c, status__c
      FROM TRACTBillingAccountCategory__c
      ORDER BY type_x__c ASC
    ];
    if (!billingAccountCategoryList.isEmpty()) {
      SelectOptionList = new List<SelectOption>();
      SelectOptionList.add(new SelectOption('', 'Choose One'));
      for (
        TRACTBillingAccountCategory__c billingAccountCategory : billingAccountCategoryList
      ) {
        if (billingAccountCategory.type_x__c == acc.GTV_Account_Category__c) {
          editWrapper.accountCategory = billingAccountCategory.eid__c;
          editWrapper.accountCategoryName = billingAccountCategory.type_x__c;
        }
        SelectOptionList.add(
          new SelectOption(
            billingAccountCategory.eid__c,
            billingAccountCategory.type_x__c
          )
        );
      }
    }
    editWrapper.accountCategoryList = SelectOptionList;

    if (RestAPI2Domain.GTVAPIBillType.values() != null) {
      editWrapper.billTypeList = new List<SelectOption>();
      for (
        RestAPI2Domain.GTVAPIBillType billType : RestAPI2Domain.GTVAPIBillType.values()
      ) {
        editWrapper.billTypeList.add(
          new SelectOption(
            billType.name(),
            TractSFDC_Util.convertToCamelCase(billType.name(), '_')
          )
        );
      }
    }
    return editWrapper;
  }

  /*
   * @param currencyType, currency type
   * @param accountCategoryEid, Account Category selected by the user
   * @return list<SelectOption>, get bill cycles for a particular category
   * @description - used to get the bill cycles based on currency type and account categories selected by the user
   **/
  @AuraEnabled
  public static list<SelectOption> getBillCycleData(
    String currencyType,
    String accountCategoryEid
  ) {
    list<SelectOption> billCycleEidvsName = new List<SelectOption>();
    if (null != accountCategoryEid && accountCategoryEid != '') {
      list<TRACT_Bill_Cycle__c> billCycleList = [
        SELECT
          id,
          Name,
          Billing_Account_Category_Eid__c,
          TRACT_Bill_Cycle_Currency_Type__c,
          Bill_Cycle_Type__c
        FROM TRACT_Bill_Cycle__c
        WHERE
          (TRACT_Bill_Cycle_Currency_Type__c = :currencyType
          OR TRACT_Bill_Cycle_Currency_Type__c = NULL)
          AND (Billing_Account_Category_Eid__c = :accountCategoryEid
          OR Billing_Account_Category_Eid__c = NULL)
        ORDER BY Name ASC
      ];

      if (!billCycleList.isEmpty()) {
        for (TRACT_Bill_Cycle__c billCycle : billCycleList) {
          billCycleEidvsName.add(
            new SelectOption(billCycle.Name, billCycle.Name)
          );
        }
      }
    }
    return billCycleEidvsName;
  }
  /*
   * @param accountEid, account Id
   * @return list<TRACTAccountWrapper>, get child account details
   * @description - used to get the child of a given account
   **/
  @AuraEnabled
  public static list<TRACTAccountWrapper> getChildAccountDetails(
    String accountEid
  ) {
    list<TRACTAccountWrapper> childAccountList = new List<TRACTAccountWrapper>();
    APIDataService dataService = GTVDataService.getService();
    childAccountList = dataService.getChildDetails(accountEid);
    return childAccountList;
  }
  /*
   * @param responsibleAccountEid, account Id
   * @return BillingHierarchyWrapper, get billing hierarchy account details
   * @description - used to get the child of a given account
   **/
  @AuraEnabled
  public static BillingHierarchyWrapper getBillingHierarchy(
    String responsibleAccountEid
  ) {
    BillingHierarchyWrapper billingHierarchyWrap = new BillingHierarchyWrapper();
    APIDataService dataService = GTVDataService.getService();
    billingHierarchyWrap = dataService.queryBillingHierarchy(
      responsibleAccountEid
    );
    return billingHierarchyWrap;
  }
  @AuraEnabled
  public static string createPaymentMethod(
    String paymentData,
    String accountId
  ) {
    Map<String, Object> mapOfPaymentData = (Map<String, Object>) JSON.deserializeUntyped(
      paymentData
    );
    system.debug('mapOfPaymentData:::' + mapOfPaymentData);
    String paymentRefererToken;
    String paymentToken;
    String paymentResponse;

    try {
      APIDataService dataService = GTVDataService.getService();
      TRACTAccountWrapper accountWrap = dataService.getBillingAccount(
        accountId
      );
      paymentRefererToken = dataService.getPaymentRefererToken();
      mapOfPaymentData.put('token', paymentRefererToken);
      paymentToken = dataService.generatePaymentToken(mapOfPaymentData);
      paymentResponse = dataService.createRecurringPayment(
        paymentToken,
        accountWrap.eid,
        Boolean.valueOf(mapOfPaymentData.get('autoPayment'))
      );
      return 'NoError';
    } catch (Exception e) {
      if (
        e.getMessage() ==
        'Unable to tunnel through proxy. Proxy returns "HTTP/1.1 503 Service Unavailable"'
      ) {
        return 'Please configure the correct hosted payment URL on the billing tab';
      }
      return e.getMessage();
    }
  }
  @AuraEnabled
  public static GTVPaymentWrapper getPaymentMethodForPayment(String accountId) {
    Account acc = [
      SELECT
        id,
        Name,
        Tract_Billing_Account__c,
        Currency_Type__c,
        Account_Create_Date__c,
        GTV_Account_Category__c,
        Tax_Exempt__c,
        GTV_Bill_Cycle__c,
        GTV_Payment_Term__c,
        Email__c,
        Gotransverse_Bill_Type__c
      FROM Account
      WHERE id = :accountId
      LIMIT 1
    ];
    GTVPaymentWrapper paymentMethodWrap = new GTVPaymentWrapper();
    APIDataService dataService = GTVDataService.getService();
    paymentMethodWrap = dataService.getPaymentMethodAsSelectOption(
      acc.Tract_Billing_Account__c
    );
    return paymentMethodWrap;
  }
  @AuraEnabled
  public static String executePayment(String accountId, String paymentData) {
    Map<String, Object> mapOfPaymentData = (Map<String, Object>) JSON.deserializeUntyped(
      paymentData
    );
    try {
      APIDataService dataService = GTVDataService.getService();
      TRACTAccountWrapper accountWrap = dataService.getBillingAccount(
        accountId
      );
      if (accountWrap.eid != null) {
        dataService.createBillingPayment(mapOfPaymentData, accountWrap.eid);
      }
      return 'NoError';
    } catch (Exception e) {
      return e.getMessage();
    }
  }

  @AuraEnabled
  public static CreateChangeOrderWrapper getCreateChangeServiceWrapper(
    String currentServiceId,
    String currencyType
  ) {
    CreateChangeOrderWrapper changeOrderWrapper = new CreateChangeOrderWrapper();
    String emessage;
    try {
      GTVRESTDataService restDataService = new GTVRESTDataService();
      changeOrderWrapper = restDataService.getCreateChangeOrderWrapper(
        currentServiceId,
        currencyType
      );
    } catch (Exception e) {
      emessage = string.valueof(e.getMessage());
    }
    return changeOrderWrapper;
  }

  @AuraEnabled
  public static void createChangeOrderInGTV(String changeOrderString) {
    try {
      CreateChangeOrderWrapper changeOrderWrapper = (CreateChangeOrderWrapper) JSON.deserialize(
        changeOrderString,
        CreateChangeOrderWrapper.class
      );
      GTVRESTDataService restDataService = new GTVRESTDataService();
      restDataService.createChangeOrderInGTV(changeOrderWrapper);
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }

  @AuraEnabled
  public static List<SelectOption> getIdentifierList(
    String resourceCategoryID
  ) {
    try {
      List<SelectOption> identifierList = new List<SelectOption>();
      GTVRESTDataService restDataService = new GTVRESTDataService();
      identifierList = restDataService.getServiceResourceIdentifier(
        resourceCategoryID
      );
      return identifierList;
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }

  @AuraEnabled
  public static void createIdentifier(
    String identifier,
    String resourceCategoryId
  ) {
    try {
      GTVRESTDataService restDataService = new GTVRESTDataService();
      restDataService.createServiceResourceInGTV(
        identifier,
        resourceCategoryId
      );
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }

  //Wrapper Class To Show the Product uses Rule
  /*
    ChargeRulesWrapper class
    **/
  public class ChargeRulesWrapper {
    @AuraEnabled
    public list<SelectOption> selectStatusList1 { get; set; }
    @AuraEnabled
    public String selectStatusListValue { get; set; }
    @AuraEnabled
    public list<SelectOption> productUsageRuleList1 { get; set; }
    @AuraEnabled
    public String productUsageRuleListValue { get; set; }
    @AuraEnabled
    public list<SelectOption> rateTypeList1 { get; set; }
    @AuraEnabled
    public String rateTypeListValue { get; set; }
    @AuraEnabled
    public list<SelectOption> chargesPicklist1 { get; set; }
    @AuraEnabled
    public String chargesPicklistValue { get; set; }
    @AuraEnabled
    public String amountChargePickList { get; set; }
    @AuraEnabled
    public list<SelectOption> allowanceTypeList1 { get; set; }
    @AuraEnabled
    public String allowanceTypeListValue { get; set; }
    @AuraEnabled
    public list<SelectOption> roleOverList1 { get; set; }
    @AuraEnabled
    public String roleOverListValue { get; set; }
    @AuraEnabled
    public list<SelectOption> formulaField1 { get; set; }
    @AuraEnabled
    public String formulaFieldValue { get; set; }
    @AuraEnabled
    public list<SelectOption> operationList1 { get; set; }
    @AuraEnabled
    public String operationListValue { get; set; }
    @AuraEnabled
    public list<SelectOption> passThroughChargeList1 { get; set; }
    @AuraEnabled
    public String passThroughChargeListValue { get; set; }
    @AuraEnabled
    public list<SelectOption> formulaUsageRuleList { get; set; }
    @AuraEnabled
    public String formulaUsageRuleListValue { get; set; }
    @AuraEnabled
    public list<SelectOption> chargeListBytes { get; set; }
    @AuraEnabled
    public String chargeListBytesValue { get; set; }
    @AuraEnabled
    public list<SelectOption> chargeCategoryList { get; set; }
    @AuraEnabled
    public String chargeCategoryListValue { get; set; }
    @AuraEnabled
    public String serviceUsageRuleName { get; set; }
    @AuraEnabled
    public Decimal chargeValue { get; set; }
    @AuraEnabled
    public Double ammountValue { get; set; }
    @AuraEnabled
    public String activityFormulaValue { get; set; }
    @AuraEnabled
    public Boolean prorateOnOrder { get; set; }
    @AuraEnabled
    public Boolean prorateOnCancel { get; set; }
  }
}
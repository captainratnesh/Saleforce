import { LightningElement, track, api } from 'lwc';
import CreatePaymentController from "@salesforce/apex/AccountDetailController_LT.createPaymentMethod";
import paymentCardIcons from "@salesforce/resourceUrl/paymentCard";
export default class CreatePaymentComponent extends LightningElement {
    @api accountId;
    @track errorMessage = '';
    @track showErrorMessage = false;
    @track usselected = false;
    @track payment = {
        firstName: "",
        middleName: "",
        lastName: "",
        suffix: "",
        cardType: [],
        cardTypeSelect: "",
        cardNumber: "",
        cvv: "",
        expiryDate: "",
        email: "",
        street: '',
        city: '',
        state: '',
        country: '',
        postalCode: '',
        autoPayment:false,
        nickname:''
    };

    @track tempCardLeng = 0;

    chipIcon = paymentCardIcons + '/emv.png';
    visaIcon = paymentCardIcons + '/visa.png';
    aeIcon = paymentCardIcons + '/americanexpress.png';
    disIcon = paymentCardIcons + '/discover.png';
    mcIcon = paymentCardIcons + '/mastercard.png';

    selectedCountry = '';
    countryStateeMap = {
        US: [
            { label: 'ALABAMA', value: 'ALABAMA' },
            { label: 'ALASKA', value: 'ALASKA' },
            { label: 'ARIZONA', value: 'ARIZONA' },
            { label: 'ARKANSAS', value: 'ARKANSAS' },
            { label: 'ARMED FORCES AFRICA, CANADA, EUROPE, MIDDLE EAST', value: 'ARMED FORCES AFRICA, CANADA, EUROPE, MIDDLE EAST ' },
            { label: 'ARMED FORCES AMERICA', value: 'ARMED FORCES AMERICA' },
            { label: 'ARMED FORCES PACIFIC', value: 'ARMED FORCES PACIFIC' },
            { label: 'CALIFORNIA', value: 'CALIFORNIA' },
            { label: 'CONNECTICUT', value: 'CONNECTICUT' },
            { label: 'DISTRICT OF COLUMBIA', value: 'DISTRICT OF COLUMBIA' },
            { label: 'DELAWARE', value: 'DELAWARE' },
            { label: 'FLORIDA', value: 'FLORIDA' },
            { label: 'GEORGIA', value: 'GEORGIA' },
            { label: 'HAWAII', value: 'HAWAII' },
            { label: 'IDAHO', value: 'IDAHO' },
            { label: 'ILLINOIS', value: 'ILLINOIS' },
            { label: 'IOWA', value: 'IOWA' },
            { label: 'INDIANA', value: 'INDIANA' },
            { label: 'KANSAS', value: 'KANSAS' },
            { label: 'KENTUCKY', value: 'KENTUCKY' },
            { label: 'LOUISIANA', value: 'LOUISIANA' },
            { label: 'MAINE', value: 'MAINE' },
            { label: 'MANITOBA', value: 'MANITOBA' },
            { label: 'MARYLAND', value: 'MARYLAND' },
            { label: 'MASSACHUSETTS', value: 'MASSACHUSETTS' },
            { label: 'MICHIGAN', value: 'MICHIGAN' },
            { label: 'MINNESOTA', value: 'MINNESOTA' },
            { label: 'MISSISSIPPI', value: 'MISSISSIPPI' },
            { label: 'MISSOURI', value: 'MISSOURI' },
            { label: 'MONTANA', value: 'MONTANA' },
            { label: 'NEBRASKA', value: 'NEBRASKA' },
            { label: 'NEVADA', value: 'NEVADA' },
            { label: 'NEW HAMPSHIRE', value: 'NEW HAMPSHIRE' },
            { label: 'NEW JERSEY', value: 'NEW JERSEY' },
            { label: 'NEW MEXICO', value: 'NEW MEXICO' },
            { label: 'NEW YORK', value: 'NEW YORK' },
            { label: 'NORTH CAROLINA', value: 'NORTH CAROLINA' },
            { label: 'NORTH DAKOTA', value: 'NORTH DAKOTA' },
            { label: 'OHIO', value: 'OHIO' },
            { label: 'OKLAHOMA', value: 'OKLAHOMA' },
            { label: 'OREGON', value: 'OREGON' },
            { label: 'PENNSYLVANIA', value: 'PENNSYLVANIA' },
            { label: 'PUERTO RICO', value: 'PUERTO RICO' },
            { label: 'RHODE ISLAND', value: 'RHODE ISLAND' },
            { label: 'SOUTH CAROLINA', value: 'SOUTH CAROLINA' },
            { label: 'SOUTH DAKOTA', value: 'SOUTH DAKOTA' },
            { label: 'TENNESSEE', value: 'TENNESSEE' },
            { label: 'TEXAS', value: 'TEXAS' },
            { label: 'UTAH', value: 'UTAH' },
            { label: 'VERMONT', value: 'VERMONT' },
            { label: 'VIRGINIA', value: 'VIRGINIA' },
            { label: 'WASHINGTON', value: 'WASHINGTON' },
            { label: 'WEST VIRGINIA', value: 'WEST VIRGINIA' },
            { label: 'WISCONSIN', value: 'WISCONSIN' },
            { label: 'WYOMING', value: 'WYOMING' }
        ]
    };

    countryOptions = [
        {
            value: "",
            key: "none",
            label: "None"
        },
        {
            value: "United States",
            key: "US",
            label: "United States"
        },
        {
            value: "Afghanistan",
            key: "AF",
            label: "Afghanistan"
        },
        {
            value: "Åland Islands",
            key: "AX",
            label: "Åland Islands"
        },
        {
            value: "Albania",
            key: "AL",
            label: "Albania"
        },
        {
            value: "Algeria",
            key: "DZ",
            label: "Algeria"
        },
        {
            value: "American Samoa",
            key: "AS",
            label: "American Samoa"
        },
        {
            value: "Andorra",
            key: "AD",
            label: "Andorra"
        },
        {
            value: "Angola",
            key: "AO",
            label: "Angola"
        },
        {
            value: "Anguilla",
            key: "AI",
            label: "Anguilla"
        },
        {
            value: "Antarctica",
            key: "AQ",
            label: "Antarctica"
        },
        {
            value: "Antigua and Barbuda",
            key: "AG",
            label: "Antigua and Barbuda"
        },
        {
            value: "Argentina",
            key: "AR",
            label: "Argentina"
        },
        {
            value: "Armenia",
            key: "AM",
            label: "Armenia"
        },
        {
            value: "Aruba",
            key: "AW",
            label: "Aruba"
        },
        {
            value: "Australia",
            key: "AU",
            label: "Australia"
        },
        {
            value: "Austria",
            key: "AT",
            label: "Austria"
        },
        {
            value: "Azerbaijan",
            key: "AZ",
            label: "Azerbaijan"
        },
        {
            value: "Bahamas",
            key: "BS",
            label: "Bahamas"
        },
        {
            value: "Bahrain",
            key: "BH",
            label: "Bahrain"
        },
        {
            value: "Bangladesh",
            key: "BD",
            label: "Bangladesh"
        },
        {
            value: "Barbados",
            key: "BB",
            label: "Barbados"
        },
        {
            value: "Belarus",
            key: "BY",
            label: "Belarus"
        },
        {
            value: "Belgium",
            key: "BE",
            label: "Belgium"
        },
        {
            value: "Belize",
            key: "BZ",
            label: "Belize"
        },
        {
            value: "Benin",
            key: "BJ",
            label: "Benin"
        },
        {
            value: "Bermuda",
            key: "BM",
            label: "Bermuda"
        },
        {
            value: "Bhutan",
            key: "BT",
            label: "Bhutan"
        },
        {
            value: "Bolivia",
            key: "BO",
            label: "Bolivia"
        },
        {
            value: "Bosnia and Herzegovina",
            key: "BA",
            label: "Bosnia and Herzegovina"
        },
        {
            value: "Botswana",
            key: "BW",
            label: "Botswana"
        },
        {
            value: "Bouvet Island",
            key: "BV",
            label: "Bouvet Island"
        },
        {
            value: "Brazil",
            key: "BR",
            label: "Brazil"
        },
        {
            value: "British Indian Ocean Territory",
            key: "IO",
            label: "British Indian Ocean Territory"
        },
        {
            value: "Brunei Darussalam",
            key: "BN",
            label: "Brunei Darussalam"
        },
        {
            value: "Bulgaria",
            key: "BG",
            label: "Bulgaria"
        },
        {
            value: "Burkina Faso",
            key: "BF",
            label: "Burkina Faso"
        },
        {
            value: "Burundi",
            key: "BI",
            label: "Burundi"
        },
        {
            value: "Cambodia",
            key: "KH",
            label: "Cambodia"
        },
        {
            value: "Cameroon",
            key: "CM",
            label: "Cameroon"
        },
        {
            value: "Canada",
            key: "CA",
            label: "Canada"
        },
        {
            value: "Cape Verde",
            key: "CV",
            label: "Cape Verde"
        },
        {
            value: "Cayman Islands",
            key: "KY",
            label: "Cayman Islands"
        },
        {
            value: "Central African Republic",
            key: "CF",
            label: "Central African Republic"
        },
        {
            value: "Chad",
            key: "TD",
            label: "Chad"
        },
        {
            value: "Chile",
            key: "CL",
            label: "Chile"
        },
        {
            value: "China",
            key: "CN",
            label: "China"
        },
        {
            value: "Christmas Island",
            key: "CX",
            label: "Christmas Island"
        },
        {
            value: "Cocos (Keeling) Islands",
            key: "CC",
            label: "Cocos (Keeling) Islands"
        },
        {
            value: "Colombia",
            key: "CO",
            label: "Colombia"
        },
        {
            value: "Comoros",
            key: "KM",
            label: "Comoros"
        },
        {
            value: "Congo",
            key: "CG",
            label: "Congo"
        },
        {
            value: "Congo, The Democratic Republic of the",
            key: "CD",
            label: "Congo, The Democratic Republic of the"
        },
        {
            value: "Cook Islands",
            key: "CK",
            label: "Cook Islands"
        },
        {
            value: "Costa Rica",
            key: "CR",
            label: "Costa Rica"
        },
        {
            value: "Cote D'Ivoire",
            key: "CI",
            label: "Cote D'Ivoire"
        },
        {
            value: "Croatia",
            key: "HR",
            label: "Croatia"
        },
        {
            value: "Cuba",
            key: "CU",
            label: "Cuba"
        },
        {
            value: "Cyprus",
            key: "CY",
            label: "Cyprus"
        },
        {
            value: "Czech Republic",
            key: "CZ",
            label: "Czech Republic"
        },
        {
            value: "Denmark",
            key: "DK",
            label: "Denmark"
        },
        {
            value: "Djibouti",
            key: "DJ",
            label: "Djibouti"
        },
        {
            value: "Dominica",
            key: "DM",
            label: "Dominica"
        },
        {
            value: "Dominican Republic",
            key: "DO",
            label: "Dominican Republic"
        },
        {
            value: "Ecuador",
            key: "EC",
            label: "Ecuador"
        },
        {
            value: "Egypt",
            key: "EG",
            label: "Egypt"
        },
        {
            value: "El Salvador",
            key: "SV",
            label: "El Salvador"
        },
        {
            value: "Equatorial Guinea",
            key: "GQ",
            label: "Equatorial Guinea"
        },
        {
            value: "Eritrea",
            key: "ER",
            label: "Eritrea"
        },
        {
            value: "Estonia",
            key: "EE",
            label: "Estonia"
        },
        {
            value: "Ethiopia",
            key: "ET",
            label: "Ethiopia"
        },
        {
            value: "Falkland Islands (Malvinas)",
            key: "FK",
            label: "Falkland Islands (Malvinas)"
        },
        {
            value: "Faroe Islands",
            key: "FO",
            label: "Faroe Islands"
        },
        {
            value: "Fiji",
            key: "FJ",
            label: "Fiji"
        },
        {
            value: "Finland",
            key: "FI",
            label: "Finland"
        },
        {
            value: "France",
            key: "FR",
            label: "France"
        },
        {
            value: "French Guiana",
            key: "GF",
            label: "French Guiana"
        },
        {
            value: "French Polynesia",
            key: "PF",
            label: "French Polynesia"
        },
        {
            value: "French Southern Territories",
            key: "TF",
            label: "French Southern Territories"
        },
        {
            value: "Gabon",
            key: "GA",
            label: "Gabon"
        },
        {
            value: "Gambia",
            key: "GM",
            label: "Gambia"
        },
        {
            value: "Georgia",
            key: "GE",
            label: "Georgia"
        },
        {
            value: "Germany",
            key: "DE",
            label: "Germany"
        },
        {
            value: "Ghana",
            key: "GH",
            label: "Ghana"
        },
        {
            value: "Gibraltar",
            key: "GI",
            label: "Gibraltar"
        },
        {
            value: "Greece",
            key: "GR",
            label: "Greece"
        },
        {
            value: "Greenland",
            key: "GL",
            label: "Greenland"
        },
        {
            value: "Grenada",
            key: "GD",
            label: "Grenada"
        },
        {
            value: "Guadeloupe",
            key: "GP",
            label: "Guadeloupe"
        },
        {
            value: "Guam",
            key: "GU",
            label: "Guam"
        },
        {
            value: "Guatemala",
            key: "GT",
            label: "Guatemala"
        },
        {
            value: "Guernsey",
            key: "GG",
            label: "Guernsey"
        },
        {
            value: "Guinea",
            key: "GN",
            label: "Guinea"
        },
        {
            value: "Guinea-Bissau",
            key: "GW",
            label: "Guinea-Bissau"
        },
        {
            value: "Guyana",
            key: "GY",
            label: "Guyana"
        },
        {
            value: "Haiti",
            key: "HT",
            label: "Haiti"
        },
        {
            value: "Heard Island and Mcdonald Islands",
            key: "HM",
            label: "Heard Island and Mcdonald Islands"
        },
        {
            value: "Holy See (Vatican City State)",
            key: "VA",
            label: "Holy See (Vatican City State)"
        },
        {
            value: "Honduras",
            key: "HN",
            label: "Honduras"
        },
        {
            value: "Hong Kong",
            key: "HK",
            label: "Hong Kong"
        },
        {
            value: "Hungary",
            key: "HU",
            label: "Hungary"
        },
        {
            value: "Iceland",
            key: "IS",
            label: "Iceland"
        },
        {
            value: "India",
            key: "IN",
            label: "India"
        },
        {
            value: "Indonesia",
            key: "ID",
            label: "Indonesia"
        },
        {
            value: "Iran, Islamic Republic Of",
            key: "IR",
            label: "Iran, Islamic Republic Of"
        },
        {
            value: "Iraq",
            key: "IQ",
            label: "Iraq"
        },
        {
            value: "Ireland",
            key: "IE",
            label: "Ireland"
        },
        {
            value: "Isle of Man",
            key: "IM",
            label: "Isle of Man"
        },
        {
            value: "Israel",
            key: "IL",
            label: "Israel"
        },
        {
            value: "Italy",
            key: "IT",
            label: "Italy"
        },
        {
            value: "Jamaica",
            key: "JM",
            label: "Jamaica"
        },
        {
            value: "Japan",
            key: "JP",
            label: "Japan"
        },
        {
            value: "Jersey",
            key: "JE",
            label: "Jersey"
        },
        {
            value: "Jordan",
            key: "JO",
            label: "Jordan"
        },
        {
            value: "Kazakhstan",
            key: "KZ",
            label: "Kazakhstan"
        },
        {
            value: "Kenya",
            key: "KE",
            label: "Kenya"
        },
        {
            value: "Kiribati",
            key: "KI",
            label: "Kiribati"
        },
        {
            value: "Korea, Democratic People's Republic of",
            key: "KP",
            label: "Korea, Democratic People's Republic of"
        },
        {
            value: "Korea, Republic of",
            key: "KR",
            label: "Korea, Republic of"
        },
        {
            value: "Kuwait",
            key: "KW",
            label: "Kuwait"
        },
        {
            value: "Kyrgyzstan",
            key: "KG",
            label: "Kyrgyzstan"
        },
        {
            value: "Lao People's Democratic Republic",
            key: "LA",
            label: "Lao People's Democratic Republic"
        },
        {
            value: "Latvia",
            key: "LV",
            label: "Latvia"
        },
        {
            value: "Lebanon",
            key: "LB",
            label: "Lebanon"
        },
        {
            value: "Lesotho",
            key: "LS",
            label: "Lesotho"
        },
        {
            value: "Liberia",
            key: "LR",
            label: "Liberia"
        },
        {
            value: "Libyan Arab Jamahiriya",
            key: "LY",
            label: "Libyan Arab Jamahiriya"
        },
        {
            value: "Liechtenstein",
            key: "LI",
            label: "Liechtenstein"
        },
        {
            value: "Lithuania",
            key: "LT",
            label: "Lithuania"
        },
        {
            value: "Luxembourg",
            key: "LU",
            label: "Luxembourg"
        },
        {
            value: "Macao",
            key: "MO",
            label: "Macao"
        },
        {
            value: "Macedonia, The Former Yugoslav Republic of",
            key: "MK",
            label: "Macedonia, The Former Yugoslav Republic of"
        },
        {
            value: "Madagascar",
            key: "MG",
            label: "Madagascar"
        },
        {
            value: "Malawi",
            key: "MW",
            label: "Malawi"
        },
        {
            value: "Malaysia",
            key: "MY",
            label: "Malaysia"
        },
        {
            value: "Maldives",
            key: "MV",
            label: "Maldives"
        },
        {
            value: "Mali",
            key: "ML",
            label: "Mali"
        },
        {
            value: "Malta",
            key: "MT",
            label: "Malta"
        },
        {
            value: "Marshall Islands",
            key: "MH",
            label: "Marshall Islands"
        },
        {
            value: "Martinique",
            key: "MQ",
            label: "Martinique"
        },
        {
            value: "Mauritania",
            key: "MR",
            label: "Mauritania"
        },
        {
            value: "Mauritius",
            key: "MU",
            label: "Mauritius"
        },
        {
            value: "Mayotte",
            key: "YT",
            label: "Mayotte"
        },
        {
            value: "Mexico",
            key: "MX",
            label: "Mexico"
        },
        {
            value: "Micronesia, Federated States of",
            key: "FM",
            label: "Micronesia, Federated States of"
        },
        {
            value: "Moldova, Republic of",
            key: "MD",
            label: "Moldova, Republic of"
        },
        {
            value: "Monaco",
            key: "MC",
            label: "Monaco"
        },
        {
            value: "Mongolia",
            key: "MN",
            label: "Mongolia"
        },
        {
            value: "Montserrat",
            key: "MS",
            label: "Montserrat"
        },
        {
            value: "Morocco",
            key: "MA",
            label: "Morocco"
        },
        {
            value: "Mozambique",
            key: "MZ",
            label: "Mozambique"
        },
        {
            value: "Myanmar",
            key: "MM",
            label: "Myanmar"
        },
        {
            value: "Namibia",
            key: "NA",
            label: "Namibia"
        },
        {
            value: "Nauru",
            key: "NR",
            label: "Nauru"
        },
        {
            value: "Nepal",
            key: "NP",
            label: "Nepal"
        },
        {
            value: "Netherlands",
            key: "NL",
            label: "Netherlands"
        },
        {
            value: "Netherlands Antilles",
            key: "AN",
            label: "Netherlands Antilles"
        },
        {
            value: "New Caledonia",
            key: "NC",
            label: "New Caledonia"
        },
        {
            value: "New Zealand",
            key: "NZ",
            label: "New Zealand"
        },
        {
            value: "Nicaragua",
            key: "NI",
            label: "Nicaragua"
        },
        {
            value: "Niger",
            key: "NE",
            label: "Niger"
        },
        {
            value: "Nigeria",
            key: "NG",
            label: "Nigeria"
        },
        {
            value: "Niue",
            key: "NU",
            label: "Niue"
        },
        {
            value: "Norfolk Island",
            key: "NF",
            label: "Norfolk Island"
        },
        {
            value: "Northern Mariana Islands",
            key: "MP",
            label: "Northern Mariana Islands"
        },
        {
            value: "Norway",
            key: "NO",
            label: "Norway"
        },
        {
            value: "Oman",
            key: "OM",
            label: "Oman"
        },
        {
            value: "Pakistan",
            key: "PK",
            label: "Pakistan"
        },
        {
            value: "Palau",
            key: "PW",
            label: "Palau"
        },
        {
            value: "Palestinian Territory, Occupied",
            key: "PS",
            label: "Palestinian Territory, Occupied"
        },
        {
            value: "Panama",
            key: "PA",
            label: "Panama"
        },
        {
            value: "Papua New Guinea",
            key: "PG",
            label: "Papua New Guinea"
        },
        {
            value: "Paraguay",
            key: "PY",
            label: "Paraguay"
        },
        {
            value: "Peru",
            key: "PE",
            label: "Peru"
        },
        {
            value: "Philippines",
            key: "PH",
            label: "Philippines"
        },
        {
            value: "Pitcairn",
            key: "PN",
            label: "Pitcairn"
        },
        {
            value: "Poland",
            key: "PL",
            label: "Poland"
        },
        {
            value: "Portugal",
            key: "PT",
            label: "Portugal"
        },
        {
            value: "Puerto Rico",
            key: "PR",
            label: "Puerto Rico"
        },
        {
            value: "Qatar",
            key: "QA",
            label: "Qatar"
        },
        {
            value: "Reunion",
            key: "RE",
            label: "Reunion"
        },
        {
            value: "Romania",
            key: "RO",
            label: "Romania"
        },
        {
            value: "Russian Federation",
            key: "RU",
            label: "Russian Federation"
        },
        {
            value: "RWANDA",
            key: "RW",
            label: "RWANDA"
        },
        {
            value: "Saint Helena",
            key: "SH",
            label: "Saint Helena"
        },
        {
            value: "Saint Kitts and Nevis",
            key: "KN",
            label: "Saint Kitts and Nevis"
        },
        {
            value: "Saint Lucia",
            key: "LC",
            label: "Saint Lucia"
        },
        {
            value: "Saint Pierre and Miquelon",
            key: "PM",
            label: "Saint Pierre and Miquelon"
        },
        {
            value: "Saint Vincent and the Grenadines",
            key: "VC",
            label: "Saint Vincent and the Grenadines"
        },
        {
            value: "Samoa",
            key: "WS",
            label: "Samoa"
        },
        {
            value: "San Marino",
            key: "SM",
            label: "San Marino"
        },
        {
            value: "Sao Tome and Principe",
            key: "ST",
            label: "Sao Tome and Principe"
        },
        {
            value: "Saudi Arabia",
            key: "SA",
            label: "Saudi Arabia"
        },
        {
            value: "Senegal",
            key: "SN",
            label: "Senegal"
        },
        {
            value: "Serbia and Montenegro",
            key: "CS",
            label: "Serbia and Montenegro"
        },
        {
            value: "Seychelles",
            key: "SC",
            label: "Seychelles"
        },
        {
            value: "Sierra Leone",
            key: "SL",
            label: "Sierra Leone"
        },
        {
            value: "Singapore",
            key: "SG",
            label: "Singapore"
        },
        {
            value: "Slovakia",
            key: "SK",
            label: "Slovakia"
        },
        {
            value: "Slovenia",
            key: "SI",
            label: "Slovenia"
        },
        {
            value: "Solomon Islands",
            key: "SB",
            label: "Solomon Islands"
        },
        {
            value: "Somalia",
            key: "SO",
            label: "Somalia"
        },
        {
            value: "South Africa",
            key: "ZA",
            label: "South Africa"
        },
        {
            value: "South Georgia and the South Sandwich Islands",
            key: "GS",
            label: "South Georgia and the South Sandwich Islands"
        },
        {
            value: "Spain",
            key: "ES",
            label: "Spain"
        },
        {
            value: "Sri Lanka",
            key: "LK",
            label: "Sri Lanka"
        },
        {
            value: "Sudan",
            key: "SD",
            label: "Sudan"
        },
        {
            value: "Suriname",
            key: "SR",
            label: "Suriname"
        },
        {
            value: "Svalbard and Jan Mayen",
            key: "SJ",
            label: "Svalbard and Jan Mayen"
        },
        {
            value: "Swaziland",
            key: "SZ",
            label: "Swaziland"
        },
        {
            value: "Sweden",
            key: "SE",
            label: "Sweden"
        },
        {
            value: "Switzerland",
            key: "CH",
            label: "Switzerland"
        },
        {
            value: "Syrian Arab Republic",
            key: "SY",
            label: "Syrian Arab Republic"
        },
        {
            value: "Taiwan, Province of China",
            key: "TW",
            label: "Taiwan, Province of China"
        },
        {
            value: "Tajikistan",
            key: "TJ",
            label: "Tajikistan"
        },
        {
            value: "Tanzania, United Republic of",
            key: "TZ",
            label: "Tanzania, United Republic of"
        },
        {
            value: "Thailand",
            key: "TH",
            label: "Thailand"
        },
        {
            value: "Timor-Leste",
            key: "TL",
            label: "Timor-Leste"
        },
        {
            value: "Togo",
            key: "TG",
            label: "Togo"
        },
        {
            value: "Tokelau",
            key: "TK",
            label: "Tokelau"
        },
        {
            value: "Tonga",
            key: "TO",
            label: "Tonga"
        },
        {
            value: "Trinidad and Tobago",
            key: "TT",
            label: "Trinidad and Tobago"
        },
        {
            value: "Tunisia",
            key: "TN",
            label: "Tunisia"
        },
        {
            value: "Turkey",
            key: "TR",
            label: "Turkey"
        },
        {
            value: "Turkmenistan",
            key: "TM",
            label: "Turkmenistan"
        },
        {
            value: "Turks and Caicos Islands",
            key: "TC",
            label: "Turks and Caicos Islands"
        },
        {
            value: "Tuvalu",
            key: "TV",
            label: "Tuvalu"
        },
        {
            value: "Uganda",
            key: "UG",
            label: "Uganda"
        },
        {
            value: "Ukraine",
            key: "UA",
            label: "Ukraine"
        },
        {
            value: "United Arab Emirates",
            key: "AE",
            label: "United Arab Emirates"
        },
        {
            value: "United Kingdom",
            key: "GB",
            label: "United Kingdom"
        },
        
        {
            value: "United States Minor Outlying Islands",
            key: "UM",
            label: "United States Minor Outlying Islands"
        },
        {
            value: "Uruguay",
            key: "UY",
            label: "Uruguay"
        },
        {
            value: "Uzbekistan",
            key: "UZ",
            label: "Uzbekistan"
        },
        {
            value: "Vanuatu",
            key: "VU",
            label: "Vanuatu"
        },
        {
            value: "Venezuela",
            key: "VE",
            label: "Venezuela"
        },
        {
            value: "Viet Nam",
            key: "VN",
            label: "Viet Nam"
        },
        {
            value: "Virgin Islands, British",
            key: "VG",
            label: "Virgin Islands, British"
        },
        {
            value: "Virgin Islands, U.S.",
            key: "VI",
            label: "Virgin Islands, U.S."
        },
        {
            value: "Wallis and Futuna",
            key: "WF",
            label: "Wallis and Futuna"
        },
        {
            value: "Western Sahara",
            key: "EH",
            label: "Western Sahara"
        },
        {
            value: "Yemen",
            key: "YE",
            label: "Yemen"
        },
        {
            value: "Zambia",
            key: "ZM",
            label: "Zambia"
        },
        {
            value: "Zimbabwe",
            key: "ZW",
            label: "Zimbabwe"
        }
    ];

    get stateOptions() {
        return this.countryStateeMap[this.selectedCountry];
    }

    get countryOptions() {
        return this.countryOptions;
    }

    handleAddressChange(event) {
        console.log('payment:::::' + JSON.stringify(event.detail.value));
        this.payment.country = event.detail.value;
        if (event.detail.value === 'United States') {
            this.selectedCountry = 'US';
            
            this.usselected = true;
        }
        else {
            this.selectedCountry = event.detail.value;
            this.usselected = false;
        }
    }

    validateAddress() {
        const address = this.template.querySelector('lightning-input-address');
        address.reportValidity();
    }

    connectedCallback() {
      
    };   

    hanfleSubmit() {
       
        if (this.getIsValid(this.getFieldValue('FirstName'), 'FirstName') === false ||
            this.getIsValid(this.getFieldValue('LastName'), 'LastName') === false) {
            this.errorMessage = 'First name and last Name are required';
            this.showErrorMessage = true;
        }
        else if (this.getIsValid(this.getFieldValue('CardNumber'), 'CardNumber') === false) {
            this.showErrorMessage = true;
            if (this.payment.cardTypeSelect === 'VISA') {
                this.errorMessage = 'Invalid Visa card number';
            }
            else if (this.payment.cardTypeSelect === 'AMEX') {
                this.errorMessage = 'Invalid American Express card number';
            }
            else if (this.payment.cardTypeSelect === 'MASTERCARD') {
                this.errorMessage = 'Invalid Mastercard card number';
            }
            else if (this.payment.cardTypeSelect === 'DISCOVER') {
                this.errorMessage = 'Invalid Discover card number';
            }
        }
        else if (this.getIsValid(this.getFieldValue('CardCVV'), 'CardCVV') === false) {
            this.errorMessage = 'Invalid Card Verification Number';
            this.showErrorMessage = true;
        }
        else if (this.getIsValid(this.getFieldValue('CardExpiryDate'), 'CardExpiryDate') === false) {
            this.errorMessage = 'Please enter a valid date in the format mm/yyyy';
            this.showErrorMessage = true;
        }
        else if (this.getIsValid(this.getFieldValue('Email'), 'Email') === false) {
            this.errorMessage = 'Please Enter a valid Email Address';
            this.showErrorMessage = true;
        }
        else if(this.payment.street == '' && this.getIsValid(this.getFieldValue('Street'), 'Address') === false){
            this.errorMessage = 'Please Enter a valid Street';
            this.showErrorMessage = true;
        }
        else if (this.getIsValid(this.getFieldValue('City'), 'Address') === false || 
            this.getIsValid(this.getFieldValue('Pincode'), 'Address') === false) {
            this.errorMessage = 'Please Enter a valid Pin/City';
            this.showErrorMessage = true;
        }

        else if(this.payment.country == '' && this.getIsValid(this.getFieldValue('Country'), 'Address') === false){
            this.errorMessage = 'Please Select a valid Country';
            this.showErrorMessage = true;
        }
        else if(this.payment.country === 'United States' && this.getIsValid(this.getFieldValue('State'), 'Address') === false){
            this.errorMessage = 'Please Enter a valid State';
            this.showErrorMessage = true;
        }
        else if(this.payment.country !== 'United States' && this.getIsValid(this.getFieldValue('StateInput'), 'Address') === false){
            this.errorMessage = 'Please Enter a valid State';
            this.showErrorMessage = true;
        }
        
        
       
        else {
            this.payment.firstName = this.getFieldValue('FirstName');
            this.payment.middleName = this.getFieldValue('MiddleName');
            this.payment.lastName = this.getFieldValue('LastName');
            this.payment.expiryDate = this.getFieldValue('CardExpiryDate');
            this.payment.cardNumber = this.getFieldValue('CardNumber');
            
            this.payment.email = this.getFieldValue('Email');
            this.payment.cvv = this.getFieldValue('CardCVV');
            this.payment.nickname = this.getFieldValue('NickName');
            this.payment.city =  this.getFieldValue('City');
            this.payment.postalCode =  this.getFieldValue('Pincode');
            this.payment.street =  this.getFieldValue('Street');
            if(this.payment.state == ''){
                this.payment.state = this.getFieldValue('StateInput');
            }
            this.showErrorMessage = false;

            console.log('this.payment::::' + JSON.stringify(this.payment));
            CreatePaymentController({
                paymentData: JSON.stringify(this.payment),
                accountId: this.accountId
            })
                .then(result => {
                    if(result === 'NoError'){
                        this.isModalOpen = false;
                        const addPaymentMethodEvent = new CustomEvent('addPaymentMethod');
                        this.dispatchEvent(addPaymentMethodEvent);
                    }
                    else{
                        console.log('result:::'+JSON.stringify(result));
                        this.errorMessage =result;
                        this.showErrorMessage = true;
                    }
                })
                .catch(error => {
                    this.errorMessage = error;
                    this.showErrorMessage = true;
                });
        }  
    }

    getIsValid(val, validatorName) {
        var isValid = false;
        if (validatorName === "CardExpiryDate") {
            isValid = this.validateCardDate(val);
        }
        else if (validatorName === "CardCVV") {
            isValid = this.validateCardCVC(val);
        }
        else if (validatorName === "CardNumber") {   
            //  console.log('VardValue::::'+this.validateCardNumber(val));
            isValid = this.validateCardNumber(val);
        }
        else if (validatorName === "FirstName" || validatorName === "LastName") {
            isValid = val !== "" ? true : false;
        }
        else if (validatorName === "Email") {
            isValid = this.validateEmailAddress(val);
        }
        else if (validatorName === "Address") {
            isValid = this.validateAddress(val);
        }
        return isValid;
    }

    validateCardNumber(value) {
        var type = this.payment.cardTypeSelect;
        var pattern = /\s|-/g;
        value = value.replace(pattern, "");
        if ("VISA" == type && (!value.match(/^4/) || value.length != 16)) {
            return false;
        } else if ("AMEX" == type && (!value.match(/^3[47]/) || value.length != 15)) {
            return false;
        } else if ("DISCOVER" == type && (!value.match(/^(6011|622(12[6-9]|1[3-9][0-9]|[2-8][0-9]{2}|9[0-1][0-9]|92[0-5]|64[4-9])|65)/) || value.length != 16)) {
            return false;
        } else if ("MASTERCARD" == type && (!value.match(/^5[1-5]/) || value.length != 16)) {
            return false;
        } else {
            return true;
        }
    }

    validateCardCVC(value) {
        var type = this.payment.cardTypeSelect;
        if ("AMEX" == type && (value.length != 4)) {
            return false;
        } else if (("VISA" == type || "DISCOVER" == type || "MASTERCARD" == type) && (value.length != 3)) {
            return false;
        } else {
            return true;
        }
    }

    validateCardDate(value) {
        console.log('value:::' + value);
        var pattern = /^(1[0-2]|0?[1-9])\/(?:[0-9]{2})?[0-9]{2}$/;
        if (value.match(pattern)) {
            return true;
        }
        else {
            return false;
        }
    }

    validateCardExpiry(value) {
        var dateArray = value.split('/');
        var myDate = new Date(dateArray[1], dateArray[0]);
        var now = new Date();

        if (myDate < now) {
            return false;
        } else {
            return true;
        }
    }
    validateAddress(value){
        var adressComp = value;
        if(adressComp ==='' ||  adressComp ===undefined ){
            return false;
        }
        else{
            return true;
        }
    }

    getFieldValue(fieldName) {
        let thisCurentValue = this.template.querySelector(`[data-id="${fieldName}"]`).value;
        return thisCurentValue;
    }

    validateEmailAddress(value) {
        var regExpEmailformat = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        if (value.match(regExpEmailformat)) {
            return true;
        } else {
            return false;
        }
    }

    handleCCInput(event) {
        let cardNumber, firstNum;
        cardNumber = event.target.value;
        if (this.tempCardLeng <= cardNumber.length) {
            if ((cardNumber.length == 4) || (cardNumber.length == 9) || (cardNumber.length == 14)) {
                cardNumber = cardNumber + ' ';
                event.target.value = cardNumber;
                this.tempCardLeng = this.tempCardLeng + 1;
            }
        }
        this.tempCardLeng = cardNumber.length;
        if (cardNumber.length <= 19) {
            this.template.querySelector('[data-id="cardNumber16"]').innerHTML = cardNumber;
        }
        if (cardNumber.length == 0) {
            this.template.querySelector('[data-id="cardNumber16"]').innerHTML = 'xxxx xxxx xxxx xxxx';
        }
        firstNum = cardNumber.charAt(0);
        switch (firstNum) {
            case '3': this.template.querySelector('[data-id="cardCont"]').classList.add('american-card');
                this.template.querySelector('[data-id="cardCont"]').classList.add('card-active');
                this.template.querySelector('[data-id="cardCont"]').classList.remove('discover-card');
                this.template.querySelector('[data-id="cardCont"]').classList.remove('master-card');
                this.template.querySelector('[data-id="cardCont"]').classList.remove('visa-card');
                this.payment.cardTypeSelect = 'AMEX';
                break;
            case '4': this.template.querySelector('[data-id="cardCont"]').classList.add('visa-card');
                this.template.querySelector('[data-id="cardCont"]').classList.add('card-active');
                this.template.querySelector('[data-id="cardCont"]').classList.remove('discover-card');
                this.template.querySelector('[data-id="cardCont"]').classList.remove('master-card');
                this.template.querySelector('[data-id="cardCont"]').classList.remove('american-card');
                this.payment.cardTypeSelect = 'VISA';
                break;
            case '5': this.template.querySelector('[data-id="cardCont"]').classList.add('master-card');
                this.template.querySelector('[data-id="cardCont"]').classList.add('card-active');
                this.template.querySelector('[data-id="cardCont"]').classList.remove('discover-card');
                this.template.querySelector('[data-id="cardCont"]').classList.remove('visa-card');
                this.template.querySelector('[data-id="cardCont"]').classList.remove('american-card');
                this.payment.cardTypeSelect = 'MASTERCARD';
                break;
            case '6': this.template.querySelector('[data-id="cardCont"]').classList.add('discover-card');
                this.template.querySelector('[data-id="cardCont"]').classList.add('card-active');
                this.template.querySelector('[data-id="cardCont"]').classList.remove('visa-card');
                this.template.querySelector('[data-id="cardCont"]').classList.remove('master-card');
                this.template.querySelector('[data-id="cardCont"]').classList.remove('american-card');
                this.payment.cardTypeSelect = 'DISCOVER';
                break;
            default: this.template.querySelector('[data-id="cardCont"]').classList.remove('visa-card');
                this.template.querySelector('[data-id="cardCont"]').classList.remove('discover-card');
                this.template.querySelector('[data-id="cardCont"]').classList.remove('master-card');
                this.template.querySelector('[data-id="cardCont"]').classList.remove('american-card');
                this.template.querySelector('[data-id="cardCont"]').classList.remove('card-active');
                break;
        }
    }

    fNameInput(event) {
        let tempName = event.target.value;
        let fChar = tempName.slice(-1);
        this.template.querySelector('[data-id="fName"]').innerHTML = tempName;
        /*if (tempName.length == 0) {
            this.template.querySelector('[data-id="fName"]').innerHTML = 'full';
        }*/
        console.log(tempName, tempName.slice(0,-1), fChar, isFinite(fChar));
        if(isFinite(fChar)) {
            this.template.querySelector('[data-entry1]').value = tempName.slice(0,-1);
        }
    }
    mNameInput(event) {
        let tempName = event.target.value;
        let mChar = tempName.slice(-1);
        this.template.querySelector('[data-id="mName"]').innerHTML = tempName;
       console.log(tempName, tempName.slice(0,-1), mChar, isFinite(mChar));
       if(isFinite(mChar)) {
        this.template.querySelector('[data-entry2]').value = tempName.slice(0,-1);
    }
    }
    lNameInput(event) {
        let tempName = event.target.value;
        let lChar = tempName.slice(-1);
        this.template.querySelector('[data-id="lName"]').innerHTML = tempName;
       /* if (tempName.length == 0) {
            this.template.querySelector('[data-id="lName"]').innerHTML = 'Name';
        }*/
        console.log(tempName, tempName.slice(0,-1), lChar, isFinite(lChar));
        if(isFinite(lChar)) {
            this.template.querySelector('[data-entry3]').value = tempName.slice(0,-1);
        }
    }
    eDateInput(event) {
        let tempDate = event.target.value;
        if (event.which == 8) {
            if (tempDate.length == 2) {
                console.log('before ====> ' + tempDate);
                tempDate = tempDate.slice(0, -1);
                console.log('after ====> ' + tempDate);
                event.target.value = tempDate;
            }
        } else {
            if (tempDate.length == 2) {
                tempDate = tempDate + '/';
                event.target.value = tempDate;
            }
        }
        if (tempDate.length <= 7) {
            this.template.querySelector('[data-id="eDate"]').innerHTML = tempDate;
        }
        if (tempDate.length == 0) {
            this.template.querySelector('[data-id="eDate"]').innerHTML = '--/----';
        }
    }
    cvvInput(event) {
        let cvvNum = event.target.value;
        if (cvvNum.length <= 3) {
            this.template.querySelector('[data-id="cvvName"]').innerHTML = cvvNum;
        }
        if (cvvNum.length == 0) {
            this.template.querySelector('[data-id="cvvName"]').innerHTML = '***';
        }
    }
    onFocusCVV() {
        this.template.querySelector('[data-id="cardCont"]').classList.add('cvv-input');
    }
    onFocusOutCVV() {
        this.template.querySelector('[data-id="cardCont"]').classList.remove('cvv-input');
    }

    @track isModalOpen = true;
    openModal() {
        // to open modal set isModalOpen tarck value as true
        this.isModalOpen = true;
    }
    closeModal() {
        // to close modal set isModalOpen tarck value as false
        //this.isModalOpen = false;
        const closePaymentMethodEvent = new CustomEvent('closePaymentMethod');
        this.dispatchEvent(closePaymentMethodEvent);
    }
    autoPaymentCHange = event =>{
        let checkBox = event.target.checked;
        this.payment.autoPayment = checkBox;
        console.log('payment:::::' + JSON.stringify(checkBox));
    }

    handleStateChange= event =>{
        this.payment.state = event.detail.value;
    }

    renderedCallback() {
        const style = document.createElement('style');
        style.innerText = '.custom-dropdown .slds-is-open .slds-listbox.slds-listbox_vertical{top: unset;bottom: 100%;max-height: 150px;}';
        this.template.querySelector('.first-class').appendChild(style);
    }
}
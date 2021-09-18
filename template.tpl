___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Extract From JSON",
  "categories": ["UTILITY"],
  "description": "Extract element from JSON object or valid JSON string by path (using dot-notation)",
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "obj",
    "displayName": "JSON Input",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "alwaysInSummary": true,
    "help": "Variable containing JSON object or valid JSON string"
  },
  {
    "type": "TEXT",
    "name": "path",
    "displayName": "Path to Element",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "help": "Examples: products[0].price, propertyName, property.subProperty",
    "alwaysInSummary": true
  },
  {
    "type": "CHECKBOX",
    "name": "stringify",
    "checkboxText": "Convert Object Results to String",
    "simpleValueType": true
  }
]


___SANDBOXED_JS_FOR_SERVER___

const JSON = require('JSON');

var path = data.path || "";
var obj = data.obj || {};

if (typeof(obj) === "string") obj = JSON.parse(obj); 
 
var res = path.split('.').reduce(function(o, k) {
  var ind = k.indexOf('[');
  var ind2 = k.indexOf(']');
  if (ind >=0 && ind2 > ind) {
    var kOrg = k;
    k = kOrg.substring(0,ind);
    var key = kOrg.substring(ind+1, ind2);
    if (k != "")
      return o && o[k][key];
    else 
      return o && o[key];
  } else return o && o[k];
}, obj);

if ((typeof(res) === "string") && data.stringify) res = JSON.stringify(res);

return res;


___TESTS___

scenarios: []


___NOTES___

Created on 19.9.2021, 00:58:59



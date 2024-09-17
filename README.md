# Extract From JSON (ssGTM)

**Custom Variable Template for Server-Side Google Tag Manager**

Extract element from JSON object or valid JSON string by path using dot-notation 

[![Template Status](https://img.shields.io/badge/Community%20Template%20Gallery%20Status-published-green)](https://tagmanager.google.com/gallery/#/owners/mbaersch/templates/extract-json) ![Repo Size](https://img.shields.io/github/repo-size/mbaersch/extract-json) ![License](https://img.shields.io/github/license/mbaersch/extract-json)

---

## Usage
Create a new variable with this template. Choose a variable as input that holds an array or JSON object like "items" from event data or an extracted JSON string (see notes below) from a request parameter. Then define a path to the desired element / property using dot-notation.

The variable will parse the input (if neccessary) and query the defined path. returns the value of the element. If the result is an object, if can be stringified. 

## Example
If the input consists of the following object or the corresponding JSON string:

```
{
  something: 42,
  some_object: {key1: 'value1', key2: 'value2', key3: 'value3'},
  items: [
    {itemName: 'example item 1', itemPrice: 199},
    {itemName: 'example item 2', itemPrice: 321.5},
  ]
}
```
... then the following paths will fetch these values:

Path | Value
------------ | -------------
something | 42
some_object.key3 | value3
items[1].itemPrice | 321.5
some_object | {key1: 'value1', key2: 'value2', key3: 'value3'} (optionally as a string) 

Querying an array with this template can be done by starting the path with an index. "[0]" as a path returns the first element; [0].price the "price" element in an object in the first element of an array.

## Using string inputs
If you send an object as a serialized JSON string, make sure to use a valid format. The example object above would only be valid, if it is contained in a string value like this: 

```
{"something":42,"some_object":{"key1":"value1","key2":"value2","key3":"value3"},"items":[{"itemName":"example item 1","itemPrice":199},{"itemName":"example item 2","itemPrice":321.5}]}
```

Make sure to only use `"` as a string delimiter for all string values *and* key names! The following strings cannot be parsed and so you would not get the desired results: 

```
//This will not work because the wrong delimiter was used:
{'something':42,'some_object':{'key1':'value1','key2':'value2','key3':'value3'},'items':[{'itemName':'example item 1','itemPrice':199},{'itemName':'example item 2','itemPrice':321.5}]}

//This is also wrong because key names do not have demimiters:
{something:42,some_object:{key1:"value1",key2:"value2",key3:"value3"},items:[{itemName:"example item 1",itemPrice:199},{itemName:"example item 2",itemPrice:321.5}]}
```

Tip: Take a sample of your raw field values you want to parse and try to convert it to an object in your browser's console using `JSON.parse()`. 
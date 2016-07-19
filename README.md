# 4d-component-classic-query-editor
Replica of the pre-v14 era query editor, with some enhancements.

**Note**: The component is written for v15, though it only uses v14 features. (sorry about that)

### Usage

Pass an object to the shared ``CLASSIC_QUERY`` method.

```
C_OBJECT($params)

OB SET($params;\
  "tableNumber";Table(->[Aliment]);\
  "repeat";True;\
  "developer";True;\
  "language";"ja")

CLASSIC_QUERY ($params)
```

![screenshot](https://cloud.githubusercontent.com/assets/1725068/16935310/3f302074-4d99-11e6-9b9d-9bf171874cc6.png)

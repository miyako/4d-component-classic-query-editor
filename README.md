# 4d-component-classic-query-editor
Replica of the pre-v14 era query editor, with some enhancements.

###New!

Table-field lists are created in the background and cached, for optimised performance.

To take advantage of this new feature, do one of the following:

* Enable [Execute "On Host Database Event" method of the components](http://doc.4d.com/4Dv15/4D/15.3/Security-page.300-3162580.en.html)

* Explicitly call the shared methods ``CLASSIC_QUERY_DEINIT`` and ``CLASSIC_QUERY_INIT`` in your host database.

**Note:** Even if you do neither of the above, the lists are still created on the fly and internally cached. 

### Usage

Pass an object to the shared ``CLASSIC_QUERY`` method.

```
C_OBJECT($params)

OB SET($params;\
  "tableNumber";Table(->[Aliment]);\
  "repeat";True;\
  "developer";True;\
  "language";"ja"\
  "selection";True)

CLASSIC_QUERY ($params)
```

![screenshot](https://cloud.githubusercontent.com/assets/1725068/16935310/3f302074-4d99-11e6-9b9d-9bf171874cc6.png)

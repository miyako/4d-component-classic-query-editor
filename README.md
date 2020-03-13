# 4d-component-classic-query-editor
Replica of the pre-v14 era query editor, with some enhancements.

### Remarks 

* The component has been upgraded to v17 (previously v14)
* the ``Form`` object is now used instead of a process object variable to manage context

### New!

When the ``repeat`` option is used, the initial current selection is now the starting point of search history. You can revert all the way back to that selection using the "back" button. Previously, the result of the first query was the starting point.

A new cache mechanism for table lists is implemented.

The structure XML (``EXPORT STRUCTURE``) and parameters are hashed and used as list identifiers. If an identical list has been created previously by the component, it will be loaded from disk on the client side. If not, it will be created on the server side (to reduce network traffic) and cached on the server side (for other clients) as well as the client side (for local use).

### Was new...

French localisation is available. 

New option ``windowType`` to specify the editor window type (default:``Default window type`` = ``Plain form window`` + ``Form has no menu bar``).  
 
New option ``useSheetForFileSelect`` to specify whether to add the ``Use sheet window`` when calling ``Select document`` (default:``False``).  

Recursive relations are blocked when it reaches the master table.

The system variables ``OK`` and ``DOCUMENT`` are returned in the context object, when the ``repeat`` option is not used. 

``C_LONGINT`` is used extensively to avoid default typing of ``C_REAL`` by the compiler  

The form "Developer" is now an inherited form of "Standard".

No longer calls ``DESCRIBE QUERY EXECUTION`` in standard mode.

The bottom area (input value, input value list, boolean radio button group, operator, conjunction, field list) is updated whenever a line in the query is selected.

Up/down arrow can be used to select a query line when the input value has focus.

You can use ``4DF`` files created in v11-v13.

### Usage

Pass an object to the shared ``CLASSIC_QUERY`` method.

```
C_OBJECT($params)

OB SET($params;\
  "tableNumber";Table(->[Aliment]);\
  "repeat";True;\
  "developer";True;\
  "depth";Default depth;\
  "language";"ja";\
  "selection";True)

CLASSIC_QUERY ($params)
```

### Options

``repeat``: Keep the editor open in the same process with ``DIALOG(*)`` to perform continuous queries on the same selection.

**Note**: In repeat mode, the user can quickly navigate through previous queries using the ``back`` and ``forward`` buttons.

``developer``: Display the query path and query plan.

``selection``: Disable the ``query`` button and allow ``query selection`` only.

``windowType``: Change the editor's ``Open form window`` option  

``useSheetForFileSelect``: Change the editor's ``Select document`` option  

``depth``: Specify how deep the field list should traverse a relation. The default is ``3`` levels. The maximum is ``9`` levels. The minimum is ``1`` level. Out-of-range values are cajoled. You can pass the ``Default depth`` constant for ``3``. Recursive relations are blocked when it reaches the master table. Unlike the original editor, both ``ONE`` and ``MANY`` relations are traced.

![screenshot](https://cloud.githubusercontent.com/assets/1725068/16935310/3f302074-4d99-11e6-9b9d-9bf171874cc6.png)

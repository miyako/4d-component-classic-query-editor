# 4d-component-classic-query-editor
Replica of the pre-v14 era query editor, with some enhancements.

### New!

French localisation is available. 

New option ``windowType`` to specify the editor window type (default:``Default window type`` = ``Plain form window`` + ``Form has no menu bar``).  
 
New option ``useSheetForFileSelect`` to specify whether to add the ``Use sheet window`` when calling ``Select document`` (default:``False``).  

The system variables ``OK`` and ``DOCUMENT`` are returned in the context object, when the ``repeat`` option is not used. 

``C_LONGINT`` is used extensively to avoid default typing of ``C_REAL`` by the compiler  

The form "Developer" is now an inherited from of "Standard".

Do not call ``DESCRIBE QUERY EXECUTION`` in standard mode.

### Was new...

The bottom area (input value, input value list, boolean radio button group, operator, conjunction, field list) is updated whenever a line in the query is selected.

Up/down arrow can be used to select a query line when the input value has focus.

You can use ``4DF`` files created in v11-v13.

The ``depth`` option can be used to specify how deep the field list should traverse a relation. The default is ``3`` levels. The maximum is ``9`` levels. The minimum is ``1`` level. Out-of-range values are cajoled. You can pass the ``Default depth`` constant for ``3``.

Table-field lists are created in the background and cached, for optimised performance.

To take advantage of this new feature, do one of the following:

* Enable [Execute "On Host Database Event" method of the components](http://doc.4d.com/4Dv15/4D/15.3/Security-page.300-3162580.en.html)

**Note:** Only ``CLASSIC_QUERY_DEINIT`` is called by default (``On after host database exit``). To activate caching on startup, open the component's ``On Host`` Database Event and uncomment ``CLASSIC_QUERY_INIT`` (``On after host database startup``).

* Explicitly call the shared methods ``CLASSIC_QUERY_DEINIT`` and ``CLASSIC_QUERY_INIT`` in your host database.

**Note:** Even if you do __neither of the above__, the lists are still created on the fly and __internally cached__. 

Be default, all 3 types of lists (master, related, all) are created for all tables. If you only use the related list (the most common) you might want to comment out the 2 lines in ``Cache_CREATE_LIST`` as illustrated below:

```
C_LONGINT($1)

If (Count parameters=0)

  $p:=New process(Current method name;0;Current method name;1;*)

Else 

  For ($i;1;Get last table number)
    Cache_Get_list_for_table ($i;"";True;Default depth)
    // Cache_Get_master_list_for_table ($i;"")
    // Cache_Get_all_list_for_table ($i;"")
  End for 

End if 
```

Alternatively, you could limit the tables for which you pre-build the field lists.

For all 3 methods, ``$1`` is the master table number and ``$2`` is a string to filter displayed field names (the feature is not exposed in the current UI). ``$3`` of ``Cache_Get_list_for_table`` specifies whether to display related field names with their table names.

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

![screenshot](https://cloud.githubusercontent.com/assets/1725068/16935310/3f302074-4d99-11e6-9b9d-9bf171874cc6.png)

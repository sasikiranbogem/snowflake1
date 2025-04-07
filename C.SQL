Result Cache:  
==============
Which holds the results of every query executed in the past 24 hours. These are available across virtual warehouses, so query results returned to one user is available to any other user on the system who executes the same query, provided the underlying data has not changed.

Local Disk Cache:  
===================
Which is used to cache data used by SQL queries.  Whenever data is needed for a given query its retrieved from the Remote Disk storage, and cached in SSD and memory.


Remote Disk:  
=============
Which holds the long term storage.  This level is responsible for data centre failure.

SCD: Slowly change dimension
type-1: Complete full refresh: Truncate and load data in the target table
type-2: History + delta data: using merge and insert we can perform type2

      Existing Ids will ends the activeness.Flg_ACTIVE MADE AS 'N' and active_end_date with 'current_date' .New records will insert as flg_active as 'Y' and active_from_date as 'Current_date'
Type-3==> Merge
Existing ID's will be updated new records will be inserted 

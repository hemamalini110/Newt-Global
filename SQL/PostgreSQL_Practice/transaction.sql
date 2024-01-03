-- TRANSACTION

transaction is a list of commands that can be run on database to make changes in data.
Multiple steps or operation in a single unit is a transaction.

in normal , whenever a failure in H/S during multiple commands running on a server it will left in a intermediate state.
or multiple user access.

Here ,comes transaction to solve it
whether it complete or do nothing,
it will rollback the change if there is any failure in between the process.

4 transaction methods
-- commit (save)
-- rollback (back to orginal state incase failure)
-- grant and revoke (give previleges in level)

During transaction every operation  is logged.

any interruption before the commit statement ends the trasaction , then rollback by undoing changes.


ACID property

Atomicity   - complete or do nothing
Consistency - data should be consistent after the transaction perform 
Isolate     - serialize the transaction (in parallel lane one traction should not affect other)
Durability  - any failure then rollback, backup and up-to-date data

select * from accounts a ;
begin;

update accounts set balance=balance -100 where name='aaa';
commit;
rollback;


-- rollback fix the abort transaction

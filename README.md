# Visualforce-Account-Contact-Details
A simple visualforce page for displaying details about account and contact. Has the ability to create them.

### Task:
1. Develop a page in Visualforce, that will be accessible by Tab.
2. The page can be opened and should work in Classic view and LEX.
3. The page should display Account details (min 10 fields) and a table with a list of Contacts for this account.
4. The page should be able to create a new Account and Contacts for it.
5. Provide pagination for the Contact table.
6. It is assumed, that the number of created Contacts for an Account can be up to 10K.

### Triggers
1. Develop case, when we have situtation with recursive data channging on triggers. We have after update trigger on Account, which changes field on Contact, and also we have after update Account trigger, which changes field in Contact. Main task is finding solution to this situation.
2. Write trigger to calculate count of closed Opportunities related to the Account and total amount closed Opportunities related to the Account.
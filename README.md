# PROJECT REQUIREMENTS #

Create accounts of users; login, logout. 
 
## I. Auctions ##
   * seller creates auctions and posts items for sale 
     * set all the characteristics of the item 
     * set closing date and time 
     * set a hidden minimum price (reserve) 
   * a buyer should be able to bid 
     * let the buyer set a new bid 
     * in case of automatic bidding set secret upper limit and bid increment 
     * alert other buyers of the item that a higher bid has been placed (manual) 
     * alert buyers in case someone bids more than their upper limit (automatic) 
   * define the winner of the auction 
     * when the closing time has come, check if the seller has set a reserve 
       * if yes: if the reserve is higher than the last bid none is the winner. 
       * if no: whoever has the higher bid is the winner 
         * alert the winner that they won the auction 
 
## II. Browsing and advanced search functionality ##
  * let people browse on the items and see the status of the current bidding 
  * sort by different criteria (by type, bidding price etc.) 
  * search the list of items by various criteria. 
  * a user should be able to: 
    * view all the history of bids for any specific auction 
    * view the list of all auctions a specific buyer or seller has participated in 
    * view the list of "similar" items on auctions in the preceding month (and auction 
information about them) 
  * let user set an alert for specific items s/he is interested  
    * get an alert when the item becomes available 
  * users browse questions and answers 
  * users search questions by keywords 
 
 
## III. Admin and customer rep functions ###
  * Admin (create an admin account ahead of time) 
    * creates accounts for customer representatives 
    * generates sales reports for: 
      * total earnings 
      * earnings per: 
        * item 
        * item type 
        * end-user 
      * best-selling items 
      * best buyers 
 
  * Customer representative functions: 
    * users post questions to the customer representatives (i.e. customer service) 
    * reps reply to user questions 
    * edits and deletes account information 
    * removes bids  
    * removes auctions

# DEMO #

https://user-images.githubusercontent.com/80138563/172261781-50e24111-79a7-4a5a-a3be-207ff14a0dad.mp4

# Entity Relationship (ER) Diagram #

![ER_Diagram](https://user-images.githubusercontent.com/80138563/172263646-302a0518-098a-4ac5-9a8d-1bc8d411f354.PNG)



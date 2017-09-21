local store = require("store")

require( "Buy")





--local widget = require("widget") 
--local store = require( "plugin.google.iap.v3" )
 

--print( "coinvalue"..coinsnumber )



local function productCallback( event )

    print( "Showing valid products:", #event.products )
    for i = 1,#event.products do
        print( event.products[i].title )
        print( event.products[i].description )
        print( event.products[i].price )
        print( event.products[i].localizedPrice )
        print( event.products[i].productIdentifier )
    end

    print( "Showing invalid products:", #event.invalidProducts )
    for i = 1,#event.invalidProducts do
        print( event.invalidProducts[i] )
    end

end

function transactionCallback( event )


 
    -- Log transaction info.
    print("transactionCallback: Received event " .. tostring(event.name))
    print("state: " .. tostring(event.transaction.state))
    print("errorType: " .. tostring(event.transaction.errorType))
    print("errorString: " .. tostring(event.transaction.errorString))
 
    local productID= event.transaction.productIdentifier
    local transaction = event.transaction
    local tstate = event.transaction.state

   
    if tstate == "purchased" and productID == "coins600"then
         print("Product Purchased: ", productID)
        updateboughtcoins(600)
        --ticker.text = " 600 Bought bitch!!" 

        store.consumePurchase( { "coins600" }, transactionCallback )

    elseif tstate == "purchased" and productID == "coins1500"then

        print("Product Purchased: ", productID)
       updateboughtcoins(1500) 
       --ticker.text = " 1500 Bought bitch!!" 
        store.consumePurchase( { "coins1500" }, transactionCallback )      
    elseif  tstate == "refunded" then
        print("Product Refunded")
 
    elseif tstate == "cancelled" then
        print("Transaction cancelled")
 
    elseif tstate == "failed" then        
        print("Transaction Failed")
         --ticker.text = transaction.errorType.. transaction.errorString
        store.consumePurchase( { productID }, transactionCallback )
        
    elseif tstate == "consumed" then
        print("Consumed")
        --ticker.text = "Consumed bitch!!"

    end


 
    -- Tell the store we are done with the transaction.
    -- If you are providing downloadable content, do not call this until
    -- the download has completed.
    store.finishTransaction( event.transaction )
end
 
if store.target == "google" then

   store = require( "plugin.google.iap.v3" )
    store.init("google", transactionCallback)
    print("Using Google's Android In-App Billing system.")


end 
 


 
function purchaseItem1(event)
    print( "fuck" )
    removecoinb1()
    --make sure you add { } around your product id as you need to send a table value... not a string!
    store.purchase( "coins600")
    

end

function purchaseItem2(event)
    removecoinb2()
    --make sure you add { } around your product id as you need to send a table value... not a string!
    store.purchase( "coins1500")
    
end

--textercard.text = "fuckoff"


(:: pragma bea:global-element-parameter parameter="$creditCardRequest1" element="ns0:CreditCardRequest" location="../Schema/CreditCardRequest.xsd" ::)
(:: pragma bea:global-element-return element="Request" location="../Schema/DataCashRequest.xsd" ::)

declare namespace ns1 = "http://mheducation.com/Common/01";
declare namespace ns0 = "http://mheducation.com/CreditCardService/CreditCardRequest/01";
declare namespace xf = "http://tempuri.org/MHEducation/CreditCardService/XQuery/InputToDatacashRequest/";

declare function xf:InputToDatacashRequest($creditCardRequest as element(ns0:CreditCardRequest), $datacashPropertiesFile as element(*), $countryGatewayMappingFile as element(*), $Username as xs:string, $Password as xs:string)
    as element(Request)? {
        let $countryGatewayProperties := $countryGatewayMappingFile/CountryList/Country
            return
        <Request version='2'>
            <Authentication>
                     {
                      let $user := $creditCardRequest/MerchantInfo/UserName
                        return 
                           	if (fn:string-length($user) > 0 )
                            then
                            <client>{data($user)}</client>
                            else                            
                            <client>{data($Username)}</client>  
                      }
                      {
                        let $password := $creditCardRequest/MerchantInfo/Password
                        return
                          if (fn:string-length($password) > 0)
                          then
                            <password>{data($password)}</password>
                          else
                          <password>{data($Password)}</password>
                    }
            </Authentication>
            <Transaction>
                <TxnDetails>
                    {
                       let $__nullable := ( data($creditCardRequest/OrderId) )
                        return
                            <merchantreference>{ $__nullable }</merchantreference>
                    }
                    {
                        let $__nullable := ( xs:decimal( data($creditCardRequest/OrderDetails/Total) ) )
                        return
                            if (fn:boolean($__nullable))
                            then
                                <amount currency = "{ let $__nullable := data($creditCardRequest/OrderDetails/Total/@CurrencyCode)
                                                      return
                                                          if (fn:boolean($__nullable))
                                                          then
                                                              $__nullable
                                                          else
                                                              () }">
                                                                       { 
                                                                       if(fn:string-length(substring-after(xs:string($__nullable),'.'))=1)
                                                                       then
                                                                             fn:concat( $__nullable,"0") 
                                                                        else
                                                                             $__nullable                                                             
                                                                       }
                                 </amount>
                            else
                                ()
                    }
                    <Order>
                            {
                                if((fn:string-length($creditCardRequest/CustomerBillingInfo/CustomerName)>0) or (fn:string-length($creditCardRequest/CustomerBillingInfo/Email)>0) or (fn:string-length($creditCardRequest/CustomerBillingInfo/Company)>0) )
                                 then
                             <Customer>
                            {
                                for $CustomerName in $creditCardRequest/CustomerBillingInfo/CustomerName
                                return
                                    let $__nullable := ( data($CustomerName) )
                                    return
                                        if (fn:boolean($__nullable))
                                        then
                                            <forename>{ $__nullable }</forename>
                                        else
                                            ()
                            }
                            {
                                for $Email in $creditCardRequest/CustomerBillingInfo/Email
                                return
                                    let $__nullable := ( data($Email) )
                                    return
                                        if (fn:boolean($__nullable))
                                        then
                                            <email>{ $__nullable }</email>
                                        else
                                            ()
                            }
                           {
                              if(fn:string-length($creditCardRequest/CustomerBillingInfo/Company) >0)
                              then
                             <Company>
                                    {
                                     let $__nullable := ( xs:string( data($creditCardRequest/CustomerBillingInfo/Company) ) )
                                        return
                                    if (fn:boolean($__nullable))
                                    then
                                        <name>{ $__nullable }</name>
                                    else
                                        ()          
                                      }                          
                            </Company>
                                 else
                                  ()
                            }
                         </Customer>
                           else ()
                           }
                           {
                              for $CustomerBillingInfo in $creditCardRequest/CustomerBillingInfo/Address
                               return
                                       if (fn:string-length(data($CustomerBillingInfo)) > 0)
                                      then
                            <BillingAddress>
                            {
                                let $__nullable := ( xs:string( data($creditCardRequest/CustomerBillingInfo/Address/LineOne) ) )
                                return
                                    if (fn:boolean($__nullable))
                                    then
                                        <streetaddress>{ $__nullable }</streetaddress>
                                    else
                                        ()
                            }
                            {
                                for $LineTwo in $creditCardRequest/CustomerBillingInfo/Address/LineTwo
                                return
                                    let $__nullable := ( xs:string( data($LineTwo) ) )
                                    return
                                        if (fn:boolean($__nullable))
                                        then
                                            <moreaddress>{ $__nullable }</moreaddress>
                                        else
                                            ()
                            }
                            {
                                for $City in $creditCardRequest/CustomerBillingInfo/Address/City
                                return
                                    let $__nullable := ( data($City) )
                                    return
                                        if (fn:boolean($__nullable))
                                        then
                                            <city>{ $__nullable }</city>
                                        else
                                            ()
                            }
                            {
                                for $State in $creditCardRequest/CustomerBillingInfo/Address/State
                                return
                                    let $__nullable := ( data($State) )
                                    return
                                        if (fn:boolean($__nullable))
                                        then
                                            <region>{ $__nullable }</region>
                                        else
                                            ()
                            }
                            {
                               for $country in $countryGatewayProperties
                                where $country/@abbreviation = data($creditCardRequest/CustomerBillingInfo/Address/CountryCode)
                               return
                                       let $__nullable := ( data($country/@abbreviation) )
                                     return
                                              if (fn:boolean($__nullable))
                                       then
                                              <country>{data($country/CountryCode)}</country> 
                                        else()
                             }
                            {
                                for $PostalCode in $creditCardRequest/CustomerBillingInfo/Address/PostalCode
                                return
                                    let $__nullable := ( xs:string( data($PostalCode) ) )
                                    return
                                        if (fn:boolean($__nullable))
                                        then
                                            <postcode>{ $__nullable }</postcode>
                                        else
                                            ()
                            }
                        </BillingAddress>
                              else
                               ()
                            }
                           {
                                for $CustomerShippingInfo in $creditCardRequest/CustomerShippingInfo/Address
                                 return
                                    if (fn:string-length(data($CustomerShippingInfo)) > 0)
                                    then
                        <Recipient>
                            {
                                for $CustomerName in $creditCardRequest/CustomerShippingInfo/CustomerName
                                return
                                    let $__nullable := ( data($CustomerName) )
                                    return
                                        if (fn:boolean($__nullable))
                                        then
                                            <forename>{ $__nullable }</forename>
                                        else
                                            ()
                            }
                            <Address>
                                {
                                    let $__nullable := ( xs:string( data($creditCardRequest/CustomerShippingInfo/Address/LineOne) ) )
                                    return
                                        if (fn:boolean($__nullable))
                                        then
                                            <streetaddress>{ $__nullable }</streetaddress>
                                        else
                                            ()
                                }
                                {
                                    for $LineTwo in $creditCardRequest/CustomerShippingInfo/Address/LineTwo
                                    return
                                        let $__nullable := ( xs:string( data($LineTwo) ) )
                                        return
                                            if (fn:boolean($__nullable))
                                            then
                                                <moreaddress>{ $__nullable }</moreaddress>
                                            else
                                                ()
                                }
                                {
                                    for $City in $creditCardRequest/CustomerShippingInfo/Address/City
                                    return
                                        let $__nullable := ( data($City) )
                                        return
                                            if (fn:boolean($__nullable))
                                            then
                                                <city>{ $__nullable }</city>
                                            else
                                                ()
                                }
                                {
                                    for $State in $creditCardRequest/CustomerShippingInfo/Address/State
                                    return
                                        let $__nullable := ( data($State) )
                                        return
                                            if (fn:boolean($__nullable))
                                            then
                                                <region>{ $__nullable }</region>
                                            else
                                                ()
                                }
                                 {
                                    for $country in $countryGatewayProperties
                                        where $country/@abbreviation = data($creditCardRequest/CustomerShippingInfo/Address/CountryCode)
                                        return
                                                 let $__nullable := ( data($country/@abbreviation) )
                                                  return
                                                    if (fn:boolean($__nullable))
                                                     then
                                                    <country>{data($country/CountryCode)}</country> 
                                                  else
                                                    ()
                                  }
                                {
                                    for $PostalCode in $creditCardRequest/CustomerShippingInfo/Address/PostalCode
                                    return
                                        let $__nullable := ( xs:string( data($PostalCode) ) )
                                        return
                                            if (fn:boolean($__nullable))
                                            then
                                                <postcode>{ $__nullable }</postcode>
                                            else
                                                ()
                                }
                            </Address>
                            {
                                for $Email in $creditCardRequest/CustomerShippingInfo/Email
                                return
                                    let $__nullable := ( data($Email) )
                                    return
                                        if (fn:boolean($__nullable))
                                        then
                                            <email>{ $__nullable }</email>
                                        else
                                            ()
                            }
                        </Recipient>
                            else
                              ()
                            }
                        <OrderDetails>
                            {
                                for $OrderItem in $creditCardRequest/OrderDetails/OrderItem
                            return 
                              let $__nullable := ( $OrderItem )
                                return
                              if (fn:boolean($__nullable))
                                   then
                            <LineItem product_code = "{ let $__nullable := xs:string( data($OrderItem/ItemNumber) )
                                                        return
                                                            if (fn:boolean($__nullable))
                                                            then
                                                                $__nullable
                                                            else
                                                                () }"
                                      quantity = "{ let $__nullable := xs:string( data($OrderItem/Quantity) )
                                                    return
                                                        if (fn:boolean($__nullable))
                                                        then
                                                            $__nullable
                                                        else
                                                            () }"
                                      sku = "{ let $__nullable := data($OrderItem/ItemId)
                                               return
                                                   if (fn:boolean($__nullable))
                                                   then
                                                       $__nullable
                                                   else
                                                       () }"
                                      unit_price = "{ let $__nullable := xs:decimal( data($OrderItem/Price) )
                                                      return
                                                          if (fn:boolean($__nullable))
                                                          then
                                                              if(fn:string-length(substring-after(xs:string($__nullable),'.'))=1)
                                                              then
                                                                   fn:concat( $__nullable,"0")
                                                               else
                                                                   $__nullable
                                                               else
                                                              () }">
                                 {
                                          let $__nullable := ( data($OrderItem/Description) )
                                          return
                                                      if (fn:boolean($__nullable))
                                                     then
                                                        <description>{ $__nullable }</description>
                                                      else
                                                            ()
                                  }
                            </LineItem>
                              else ()
                             }
                            {
                                 for $SubTotal in $creditCardRequest/OrderDetails/SubTotal
                                  return
                                  let $__nullable := ( xs:decimal( data($SubTotal) ) )
                                    return
                                        if (fn:boolean($__nullable))
                                        then
                                              <subtotal>
                                                           { 
                                                                       if(fn:string-length(substring-after(xs:string($__nullable),'.'))=1)
                                                                       then
                                                                             fn:concat( $__nullable,"0") 
                                                                        else
                                                                             $__nullable                                                                                                                        }
                                             </subtotal>                                                              
                                        else
                                            ()
                            }
                            {
                                for $ShippingAmount in $creditCardRequest/OrderDetails/ShippingAmount
                                return
                                    let $__nullable := ( xs:decimal( data($ShippingAmount) ) )
                                    return
                                        if (fn:boolean($__nullable))
                                        then
                                            <handling>
                                                           { 
                                                                       if(fn:string-length(substring-after(xs:string($__nullable),'.'))=1)
                                                                       then
                                                                             fn:concat( $__nullable,"0") 
                                                                        else
                                                                             $__nullable                                                             
                                                           }
                                            </handling>
                                        else
                                            ()
                            }
                            {
                                for $StateTaxAmount in $creditCardRequest/OrderDetails/StateTaxAmount
                                return
                                    let $__nullable := ( xs:decimal( data($StateTaxAmount) ) )
                                    return
                                        if (fn:boolean($__nullable))
                                        then
                                            <tax>
                                                    { 
                                                                       if(fn:string-length(substring-after(xs:string($__nullable),'.'))=1)
                                                                       then
                                                                             fn:concat( $__nullable,"0") 
                                                                        else
                                                                             $__nullable                                                             
                                                           }
                                           </tax>
                                        else
                                            ()
                            }
                        </OrderDetails>
                    </Order>
                </TxnDetails>
                <CardTxn>
                    <Card>
                        <pan>{ data($creditCardRequest/CardDetails/CreditCardDetails/CreditCardNumber) }</pan>
                        <expirydate>{ concat($creditCardRequest/CardDetails/CreditCardDetails/CardExpMonth ,'/', $creditCardRequest/CardDetails/CreditCardDetails/CardExpYear) }</expirydate>
                        {
                            for $CardStartMonth in $creditCardRequest/CardDetails/CreditCardDetails/CardStartMonth,
                                $CardStartYear in $creditCardRequest/CardDetails/CreditCardDetails/CardStartYear
                            return
                                let $__nullable := ( concat($CardStartMonth ,'/',$CardStartYear) )
                                return
                                    if (fn:boolean($__nullable))
                                    then
                                        <startdate>{ $__nullable }</startdate>
                                    else
                                        ()
                        }
                        {
                            for $IssueNumber in $creditCardRequest/CardDetails/CreditCardDetails/IssueNumber
                            return
                                let $__nullable := ( data($IssueNumber) )
                                return
                                    if (fn:boolean($__nullable))
                                    then
                                        <issuenumber>{ $__nullable }</issuenumber>
                                    else
                                        ()
                        }
                        <Cv2Avs>
                         <policy>{ data($datacashPropertiesFile/Policy) }</policy>
                            {
                                let $__nullable := ( xs:string( data($creditCardRequest/CustomerBillingInfo/Address/LineOne) ) )
                                return
                                    if (fn:boolean($__nullable))
                                    then
                                        <street_address1>{ $__nullable }</street_address1>
                                    else
                                        ()
                            }
                            {
                                for $LineTwo in $creditCardRequest/CustomerBillingInfo/Address/LineTwo
                                return
                                    let $__nullable := ( xs:string( data($LineTwo) ) )
                                    return
                                        if (fn:boolean($__nullable))
                                        then
                                            <street_address2>{ $__nullable }</street_address2>
                                        else
                                            ()
                            }
                            {
                                for $LineThree in $creditCardRequest/CustomerBillingInfo/Address/LineThree
                                return
                                    let $__nullable := ( xs:string( data($LineThree) ) )
                                    return
                                        if (fn:boolean($__nullable))
                                        then
                                            <street_address3>{ $__nullable }</street_address3>
                                        else
                                            ()
                            }
                            {
                                for $LineFour in $creditCardRequest/CustomerBillingInfo/Address/LineFour
                                return
                                    let $__nullable := ( xs:string( data($LineFour) ) )
                                    return
                                        if (fn:boolean($__nullable))
                                        then
                                            <street_address4>{ $__nullable }</street_address4>
                                        else
                                            ()
                            }
                            {
                                for $PostalCode in $creditCardRequest/CustomerBillingInfo/Address/PostalCode
                                return
                                    let $__nullable := ( xs:string( data($PostalCode) ) )
                                    return
                                        if (fn:boolean($__nullable))
                                        then
                                            <postcode>{ $__nullable }</postcode>
                                        else
                                            ()
                            }
                            {
                                for $SecurityCode in $creditCardRequest/CardDetails/CreditCardDetails/SecurityCode
                                return
                                    let $__nullable := ( data($SecurityCode) )
                                    return
                                        if (fn:boolean($__nullable))
                                        then
                                            <cv2>{ $__nullable }</cv2>
                                        else
                                            ()
                            }
                        </Cv2Avs>
                    </Card>
                           {
                              for $value in $datacashPropertiesFile/TransactionType/value
                               return
                                       if(not(fn:compare($value/@label,data($creditCardRequest/TransactionType))))
                                       then
                                                    <method>{data($value)}</method>
                                        else()
                           }
                </CardTxn>
            </Transaction>
        </Request>
};

declare variable $creditCardRequest as element(ns0:CreditCardRequest) external;
declare variable $datacashPropertiesFile as element(*) external;
declare variable $countryGatewayMappingFile as element(*) external;
declare variable $Username as xs:string external;
declare variable $Password as xs:string external;

xf:InputToDatacashRequest($creditCardRequest, $datacashPropertiesFile, $countryGatewayMappingFile, $Username, $Password)
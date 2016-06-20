(:: pragma bea:global-element-parameter parameter="$creditCardRequest" element="ns0:CreditCardRequest" location="../Schema/CreditCardRequest.xsd" ::)
(:: pragma bea:global-element-return element="ns0:CreditCardRequest" location="../Schema/CreditCardRequest.xsd" ::)

declare namespace ns1 = "http://mheducation.com/Common/01";
declare namespace ns0 = "http://mheducation.com/CreditCardService/CreditCardRequest/01";
declare namespace xf = "http://tempuri.org/MHEducation/CreditCardService/XQuery/RequestToRequest/";

declare function xf:RequestToRequest($creditCardRequest as element(ns0:CreditCardRequest))
    as element(ns0:CreditCardRequest) {
        <ns0:CreditCardRequest>
           {
            for $PaymentGateway in $creditCardRequest/PaymentGateway
            return
              let $__nullable := ( data($PaymentGateway) )
              return
                 if (fn:boolean($__nullable))
                   then
                    <PaymentGateway>{ $__nullable }</PaymentGateway>
                 else
                     ()
            }
           {
            for $OrderCountryCode in $creditCardRequest/OrderCountryCode
            return
              let $__nullable := ( data($OrderCountryCode) )
              return
                 if (fn:boolean($__nullable))
                   then
                    <OrderCountryCode>{ $__nullable }</OrderCountryCode>
                 else
                     ()
            }
            {
                for $MerchantInfo in $creditCardRequest/MerchantInfo
                return
                    let $__nullable := ( data($MerchantInfo) )
                    return
                        if (fn:boolean($__nullable))
                        then
                            <MerchantInfo>
                                {
                                    for $ClientId in $MerchantInfo/ClientId
                                    return
                                        let $__nullable := ( data($ClientId) )
                                        return
                                            if (fn:boolean($__nullable))
                                            then
                                                <ClientId>{ $__nullable }</ClientId>
                                            else
                                                ()
                                }
                                {
                                  for $UserName in $MerchantInfo/UserName
                                    return
                                        let $__nullable := ( data($UserName) )
                                        return
                                            if (fn:boolean($__nullable))
                                            then
                                                <UserName>{ $__nullable }</UserName>
                                            else
                                                ()
                                }
                                {
                                  for $Password in $MerchantInfo/Password
                                    return
                                        let $__nullable := ( data($Password) )
                                        return
                                            if (fn:boolean($__nullable))
                                            then
                                                <Password>{ $__nullable }</Password>
                                            else
                                                ()
                                }                                
                            </MerchantInfo>
                        else
                            ()
            }
            {
                for $OrderId in $creditCardRequest/OrderId
                return
                    let $__nullable := ( data($OrderId) )
                    return
                        if (fn:boolean($__nullable))
                        then
                            <OrderId>{ $__nullable }</OrderId>
                        else
                            ()
            }
            {
                for $PaymentGatewayTransactionId in $creditCardRequest/PaymentGatewayTransactionId
                return
                    let $__nullable := ( data($PaymentGatewayTransactionId) )
                    return
                        if (fn:boolean($__nullable))
                        then
                            <PaymentGatewayTransactionId>{ $__nullable }</PaymentGatewayTransactionId>
                        else
                            ()
            }
            {
                for $AuthCode in $creditCardRequest/AuthCode
                return
                    let $__nullable := ( data($AuthCode) )
                    return
                        if (fn:boolean($__nullable))
                        then
                            <AuthCode>{ $__nullable }</AuthCode>
                        else
                            ()
            }
            {
                for $TransactionType in $creditCardRequest/TransactionType
                return
                    let $__nullable := ( data($TransactionType) )
                    return
                        if (fn:boolean($__nullable))
                        then
                            <TransactionType>{ $__nullable }</TransactionType>
                        else
                            ()
            }
            {
                for $CustomerBillingInfo in $creditCardRequest/CustomerBillingInfo
                return
                    let $__nullable := ( data($CustomerBillingInfo) )
                    return
                        if (fn:boolean($__nullable))
                        then
                            <CustomerBillingInfo>
                                {
                                    for $CustomerName in $CustomerBillingInfo/CustomerName
                                    return
                                        let $__nullable := ( data($CustomerName) )
                                        return
                                            if (fn:boolean($__nullable))
                                            then
                                                <CustomerName>{ $__nullable }</CustomerName>
                                            else
                                                ()
                                }
                                {
                                    for $Company in $CustomerBillingInfo/Company
                                    return
                                        let $__nullable := ( data($Company) )
                                        return
                                            if (fn:boolean($__nullable))
                                            then
                                                <Company>{ $__nullable }</Company>
                                            else
                                                ()
                                }
                                {
                                    for $Email in $CustomerBillingInfo/Email
                                    return
                                        let $__nullable := ( data($Email) )
                                        return
                                            if (fn:boolean($__nullable))
                                            then
                                                <Email>{ $__nullable }</Email>
                                            else
                                                ()
                                }
                                {
                                    for $URL in $CustomerBillingInfo/URL
                                    return
                                        let $__nullable := ( data($URL) )
                                        return
                                            if (fn:boolean($__nullable))
                                            then
                                                <URL>{ $__nullable }</URL>
                                            else
                                                ()
                                }
                                {
                                    for $Address in $CustomerBillingInfo/Address
                                    return
                                        let $__nullable := ( data($Address) )
                                        return
                                            if (fn:boolean($__nullable))
                                            then
                                                <Address>                                                                                                        
                                                  {
                                                        for $LineOne in $Address/LineOne
                                                        return
                                                            let $__nullable := ( data($LineOne) )
                                                            return
                                                                if (fn:boolean($__nullable))
                                                                then
                                                                    <LineOne>{ $__nullable }</LineOne>
                                                                else
                                                                    ()
                                                    }
                                                    {
                                                        for $LineTwo in $Address/LineTwo
                                                        return
                                                            let $__nullable := ( data($LineTwo) )
                                                            return
                                                                if (fn:boolean($__nullable))
                                                                then
                                                                    <LineTwo>{ $__nullable }</LineTwo>
                                                                else
                                                                    ()
                                                    }
                                                    {
                                                        for $LineThree in $Address/LineThree
                                                        return
                                                            let $__nullable := ( data($LineThree) )
                                                            return
                                                                if (fn:boolean($__nullable))
                                                                then
                                                                    <LineThree>{ $__nullable }</LineThree>
                                                                else
                                                                    ()
                                                    }
                                                    {
                                                        for $LineFour in $Address/LineFour
                                                        return
                                                            let $__nullable := ( data($LineFour) )
                                                            return
                                                                if (fn:boolean($__nullable))
                                                                then
                                                                    <LineFour>{ $__nullable }</LineFour>
                                                                else
                                                                    ()
                                                    }
                                                    {
                                                        for $City in $Address/City
                                                        return
                                                            let $__nullable := ( data($City) )
                                                            return
                                                                if (fn:boolean($__nullable))
                                                                then
                                                                    <City>{ $__nullable }</City>
                                                                else
                                                                    ()
                                                    }
                                                    {
                                                        for $County in $Address/County
                                                        return
                                                            let $__nullable := ( data($County) )
                                                            return
                                                                if (fn:boolean($__nullable))
                                                                then
                                                                    <County>{ $__nullable }</County>
                                                                else
                                                                    ()
                                                    }
                                                    {
                                                        for $State in $Address/State
                                                        return
                                                            let $__nullable := ( data($State) )
                                                            return
                                                                if (fn:boolean($__nullable))
                                                                then
                                                                    <State>{ $__nullable }</State>
                                                                else
                                                                    ()
                                                    }
                                                    {
                                                        for $PostalCode in $Address/PostalCode
                                                        return
                                                            let $__nullable := ( data($PostalCode) )
                                                            return
                                                                if (fn:boolean($__nullable))
                                                                then
                                                                    <PostalCode>{ $__nullable }</PostalCode>
                                                                else
                                                                    ()
                                                    }
                                                                                                      {
                                                        for $CountryCode in $Address/CountryCode
                                                        return
                                                            let $__nullable := ( data($CountryCode) )
                                                            return
                                                                if (fn:boolean($__nullable))
                                                                then
                                                                    <CountryCode>{ $__nullable }</CountryCode>
                                                                else
                                                                    ()
                                                    }
                                                </Address>
                                            else
                                                ()
                                }
                            </CustomerBillingInfo>
                        else
                            ()
            }
            {
                for $CustomerShippingInfo in $creditCardRequest/CustomerShippingInfo
                return
                    let $__nullable := ( data($CustomerShippingInfo) )
                    return
                        if (fn:boolean($__nullable))
                        then
                            <CustomerShippingInfo>
                                {
                                    for $CustomerName in $CustomerShippingInfo/CustomerName
                                    return
                                        let $__nullable := ( data($CustomerName) )
                                        return
                                            if (fn:boolean($__nullable))
                                            then
                                                <CustomerName>{ $__nullable }</CustomerName>
                                            else
                                                ()
                                }
                                {
                                    for $Company in $CustomerShippingInfo/Company
                                    return
                                        let $__nullable := ( data($Company) )
                                        return
                                            if (fn:boolean($__nullable))
                                            then
                                                <Company>{ $__nullable }</Company>
                                            else
                                                ()
                                }
                                {
                                    for $Email in $CustomerShippingInfo/Email
                                    return
                                        let $__nullable := ( data($Email) )
                                        return
                                            if (fn:boolean($__nullable))
                                            then
                                                <Email>{ $__nullable }</Email>
                                            else
                                                ()
                                }
                                {
                                    for $URL in $CustomerShippingInfo/URL
                                    return
                                        let $__nullable := ( data($URL) )
                                        return
                                            if (fn:boolean($__nullable))
                                            then
                                                <URL>{ $__nullable }</URL>
                                            else
                                                ()
                                }
                                {
                                    for $Address in $CustomerShippingInfo/Address
                                    return
                                        let $__nullable := ( data($Address) )
                                        return
                                            if (fn:boolean($__nullable))
                                            then
                                                <Address>
                                                  {
                                                        for $LineOne in $Address/LineOne
                                                        return
                                                            let $__nullable := ( data($LineOne) )
                                                            return
                                                                if (fn:boolean($__nullable))
                                                                then
                                                                    <LineOne>{ $__nullable }</LineOne>
                                                                else
                                                                    ()
                                                    }
                                                    {
                                                        for $LineTwo in $Address/LineTwo
                                                        return
                                                            let $__nullable := ( data($LineTwo) )
                                                            return
                                                                if (fn:boolean($__nullable))
                                                                then
                                                                    <LineTwo>{ $__nullable }</LineTwo>
                                                                else
                                                                    ()
                                                    }
                                                    {
                                                        for $LineThree in $Address/LineThree
                                                        return
                                                            let $__nullable := ( data($LineThree) )
                                                            return
                                                                if (fn:boolean($__nullable))
                                                                then
                                                                    <LineThree>{ $__nullable }</LineThree>
                                                                else
                                                                    ()
                                                    }
                                                    {
                                                        for $LineFour in $Address/LineFour
                                                        return
                                                            let $__nullable := ( data($LineFour) )
                                                            return
                                                                if (fn:boolean($__nullable))
                                                                then
                                                                    <LineFour>{ $__nullable }</LineFour>
                                                                else
                                                                    ()
                                                    }
                                                    {
                                                        for $City in $Address/City
                                                        return
                                                            let $__nullable := ( data($City) )
                                                            return
                                                                if (fn:boolean($__nullable))
                                                                then
                                                                    <City>{ $__nullable }</City>
                                                                else
                                                                    ()
                                                    }
                                                    {
                                                        for $County in $Address/County
                                                        return
                                                            let $__nullable := ( data($County) )
                                                            return
                                                                if (fn:boolean($__nullable))
                                                                then
                                                                    <County>{ $__nullable }</County>
                                                                else
                                                                    ()
                                                    }
                                                    {
                                                        for $State in $Address/State
                                                        return
                                                            let $__nullable := ( data($State) )
                                                            return
                                                                if (fn:boolean($__nullable))
                                                                then
                                                                    <State>{ $__nullable }</State>
                                                                else
                                                                    ()
                                                    }
                                                    {
                                                        for $PostalCode in $Address/PostalCode
                                                        return
                                                            let $__nullable := ( data($PostalCode) )
                                                            return
                                                                if (fn:boolean($__nullable))
                                                                then
                                                                    <PostalCode>{ $__nullable }</PostalCode>
                                                                else
                                                                    ()
                                                    }
                                                    {
                                                        for $CountryCode in $Address/CountryCode
                                                        return
                                                            let $__nullable := ( data($CountryCode) )
                                                            return
                                                                if (fn:boolean($__nullable))
                                                                then
                                                                    <CountryCode>{ $__nullable }</CountryCode>
                                                                else
                                                                    ()
                                                    }
                                                </Address>
                                            else
                                                ()
                                }
                            </CustomerShippingInfo>
                        else
                            ()
            }
            {
            let $CardDetails := ( data($creditCardRequest/CardDetails) )
            return 
            if (fn:boolean($CardDetails))
            then
            <CardDetails>
                {
                    let $CreditCardDetails := $creditCardRequest/CardDetails/CreditCardDetails
                    return
                    let $__nullable := ( data($CreditCardDetails) )
                    return
                      if (fn:boolean($__nullable))
                      then
                        <CreditCardDetails>
                            {
                                for $CreditCardNumber in $CreditCardDetails/CreditCardNumber
                                return
                                    let $__nullable := ( data($CreditCardNumber) )
                                    return
                                        if (fn:boolean($__nullable))
                                        then
                                            <CreditCardNumber>{ $__nullable }</CreditCardNumber>
                                        else
                                            ()
                            }
                            {
                                for $CreditCardType in $CreditCardDetails/CreditCardType
                                return
                                    let $__nullable := ( data($CreditCardType) )
                                    return
                                        if (fn:boolean($__nullable))
                                        then
                                            <CreditCardType>{ $__nullable }</CreditCardType>
                                        else
                                            ()
                            }
                            {
                                for $CardExpMonth in $CreditCardDetails/CardExpMonth
                                return
                                    let $__nullable := ( data($CardExpMonth) )
                                    return
                                        if (fn:boolean($__nullable))
                                        then
                                            <CardExpMonth>{ $__nullable }</CardExpMonth>
                                        else
                                            ()
                            }
                            {
                                for $CardExpYear in $CreditCardDetails/CardExpYear
                                return
                                    let $__nullable := ( data($CardExpYear) )
                                    return
                                        if (fn:boolean($__nullable))
                                        then
                                            <CardExpYear>{ $__nullable }</CardExpYear>
                                        else
                                            ()
                            }
                            {
                                for $CardStartMonth in $CreditCardDetails/CardStartMonth
                                return
                                    let $__nullable := ( data($CardStartMonth) )
                                    return
                                        if (fn:boolean($__nullable))
                                        then
                                            <CardStartMonth>{ $__nullable }</CardStartMonth>
                                        else
                                            ()
                            }
                            {
                                for $CardStartYear in $CreditCardDetails/CardStartYear
                                return
                                    let $__nullable := ( data($CardStartYear) )
                                    return
                                        if (fn:boolean($__nullable))
                                        then
                                            <CardStartYear>{ $__nullable }</CardStartYear>
                                        else
                                            ()
                            }
                            {
                                for $SecurityCode in $CreditCardDetails/SecurityCode
                                return
                                    let $__nullable := ( data($SecurityCode) )
                                    return
                                        if (fn:boolean($__nullable))
                                        then
                                            <SecurityCode>{ $__nullable }</SecurityCode>
                                        else
                                            ()
                            }
                            {
                                for $IssueNumber in $CreditCardDetails/IssueNumber
                                return
                                    let $__nullable := ( data($IssueNumber) )
                                    return
                                        if (fn:boolean($__nullable))
                                        then
                                            <IssueNumber>{ $__nullable }</IssueNumber>
                                        else
                                            ()
                            }
                        </CreditCardDetails>
                        else()
                }
            </CardDetails>
            else ()
            }   
            {
            let $OrderDetails := ( data($creditCardRequest/OrderDetails) )
            return  
            if (fn:boolean($OrderDetails))
            then 
            <OrderDetails>
                {
                    for $PurchaseOrderNumber in $creditCardRequest/OrderDetails/PurchaseOrderNumber
                    return
                        let $__nullable := ( data($PurchaseOrderNumber) )
                        return
                            if (fn:boolean($__nullable))
                            then
                                <PurchaseOrderNumber>{ $__nullable }</PurchaseOrderNumber>
                            else
                                ()
                }
                {
                    for $OrderDate in $creditCardRequest/OrderDetails/OrderDate
                    return
                        let $__nullable := ( data($OrderDate) )
                        return
                            if (fn:boolean($__nullable))
                            then
                                <OrderDate>{ $__nullable }</OrderDate>
                            else
                                ()
                }
                {
                    for $SubTotal in $creditCardRequest/OrderDetails/SubTotal
                    return
                        let $__nullable := ( data($SubTotal) )
                        return
                            if (fn:boolean($__nullable))
                            then
                                <SubTotal CurrencyCode = "{ data($SubTotal/@CurrencyCode) }">{ $__nullable }</SubTotal>
                            else
                                ()
                }
                {
                    for $Total in $creditCardRequest/OrderDetails/Total
                    return
                        let $__nullable := ( data($Total) )
                        return
                            if (fn:boolean($__nullable))
                            then
                                <Total CurrencyCode = "{ data($Total/@CurrencyCode) }">{ $__nullable }</Total>
                            else
                                ()
                }
                {
                    for $ShippingAmount in $creditCardRequest/OrderDetails/ShippingAmount
                    return
                        let $__nullable := ( data($ShippingAmount) )
                        return
                            if (fn:boolean($__nullable))
                            then
                                <ShippingAmount CurrencyCode = "{ data($ShippingAmount/@CurrencyCode) }">{ $__nullable }</ShippingAmount>
                            else
                                ()
                }
                {
                    for $StateTaxAmount in $creditCardRequest/OrderDetails/StateTaxAmount
                    return
                        let $__nullable := ( data($StateTaxAmount) )
                        return
                            if (fn:boolean($__nullable))
                            then
                                <StateTaxAmount CurrencyCode = "{ data($StateTaxAmount/@CurrencyCode) }">{ $__nullable }</StateTaxAmount>
                            else
                                ()
                }
                {
                    for $TaxExemptIndicator in $creditCardRequest/OrderDetails/TaxExemptIndicator
                    return
                        let $__nullable := ( data($TaxExemptIndicator) )
                        return
                            if (fn:boolean($__nullable))
                            then
                                <TaxExemptIndicator>{ $__nullable }</TaxExemptIndicator>
                            else
                                ()
                }
                {
                    for $OrderItem in $creditCardRequest/OrderDetails/OrderItem
                    return
                        let $__nullable := ( data($OrderItem) )
                        return
                            if (fn:boolean($__nullable))
                            then
                                <OrderItem>
                                    {
                                        for $ItemNumber in $OrderItem/ItemNumber
                                        return
                                            let $__nullable := ( data($ItemNumber) )
                                            return
                                                if (fn:boolean($__nullable))
                                                then
                                                    <ItemNumber>{ $__nullable }</ItemNumber>
                                                else
                                                    ()
                                    }
                                    {
                                        for $ItemId in $OrderItem/ItemId
                                        return
                                            let $__nullable := ( data($ItemId) )
                                            return
                                                if (fn:boolean($__nullable))
                                                then
                                                    <ItemId>{ $__nullable }</ItemId>
                                                else
                                                    ()
                                    }
                                    {
                                        for $Price in $OrderItem/Price
                                        return
                                            let $__nullable := ( data($Price) )
                                            return
                                                if (fn:boolean($__nullable))
                                                then
                                                    <Price CurrencyCode = "{ data($Price/@CurrencyCode) }">{ $__nullable }</Price>
                                                else
                                                    ()
                                    }
                                    {
                                        for $Quantity in $OrderItem/Quantity
                                        return
                                            let $__nullable := ( data($Quantity) )
                                            return
                                                if (fn:boolean($__nullable))
                                                then
                                                    <Quantity>{ $__nullable }</Quantity>
                                                else
                                                    ()
                                    }
                                    {
                                        for $ShippingAmount in $OrderItem/ShippingAmount
                                        return
                                            let $__nullable := ( data($ShippingAmount) )
                                            return
                                                if (fn:boolean($__nullable))
                                                then
                                                    <ShippingAmount CurrencyCode = "{ data($ShippingAmount/@CurrencyCode) }">{ $__nullable }</ShippingAmount>
                                                else
                                                    ()
                                    }
                                    {
                                        for $StateTaxAmount in $OrderItem/StateTaxAmount
                                        return
                                            let $__nullable := ( data($StateTaxAmount) )
                                            return
                                                if (fn:boolean($__nullable))
                                                then
                                                    <StateTaxAmount CurrencyCode = "{ data($StateTaxAmount/@CurrencyCode) }">{ $__nullable }</StateTaxAmount>
                                                else
                                                    ()
                                    }
                                    {
                                        for $TaxExemptIndicator in $OrderItem/TaxExemptIndicator
                                        return
                                            let $__nullable := ( data($TaxExemptIndicator) )
                                            return
                                                if (fn:boolean($__nullable))
                                                then
                                                    <TaxExemptIndicator>{ $__nullable }</TaxExemptIndicator>
                                                else
                                                    ()
                                    }
                                    {
                                        for $Description in $OrderItem/Description
                                        return
                                            let $__nullable := ( data($Description) )
                                            return
                                                if (fn:boolean($__nullable))
                                                then
                                                    <Description>{ $__nullable }</Description>
                                                else
                                                    ()
                                    }
                                </OrderItem>
                            else
                                ()
                }
            </OrderDetails>
            else()
        }
        </ns0:CreditCardRequest>
};

declare variable $creditCardRequest as element(ns0:CreditCardRequest) external;

xf:RequestToRequest($creditCardRequest)
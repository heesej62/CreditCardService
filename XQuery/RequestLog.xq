(:: pragma bea:global-element-parameter parameter="$creditCardRequest1" element="ns0:CreditCardRequest" location="../Schema/CreditCardRequest.xsd" ::)
(:: pragma bea:global-element-return element="ns0:CreditCardRequest" location="../Schema/CreditCardRequest.xsd" ::)

declare namespace ns1 = "http://mheducation.com/Common/01";
declare namespace ns0 = "http://mheducation.com/CreditCardService/CreditCardRequest/01";
declare namespace xf = "http://tempuri.org/MHEducation/CreditCardService/XQuery/RequestLog/";

declare function xf:RequestLog($creditCardRequest as element(ns0:CreditCardRequest))
    as element(ns0:CreditCardRequest) {
        <ns0:CreditCardRequest>
            <PaymentGateway>{ data($creditCardRequest/PaymentGateway) }</PaymentGateway>
            <OrderCountryCode>{ data($creditCardRequest/OrderCountryCode) }</OrderCountryCode>
            {
                for $MerchantInfo in $creditCardRequest/MerchantInfo
                return
                    <MerchantInfo>
                        {
                            for $ClientId in $MerchantInfo/ClientId
                            return
                                <ClientId>{ data($ClientId) }</ClientId>
                        }
                        <UserName>{ data($MerchantInfo/UserName) }</UserName>
                        <Password>{ data($MerchantInfo/Password) }</Password>
                    </MerchantInfo>
            }
            <OrderId>{ data($creditCardRequest/OrderId) }</OrderId>
            {
                for $PaymentGatewayTransactionId in $creditCardRequest/PaymentGatewayTransactionId
                return
                    <PaymentGatewayTransactionId>{ data($PaymentGatewayTransactionId) }</PaymentGatewayTransactionId>
            }
            {
                for $AuthCode in $creditCardRequest/AuthCode
                return
                    <AuthCode>{ data($AuthCode) }</AuthCode>
            }
            <TransactionType>{ data($creditCardRequest/TransactionType) }</TransactionType>
            {
                for $CustomerBillingInfo in $creditCardRequest/CustomerBillingInfo
                return
                    <CustomerBillingInfo>
                        {
                            for $CustomerName in $CustomerBillingInfo/CustomerName
                            return
                                <CustomerName>{ data($CustomerName) }</CustomerName>
                        }
                        {
                            for $Company in $CustomerBillingInfo/Company
                            return
                                <Company>{ data($Company) }</Company>
                        }
                        {
                            for $Email in $CustomerBillingInfo/Email
                            return
                                <Email>{ data($Email) }</Email>
                        }
                        {
                            for $URL in $CustomerBillingInfo/URL
                            return
                                <URL>{ data($URL) }</URL>
                        }
                        {
                            for $Address in $CustomerBillingInfo/Address
                            return
                                <Address>
                                    <LineOne>{ data($Address/LineOne) }</LineOne>
                                    {
                                        for $LineTwo in $Address/LineTwo
                                        return
                                            <LineTwo>{ data($LineTwo) }</LineTwo>
                                    }
                                    {
                                        for $LineThree in $Address/LineThree
                                        return
                                            <LineThree>{ data($LineThree) }</LineThree>
                                    }
                                    {
                                        for $LineFour in $Address/LineFour
                                        return
                                            <LineFour>{ data($LineFour) }</LineFour>
                                    }
                                    {
                                        for $City in $Address/City
                                        return
                                            <City>{ data($City) }</City>
                                    }
                                    {
                                        for $County in $Address/County
                                        return
                                            <County>{ data($County) }</County>
                                    }
                                    {
                                        for $State in $Address/State
                                        return
                                            <State>{ data($State) }</State>
                                    }
                                    {
                                        for $PostalCode in $Address/PostalCode
                                        return
                                            <PostalCode>{ data($PostalCode) }</PostalCode>
                                    }
                                    <CountryCode>{ data($Address/CountryCode) }</CountryCode>
                                </Address>
                        }
                    </CustomerBillingInfo>
            }
            {
                for $CustomerShippingInfo in $creditCardRequest/CustomerShippingInfo
                return
                    <CustomerShippingInfo>
                        {
                            for $CustomerName in $CustomerShippingInfo/CustomerName
                            return
                                <CustomerName>{ data($CustomerName) }</CustomerName>
                        }
                        {
                            for $Company in $CustomerShippingInfo/Company
                            return
                                <Company>{ data($Company) }</Company>
                        }
                        {
                            for $Email in $CustomerShippingInfo/Email
                            return
                                <Email>{ data($Email) }</Email>
                        }
                        {
                            for $URL in $CustomerShippingInfo/URL
                            return
                                <URL>{ data($URL) }</URL>
                        }
                        {
                            for $Address in $CustomerShippingInfo/Address
                            return
                                <Address>
                                    <LineOne>{ data($Address/LineOne) }</LineOne>
                                    {
                                        for $LineTwo in $Address/LineTwo
                                        return
                                            <LineTwo>{ data($LineTwo) }</LineTwo>
                                    }
                                    {
                                        for $LineThree in $Address/LineThree
                                        return
                                            <LineThree>{ data($LineThree) }</LineThree>
                                    }
                                    {
                                        for $LineFour in $Address/LineFour
                                        return
                                            <LineFour>{ data($LineFour) }</LineFour>
                                    }
                                    {
                                        for $City in $Address/City
                                        return
                                            <City>{ data($City) }</City>
                                    }
                                    {
                                        for $County in $Address/County
                                        return
                                            <County>{ data($County) }</County>
                                    }
                                    {
                                        for $State in $Address/State
                                        return
                                            <State>{ data($State) }</State>
                                    }
                                    {
                                        for $PostalCode in $Address/PostalCode
                                        return
                                            <PostalCode>{ data($PostalCode) }</PostalCode>
                                    }
                                    <CountryCode>{ data($Address/CountryCode) }</CountryCode>
                                </Address>
                        }
                    </CustomerShippingInfo>
            }
            <OrderDetails>
                {
                    for $PurchaseOrderNumber in $creditCardRequest/OrderDetails/PurchaseOrderNumber
                    return
                        <PurchaseOrderNumber>{ data($PurchaseOrderNumber) }</PurchaseOrderNumber>
                }
                {
                    for $OrderDate in $creditCardRequest/OrderDetails/OrderDate
                    return
                        <OrderDate>{ data($OrderDate) }</OrderDate>
                }
                {
                    for $SubTotal in $creditCardRequest/OrderDetails/SubTotal
                    return
                        <SubTotal CurrencyCode = "{ data($SubTotal/@CurrencyCode) }">{ data($SubTotal) }</SubTotal>
                }
                <Total CurrencyCode = "{ data($creditCardRequest/OrderDetails/Total/@CurrencyCode) }">{ data($creditCardRequest/OrderDetails/Total) }</Total>
                {
                    for $ShippingAmount in $creditCardRequest/OrderDetails/ShippingAmount
                    return
                        <ShippingAmount CurrencyCode = "{ data($ShippingAmount/@CurrencyCode) }">{ data($ShippingAmount) }</ShippingAmount>
                }
                {
                    for $StateTaxAmount in $creditCardRequest/OrderDetails/StateTaxAmount
                    return
                        <StateTaxAmount CurrencyCode = "{ data($StateTaxAmount/@CurrencyCode) }">{ data($StateTaxAmount) }</StateTaxAmount>
                }
                {
                    for $TaxExemptIndicator in $creditCardRequest/OrderDetails/TaxExemptIndicator
                    return
                        <TaxExemptIndicator>{ data($TaxExemptIndicator) }</TaxExemptIndicator>
                }
                {
                    for $OrderItem in $creditCardRequest/OrderDetails/OrderItem
                    return
                        <OrderItem>
                            <ItemNumber>{ data($OrderItem/ItemNumber) }</ItemNumber>
                            <ItemId>{ data($OrderItem/ItemId) }</ItemId>
                            <Price CurrencyCode = "{ data($OrderItem/Price/@CurrencyCode) }">{ data($OrderItem/Price) }</Price>
                            <Quantity>{ data($OrderItem/Quantity) }</Quantity>
                            {
                                for $ShippingAmount in $OrderItem/ShippingAmount
                                return
                                    <ShippingAmount CurrencyCode = "{ data($ShippingAmount/@CurrencyCode) }">{ data($ShippingAmount) }</ShippingAmount>
                            }
                            {
                                for $StateTaxAmount in $OrderItem/StateTaxAmount
                                return
                                    <StateTaxAmount CurrencyCode = "{ data($StateTaxAmount/@CurrencyCode) }">{ data($StateTaxAmount) }</StateTaxAmount>
                            }
                            {
                                for $TaxExemptIndicator in $OrderItem/TaxExemptIndicator
                                return
                                    <TaxExemptIndicator>{ data($TaxExemptIndicator) }</TaxExemptIndicator>
                            }
                        </OrderItem>
                }
            </OrderDetails>
        </ns0:CreditCardRequest>
};

declare variable $creditCardRequest as element(ns0:CreditCardRequest) external;

xf:RequestLog($creditCardRequest)
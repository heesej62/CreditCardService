(:: pragma bea:global-element-parameter parameter="$creditCardRequest" element="ns1:CreditCardRequest" location="../Schema/CreditCardRequest.xsd" ::)
(:: pragma bea:global-element-return element="ns0:SecurePayMessage" location="../Schema/SecurePay.xsd" ::)

declare namespace ns2 = "http://mheducation.com/Common/01";
declare namespace ns1 = "http://mheducation.com/CreditCardService/CreditCardRequest/01";
declare namespace xf = "http://tempuri.org/MHEducation/CreditCardService/XQuery/InputToSecurePayRequest/";
declare namespace fn-bea="http://www.bea.com/xquery/xquery-functions";

declare function xf:InputToSecurePayRequest($creditCardRequest as element(ns1:CreditCardRequest), $commonDataMapPropertiesFile as element(*), $SecurePayPropertiesFile as element(*), $Username as xs:string, $Password as xs:string)
    as element(SecurePayMessage)
 {
	let $properties := $SecurePayPropertiesFile/Properties
	return
        <SecurePayMessage>
            <MessageInfo>
                {
                    let $OrderId := $creditCardRequest/OrderId
                    return
                        <messageID>{data($OrderId)}</messageID>
                }
                        <messageTimestamp>{data(fn:concat(fn:year-from-dateTime(fn:current-dateTime()),fn:day-from-dateTime(fn:current-dateTime()),fn:month-from-dateTime(fn:current-dateTime()),fn:hours-from-dateTime(fn:current-dateTime()),fn:minutes-from-dateTime(fn:current-dateTime()),fn:seconds-from-dateTime(fn:current-dateTime())*1000))}</messageTimestamp> 
                        <timeoutValue>{data($properties/TimeoutValue)}</timeoutValue> 
                        <apiVersion>{data($properties/APIVersion)}</apiVersion>
            </MessageInfo>
            <MerchantInfo>
                {
                    let $securepayUser := $creditCardRequest/MerchantInfo/UserName
                    return
                           if (fn:string-length($securepayUser) > 0 )
                           then
                                 <merchantID>{data($securepayUser)}</merchantID>
                           else
                                <merchantID>{data($Username)}</merchantID>
                }
                {
                    let $securepayPassword := $creditCardRequest/MerchantInfo/Password
                    return
                           if (fn:string-length($securepayPassword) > 0 )
                           then
                                 <password>{data($securepayPassword)}</password>
                           else
                                <password>{data($Password)}</password> 
                }
            </MerchantInfo>
            <RequestType>{data($properties/RequestType)}</RequestType>
            <Payment>
                <TxnList count="{data($properties/TransactionCount)}">
                    <Txn ID="{data($properties/TransactionID)}">
                      {
                       for $value in $SecurePayPropertiesFile/TransactionType/value
                        return
      	                if(not(fn:compare($value/@label,data($creditCardRequest/TransactionType))))
	                then
		      <txnType>{data($value)}</txnType>
                                else()
                      }
	                       <txnSource>{data($properties/TransactionSource)}</txnSource>		
                        {  
                            for $temp in $commonDataMapPropertiesFile/CurrencyList/Currency
                            return
                                    if(not(fn:compare($temp/@name,data($creditCardRequest/OrderDetails/Total/@CurrencyCode))))  
                                    then
                                          if (fn:string-length(data($temp/@factor))>0)
                                          then 
                                                <amount>{xs:int(round(data($creditCardRequest/OrderDetails/Total)*data($temp/@factor)))}</amount>
                                          else
                                                <amount>{xs:int(round(data($creditCardRequest/OrderDetails/Total)*100))}</amount>   
                                    else
                                          ()                    
                        }
                        {
                        	let $currency := $creditCardRequest/OrderDetails/Total/@CurrencyCode
                        	return
                        	   <currency>{data($currency)}</currency>
                        } 		
                        {
                                let $__nullable := $creditCardRequest/OrderDetails/PurchaseOrderNumber
                                return
                                        if (fn:string-length($__nullable)>0)
                                        then
                                            <purchaseOrderNo>{data($__nullable)}</purchaseOrderNo>
                                        else
                                            ()
                         }
                        <CreditCardInfo>
                            {
                                let $CreditCardNumber := $creditCardRequest/CardDetails/CreditCardDetails/CreditCardNumber
                                return
                                    <cardNumber>{data($CreditCardNumber)}</cardNumber>
                            }
                            {
                                   let $__nullable := $creditCardRequest/CardDetails/CreditCardDetails/SecurityCode
                                   return
                                        if (fn:string-length($__nullable)>0)
                                        then
                                            <cvv>{data($__nullable)}</cvv>
                                        else
                                            ()
                            }
                            {
                              let $expiryDate := concat(string($creditCardRequest/CardDetails/CreditCardDetails/CardExpMonth),'/',string($creditCardRequest/CardDetails/CreditCardDetails/CardExpYear))
                              return
                                    <expiryDate>{data($expiryDate)}</expiryDate>
                            }
                        </CreditCardInfo>
                    </Txn>
                </TxnList>
            </Payment>
        </SecurePayMessage>
};

declare variable $creditCardRequest as element(ns1:CreditCardRequest) external;
declare variable $commonDataMapPropertiesFile as element(*) external;
declare variable $SecurePayPropertiesFile as element(*) external;
declare variable $Username as xs:string external;
declare variable $Password as xs:string external;

xf:InputToSecurePayRequest($creditCardRequest, $commonDataMapPropertiesFile, $SecurePayPropertiesFile, $Username, $Password )
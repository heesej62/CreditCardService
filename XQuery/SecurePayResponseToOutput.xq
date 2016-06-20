(:: pragma bea:global-element-parameter parameter="$securePayMessage" element="SecurePayMessage" location="../Schema/SecurePayResponse.xsd" ::)
(:: pragma bea:glAobal-element-return element="ns1:CreditCardResponse" location="../Schema/CreditCardResponse.xsd" ::)

declare namespace ns1 = "http://mheducation.com/CreditCardService/CreditCardResponse/01";
declare namespace ns0 = "http://mheducation.com/Common/01";
declare namespace xf = "http://tempuri.org/MHEducation/CreditCardService/XQuery/SecurePayResponseToOutput/";

declare function xf:SecurePayResponseToOutput($securePayMessage as element(SecurePayMessage), $commonDataMapPropertiesFile as element(*), $SecurePayPropertiesFile as element(*), $PaymentGateway as xs:string, $orderCountryCode as xs:string, $amount as xs:string, $currencyCode as xs:string, $responseStatusCode as xs:string)
    as element(ns1:CreditCardResponse) {
        <ns1:CreditCardResponse>
            {
                let $__nullable := ( data($orderCountryCode) )
                return
                       if (fn:boolean($__nullable))
                       then
                             <OrderCountryCode>{ $__nullable }</OrderCountryCode>
                       else
                             ()
            } 
            {
            	let $messageID := $securePayMessage/MessageInfo/messageID
            	return
            		<OrderId>{data($messageID)}</OrderId>
            }
           <ResponseStatus>{data($responseStatusCode)}</ResponseStatus>

                           {
                                let $__nullable := $securePayMessage/Payment/TxnList/Txn/CreditCardInfo/cardType
                                return
                                       if (fn:string-length($__nullable)>0)
                                       then
                                          <CreditCardDetails>
                                           {
                                               for $value in $SecurePayPropertiesFile/CardType/value
                                                  return
                                                         if(not(fn:compare($value,data($securePayMessage/Payment/TxnList/Txn/CreditCardInfo/cardType))))
                                                         then
                                                              <CreditCardType>{fn:upper-case(data($value/@label))}</CreditCardType>
                                                         else
                                                              () 
                                            }
                                           </CreditCardDetails>  
                                         else()
                              }
            {  
               if (fn:string-length(data($securePayMessage/Payment/TxnList/Txn/amount))>0)
               then
               for $temp in $commonDataMapPropertiesFile/CurrencyList/Currency
               return
                       if(not(fn:compare($temp/@name,data($securePayMessage/Payment/TxnList/Txn/currency))))  
                       then
                            if (fn:string-length(data($temp/@factor))>0)
                            then 
                                  <Amount CurrencyCode ="{data($securePayMessage/Payment/TxnList/Txn/currency)}">{
                                                                 let $amount := xs:string(data($securePayMessage/Payment/TxnList/Txn/amount) div data($temp/@factor))
                                                                 return
                                                                 if (fn:string-length(substring-after($amount,'.'))=0)
                                                                 then
                                                                 fn:concat( $amount,".00") 
                                                                 else 
                                                                 if (fn:string-length(substring-after($amount,'.'))=1)
                                                                 then 
                                                                 fn:concat( $amount,"0")
                                                                 else    $amount
                                                                 }</Amount>
                            else
                                  <Amount CurrencyCode ="{data($securePayMessage/Payment/TxnList/Txn/currency)}">{
                                                                 let $amount := xs:string(data($securePayMessage/Payment/TxnList/Txn/amount) div 100)
                                                                 return
                                                                 if (fn:string-length(substring-after($amount,'.'))=0)
                                                                 then
                                                                 fn:concat( $amount,".00") 
                                                                 else 
                                                                 if (fn:string-length(substring-after($amount,'.'))=1)
                                                                 then 
                                                                 fn:concat( $amount,"0")
                                                                 else    $amount
                                                                 }</Amount>   
                       else
                            ()  
              else
                   <Amount CurrencyCode ="{(data($currencyCode))}">{$amount}</Amount>                     
            }
            {
           let $__nullable := $securePayMessage/Payment/TxnList/Txn/preauthID
            return
                        if (fn:string-length($__nullable)>0)
                        then    
                              <AuthCode>{data($__nullable)}</AuthCode>
                        else 
                              ()   
             } 
            		<PaymentGatewayInfo>
                                               {
                                                let $__nullable := ( data($PaymentGateway) )
                                                return
                                                       if (fn:boolean($__nullable))
                                                       then
                                                             <PaymentGateway>{ $__nullable }</PaymentGateway>
                                                       else
                                                             ()
                                                }
                                                {
                                                let $__nullable := $securePayMessage/Payment/TxnList/Txn/txnID
                                                 return
                                                        if (fn:string-length($__nullable)>0)
                                                        then
                                                              <TransactionId>{data($__nullable)}</TransactionId>
                                                        else
                                                               ()   
                                                 }
                                                 {
                                                 let $__nullable := $securePayMessage/Payment/TxnList/Txn/responseCode
                                                 return
                                                             if (fn:string-length($__nullable)>0)
                                                             then
                                                                   <TransactionStatusCode>{data($__nullable)}</TransactionStatusCode>
                                                             else
                                                                   ()   
                                                 }
                                                 {
                                                 let $__nullable := $securePayMessage/Payment/TxnList/Txn/responseText
                                                 return
                                                             if (fn:string-length($__nullable)>0)
                                                             then
                                                                   <TransactionStatusMessage>{data($__nullable)}</TransactionStatusMessage>
                                                             else
                                                                   ()   
                                                 }
                                                 {
                                                 let $__nullable := $securePayMessage/RequestType
                                                 return
                                                             if (fn:string-length($__nullable)>0)
                                                             then
                                                                   <Mode>{data($__nullable)}</Mode>
                                                             else
                                                                   ()
                                                 } 
            		</PaymentGatewayInfo>
       </ns1:CreditCardResponse>
};

declare variable $securePayMessage as element(SecurePayMessage) external;
declare variable $commonDataMapPropertiesFile as element(*) external;
declare variable $SecurePayPropertiesFile as element(*) external;
declare variable $PaymentGateway as xs:string external;
declare variable $orderCountryCode as xs:string external;
declare variable $amount as xs:string external;
declare variable $currencyCode as xs:string external;
declare variable $responseStatusCode as xs:string external;

xf:SecurePayResponseToOutput($securePayMessage, $commonDataMapPropertiesFile, $SecurePayPropertiesFile, $PaymentGateway, $orderCountryCode, $amount, $currencyCode, $responseStatusCode)
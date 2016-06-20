(:: pragma bea:global-element-parameter parameter="$response1" element="Response" location="../Schema/DataCashResponse.xsd" ::)
(:: pragma bea:global-element-return element="ns1:CreditCardResponse" location="../Schema/CreditCardResponse.xsd" ::)

declare namespace ns1 = "http://mheducation.com/CreditCardService/CreditCardResponse/01";
declare namespace ns0 = "http://mheducation.com/Common/01";
declare namespace xf = "http://tempuri.org/MHEducation/CreditCardService/XQuery/DatacashResponseToOutput/";

declare function xf:DatacashResponseToOutput($response as element(Response), $countryGatewayMappingFile as element(*), $amount as xs:decimal,  $currencyCode as xs:string, $datacashPropertiesFile as element(*), $PaymentGateway as xs:string, $orderCountryCode as xs:string)
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
                let $merchantreference := $response/merchantreference
                return
                    <OrderId>{ data($merchantreference ) }</OrderId>
            }
           {
               let $responsestatus := $datacashPropertiesFile/ResponseStatus/Status
                return
                       if(not(fn:compare($responsestatus/@Code,data($response/status))))
                       then
                          <ResponseStatus>{data($responsestatus)}</ResponseStatus>
                        else
                           <ResponseStatus>Failure</ResponseStatus>      
          }
          {
                if ((fn:string-length(data($response/CardTxn/card_scheme)) > 0) or (fn:string-length(data($response/CardTxn/country)) > 0) or (fn:string-length(data($response/CardTxn/issuer)) > 0))
                    then
             <CreditCardDetails>
                {
                    for $card_scheme in $response/CardTxn/card_scheme
                    return
                        let $__nullable := ( fn:upper-case(data($card_scheme) ))
                        return
                            if (fn:boolean($__nullable))
                            then
                                <CreditCardType>{ $__nullable }</CreditCardType>
                            else
                                ()
                }
                {
                    for $country in $countryGatewayMappingFile/CountryList/Country   
                    where $country/@name= data($response/CardTxn/country)
                    return
                        let $__nullable := ( data($country/@abbreviation))
                        return
                            if (fn:boolean($__nullable))
                            then
                                <CreditCardIssueCountryCode>{ $__nullable }</CreditCardIssueCountryCode>
                            else
                                ()
                }
                {
                    for $issuer in $response/CardTxn/issuer
                    return
                        let $__nullable := ( data($issuer) )
                        return
                            if (fn:boolean($__nullable))
                            then
                                <CreditCardIssuingBank>{ $__nullable }</CreditCardIssuingBank>
                            else
                                ()
                }
            </CreditCardDetails>
               else()
              }
              <Amount CurrencyCode = "{ let $__nullable := xs:string($currencyCode)
                                                      return
                                                          if (fn:boolean($__nullable))
                                                          then
                                                              $__nullable
                                                          else
                                                              () }">{ let $__nullable := (xs:string($amount))
                                                                         return
                                                                                 if (fn:string-length(substring-after($__nullable,'.'))=0)
                                                                                  then
                                                                                       fn:concat( $__nullable,".00") 
                                                                                  else 
                                                                                        if (fn:string-length(substring-after($__nullable,'.'))=1)
                                                                                        then 
                                                                                              fn:concat( $__nullable,"0")
                                                                                        else 
                                                                                              $__nullable
                                                                                  }
                </Amount>
            {
                for $authcode in $response/CardTxn/authcode
                return
                    let $__nullable := ( data($authcode) )
                    return
                        if (fn:boolean($__nullable))
                        then
                            <AuthCode>{ $__nullable }</AuthCode>
                        else
                            ()
            }
            {
                   if ((fn:string-length(data($response/CardTxn/Cv2Avs/cv2avs_status)) > 0)  or (fn:string-length(data($response/CardTxn/Cv2Avs/policy)) > 0))
                    then
            <FraudDetection>
                {
                    for $cv2avs_status in $response/CardTxn/Cv2Avs/cv2avs_status
                    return
                        let $__nullable := ( data($cv2avs_status) )
                        return
                            if (fn:boolean($__nullable))
                            then
                                <CVVResponse>{ $__nullable }</CVVResponse>
                            else
                                ()
                }
                {
                    for $cv2avs_status in $response/CardTxn/Cv2Avs/cv2avs_status
                    return
                        let $__nullable := ( data($cv2avs_status) )
                        return
                            if (fn:boolean($__nullable))
                            then
                                <AVSResponse>{ $__nullable }</AVSResponse>
                            else
                                ()
                }
                {
                    for $policy in $response/CardTxn/Cv2Avs/policy
                    return
                        let $__nullable := ( data($policy) )
                        return
                            if (fn:boolean($__nullable))
                            then
                                <Policy>{ $__nullable }</Policy>
                            else
                                ()
                }
            </FraudDetection>
              else ()
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
                    let $__nullable := ( data($response/datacash_reference) )
                    return
                        if (fn:boolean($__nullable))
                        then
                            <TransactionId>{ $__nullable }</TransactionId>
                        else
                            ()
                  }
                  {
                    let $__nullable := ( data($response/status) )
                    return
                        if (fn:boolean($__nullable))
                        then
                            <TransactionStatusCode>{ $__nullable }</TransactionStatusCode>
                        else
                            ()
                }
                {
                    let $__nullable := ( data($response/reason) )
                    return
                        if (fn:boolean($__nullable))
                        then
                            <TransactionStatusMessage>{ $__nullable }</TransactionStatusMessage>
                        else
                            ()
                }
                {
                    let $__nullable := ( data($response/information) )
                    return
                        if (fn:boolean($__nullable))
                        then
                            <TransactionStatusDetail>{ $__nullable }</TransactionStatusDetail>
                        else
                            ()
                }
                {
                     let $__nullable := ( data($response/mode) )
                    return
                        if (fn:boolean($__nullable))
                        then
                            <Mode>{ $__nullable }</Mode>
                        else
                            ()
                }
                {
                    let $__nullable := ( data($response/time) )
                    return
                        if (fn:boolean($__nullable))
                        then
                            <StartTime>{
                                                xs:dateTime("1970-01-01T00:00:00-00:00")  + xdt:dayTimeDuration(concat("PT", $__nullable, "S"))                                               
                                               }
                             </StartTime>
                        else
                            ()
                }
            </PaymentGatewayInfo>
        </ns1:CreditCardResponse>
};

declare variable $response as element(Response) external;
declare variable $countryGatewayMappingFile as element(*) external;
declare variable $amount as xs:decimal external;
declare variable $currencyCode as xs:string external;
declare variable $datacashPropertiesFile as element(*) external;
declare variable $PaymentGateway as xs:string external;
declare variable $orderCountryCode as xs:string external;

xf:DatacashResponseToOutput($response, $countryGatewayMappingFile, $amount, $currencyCode, $datacashPropertiesFile, $PaymentGateway, $orderCountryCode)
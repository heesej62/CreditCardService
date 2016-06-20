(:: pragma bea:global-element-parameter parameter="$countryList1" element="CountryList" location="../Schema/Country.xsd" ::)

declare namespace xf = "http://tempuri.org/MHEducation/CreditCardService/XQuery/CreditCardInformation/";

declare function xf:GetPaymentGateway($countryCode as xs:string, $commonDataMapProperties as element(*))
    as xs:NCName? {

    for $x in $commonDataMapProperties/CountryList/Country
    return 
           let $gateway := data($x/Gateway)
           return
           if (not(fn:compare($x/@abbreviation,data($countryCode ))))
              then $gateway
           else ()

};

declare variable $countryCode as xs:string external;
declare variable $commonDataMapProperties as element(*) external;

xf:GetPaymentGateway($countryCode ,$commonDataMapProperties)
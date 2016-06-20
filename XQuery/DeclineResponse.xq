(:: pragma bea:global-element-parameter parameter="$creditCardRequest1" element="ns0:CreditCardRequest" location="../Schema/CreditCardRequest.xsd" ::)
(:: pragma bea:global-element-return element="ns1:CreditCardResponse" location="../Schema/CreditCardResponse.xsd" ::)

declare namespace ns2 = "http://mheducation.com/Common/01";
declare namespace ns1 = "http://mheducation.com/CreditCardService/CreditCardResponse/01";
declare namespace ns0 = "http://mheducation.com/CreditCardService/CreditCardRequest/01";
declare namespace xf = "http://tempuri.org/MHEducation/CreditCardService/XQuery/TestResponse/";

declare function xf:DeclineResponse($creditCardRequest1 as element(ns0:CreditCardRequest))
    as element(ns1:CreditCardResponse) {
        <ns1:CreditCardResponse>
            <OrderCountryCode>{data($creditCardRequest1/OrderCountryCode)}</OrderCountryCode>
            <OrderId>{data($creditCardRequest1/OrderId)}</OrderId>
            <ResponseStatus>Failure</ResponseStatus>
            <Amount CurrencyCode = "USD">{data($creditCardRequest1/OrderDetails/Total)}</Amount>
            <PaymentGatewayInfo>
                  <PaymentGateway>ClearCommerceUS</PaymentGateway>
                  <TransactionStatusMessage>Declined:Floor High fraud</TransactionStatusMessage>
                  <TransactionStatusDetail>Declined:Floor High fraud</TransactionStatusDetail>
            </PaymentGatewayInfo>
        </ns1:CreditCardResponse>
};

declare variable $creditCardRequest1 as element(ns0:CreditCardRequest) external;

xf:DeclineResponse($creditCardRequest1)
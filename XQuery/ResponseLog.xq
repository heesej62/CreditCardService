(:: pragma bea:global-element-parameter parameter="$creditCardResponse1" element="ns1:CreditCardResponse" location="../Schema/CreditCardResponse.xsd" ::)
(:: pragma bea:global-element-return element="ns1:CreditCardResponse" location="../Schema/CreditCardResponse.xsd" ::)

declare namespace ns1 = "http://mheducation.com/CreditCardService/CreditCardResponse/01";
declare namespace ns0 = "http://mheducation.com/Common/01";
declare namespace xf = "http://tempuri.org/MHEducation/CreditCardService/XQuery/ResponseLog/";

declare function xf:ResponseLog($creditCardResponse as element(ns1:CreditCardResponse))
    as element(ns1:CreditCardResponse) {
        <ns1:CreditCardResponse>
            {
                for $OrderCountryCode in $creditCardResponse/OrderCountryCode
                return
                    <OrderCountryCode>{ data($OrderCountryCode) }</OrderCountryCode>
            }
            <OrderId>{ data($creditCardResponse/OrderId) }</OrderId>
            <ResponseStatus>{ data($creditCardResponse/ResponseStatus) }</ResponseStatus>
            <Amount CurrencyCode = "{ data($creditCardResponse/Amount/@CurrencyCode) }">{ data($creditCardResponse/Amount) }</Amount>
            {
                for $AuthCode in $creditCardResponse/AuthCode
                return
                    <AuthCode>{ data($AuthCode) }</AuthCode>
            }
            {
                for $FraudDetection in $creditCardResponse/FraudDetection
                return
                    <FraudDetection>
                        {
                            for $CVVResponse in $FraudDetection/CVVResponse
                            return
                                <CVVResponse>{ data($CVVResponse) }</CVVResponse>
                        }
                        {
                            for $AVSResponse in $FraudDetection/AVSResponse
                            return
                                <AVSResponse>{ data($AVSResponse) }</AVSResponse>
                        }
                        {
                            for $Policy in $FraudDetection/Policy
                            return
                                <Policy>{ data($Policy) }</Policy>
                        }
                    </FraudDetection>
            }
            {
                for $PaymentGatewayInfo in $creditCardResponse/PaymentGatewayInfo
                return
                    <PaymentGatewayInfo>
                        {
                            for $PaymentGateway in $PaymentGatewayInfo/PaymentGateway
                            return
                                <PaymentGateway>{ data($PaymentGateway) }</PaymentGateway>
                        }
                        {
                            for $TransactionId in $PaymentGatewayInfo/TransactionId
                            return
                                <TransactionId>{ data($TransactionId) }</TransactionId>
                        }
                        {
                            for $TransactionStatusCode in $PaymentGatewayInfo/TransactionStatusCode
                            return
                                <TransactionStatusCode>{ data($TransactionStatusCode) }</TransactionStatusCode>
                        }
                        {
                            for $TransactionStatusMessage in $PaymentGatewayInfo/TransactionStatusMessage
                            return
                                <TransactionStatusMessage>{ data($TransactionStatusMessage) }</TransactionStatusMessage>
                        }
                        {
                            for $TransactionStatusDetail in $PaymentGatewayInfo/TransactionStatusDetail
                            return
                                <TransactionStatusDetail>{ data($TransactionStatusDetail) }</TransactionStatusDetail>
                        }
                        {
                            for $StartTime in $PaymentGatewayInfo/StartTime
                            return
                                <StartTime>{ data($StartTime) }</StartTime>
                        }
                        {
                            for $EndTime in $PaymentGatewayInfo/EndTime
                            return
                                <EndTime>{ data($EndTime) }</EndTime>
                        }
                    </PaymentGatewayInfo>
            }            
        </ns1:CreditCardResponse>
};

declare variable $creditCardResponse as element(ns1:CreditCardResponse) external;

xf:ResponseLog($creditCardResponse)
(:: pragma bea:global-element-parameter parameter="$newOrderResponse" element="ns1:NewOrderResponse" location="../Schema/CreditCardRequest.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Reversal" location="../WSDL/PaymentechGateway.wsdl" ::)


declare namespace conn = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "urn:ws.paymentech.net/PaymentechGateway";
declare namespace xf = "http://tempuri.org/MHEducation/CreditCardService/XQuery/NewOrderResponse2ReversalRequest/";

declare function xf:NewOrderResponse2ReversalRequest($newOrderResponse as element(ns1:NewOrderResponse) , $refundAmount as xs:string )   as element(ns1:Reversal) {


	<ns1:Reversal>
		<ns1:reversalRequest>
			<ns1:orbitalConnectionUsername>
			{
			data(fn-bea:lookupBasicCredentials('MHEducation/CreditCardService/PaymentTechServiceAccount')/conn:username/text())
			}
			</ns1:orbitalConnectionUsername>
			<ns1:orbitalConnectionPassword>
			{
			data( fn-bea:lookupBasicCredentials('MHEducation/CreditCardService/PaymentTechServiceAccount')/conn:password/text())
			}
			</ns1:orbitalConnectionPassword>
			<ns1:version>2.9</ns1:version>

			{
				for $txRefNum in $newOrderResponse/ns1:return/ns1:txRefNum
				return
					let $__nullable := ( data($txRefNum) )
					return
						if (fn:boolean($__nullable))
						then
						    <ns1:txRefNum>{data($newOrderResponse/ns1:return/ns1:txRefNum)}</ns1:txRefNum>

						else 
							()
			}
			{
				for $txRefIdx in $newOrderResponse/ns1:return/ns1:txRefIdx
				return
					let $__nullable := ( data($txRefIdx) )
					return
						if (fn:boolean($__nullable))
						then
						    <ns1:txRefIdx>{data($newOrderResponse/ns1:return/ns1:txRefIdx)}</ns1:txRefIdx>

						else 
							()
			}
                                                     {
                                                
                                                     let $total  :=    ( xs:integer (xs:float(data($refundAmount) ) * 100 )   ) 

                                                      return
			<ns1:adjustedAmount>{($total)}</ns1:adjustedAmount>
                                                     }
                                                  <ns1:orderID>{ data($newOrderResponse/ns1:return/ns1:orderID) }</ns1:orderID>
			<ns1:bin>{ data($newOrderResponse/ns1:return/ns1:bin) }</ns1:bin>
			<ns1:merchantID>{ data($newOrderResponse/ns1:return/ns1:merchantID) }</ns1:merchantID>
			<ns1:terminalID>{ data($newOrderResponse/ns1:return/ns1:terminalID) }</ns1:terminalID>
			 <ns1:onlineReversalInd>Y</ns1:onlineReversalInd>
	        </ns1:reversalRequest>
        </ns1:Reversal>
};

declare variable $newOrderResponse as element(ns1:NewOrderResponse) external;
declare variable $refundAmount as xs:string external;

xf:NewOrderResponse2ReversalRequest($newOrderResponse,$refundAmount)
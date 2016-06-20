(:: pragma bea:global-element-parameter parameter="$newOrderResponse" element="ns0:NewOrderResponse" location="../../../MHEOrbital/WSDL/PaymentechGateway.wsdl" ::)
(:: pragma bea:global-element-return element="ns2:CreditCardResponse" location="../Schema/CreditCardResponse.xsd" ::)

declare namespace ns2 = "http://mheducation.com/CreditCardService/CreditCardResponse/01";
declare namespace ns1 = "http://mheducation.com/Common/01";
declare namespace ns0 = "urn:ws.paymentech.net/PaymentechGateway";
declare namespace xf = "http://tempuri.org/MHEducation/CreditCardService/XQuery/NewOrderResponse2CreditCardResponse/";

declare function xf:NewOrderResponse2CreditCardResponse($newOrderResponse as element(ns0:NewOrderResponse), $CCode as xs:string, $TotalCurrency as xs:string)
    as element(ns2:CreditCardResponse) {
        <ns2:CreditCardResponse>
            <OrderId>{ data($newOrderResponse/ns0:return/ns0:orderID) }</OrderId>
            <ResponseStatus>
                {
                let $fraudStatusCode := ($newOrderResponse/ns0:return/ns0:fraudAnalysisResponse/ns0:fraudStatusCode)
                let $DecisionResponse :=($newOrderResponse/ns0:return/ns0:fraudAnalysisResponse/ns0:autoDecisionResponse)
                
                for $ApprovalStatus in $newOrderResponse/ns0:return/ns0:approvalStatus
	    	return
	    	if (exists($newOrderResponse/ns0:return/ns0:fraudAnalysisResponse)) then  
                    if (data($ApprovalStatus) = 1) then         	
		    	
		    		if (data($DecisionResponse) ='D') then
		    			('Failure')
				else
					('Success')
		        
		    else 
			('Failure')   
                else (
			if (data($ApprovalStatus) = 1) then
				('Success')
			    else 
				('Failure') 
                        )
                  
                }
	</ResponseStatus>
	<Amount CurrencyCode = "{ data($CCode) }">{ data($TotalCurrency) }</Amount>
                {
                	let $fraudStatusCode := ($newOrderResponse/ns0:return/ns0:fraudAnalysisResponse/ns0:fraudStatusCode)
                	let $DecisionResponse :=($newOrderResponse/ns0:return/ns0:fraudAnalysisResponse/ns0:autoDecisionResponse)
                	for $ApprovalStatus in $newOrderResponse/ns0:return/ns0:approvalStatus
	            return
                    if (data($ApprovalStatus) = 1) then
		
                	if (exists($newOrderResponse/ns0:return/ns0:fraudAnalysisResponse)) then                	
				
					if (data($DecisionResponse)='D') then
					()
					else
					(for $ApprovalStatus in $newOrderResponse/ns0:return/ns0:approvalStatus
					  return
					  if (data($ApprovalStatus) = 1) then
					  <AuthCode>{ fn:concat(data($newOrderResponse/ns0:return/ns0:authorizationCode),'#',data($newOrderResponse/ns0:return/ns0:txRefNum)) }</AuthCode> 
					  else
					  ()
					 )
				
			else (
			for $ApprovalStatus in $newOrderResponse/ns0:return/ns0:approvalStatus
			  return
			  if (data($ApprovalStatus) = 1) then
			  <AuthCode>{ fn:concat(data($newOrderResponse/ns0:return/ns0:authorizationCode),'#',data($newOrderResponse/ns0:return/ns0:txRefNum)) }</AuthCode> 
			  else
			()
			)
                  else ()
                }
                <FraudDetection>
                         <CVVResponse>{ data($newOrderResponse/ns0:return/ns0:cvvRespCode) }</CVVResponse>
                         <AVSResponse>{ data($newOrderResponse/ns0:return/ns0:avsRespCode) }</AVSResponse>
                </FraudDetection>
                <PaymentGatewayInfo>
                         <TransactionId>{ data($newOrderResponse/ns0:return/ns0:txRefNum) }</TransactionId>
                         <TransactionStatusCode>{ 
                         
                         if (exists($newOrderResponse/ns0:return/ns0:fraudAnalysisResponse)) then  
			 		
			 		if (data($newOrderResponse/ns0:return/ns0:fraudAnalysisResponse/ns0:autoDecisionResponse) ='D') then
		    			    ()
		    			else (data($newOrderResponse/ns0:return/ns0:respCode))

                         
                         
                         else( data($newOrderResponse/ns0:return/ns0:respCode) )
                         
                         }</TransactionStatusCode>
                         <TransactionStatusMessage>
                         {
                         
                         
                         if (exists($newOrderResponse/ns0:return/ns0:fraudAnalysisResponse)) then  
			             	
			 	
		    			if (data($newOrderResponse/ns0:return/ns0:fraudAnalysisResponse/ns0:autoDecisionResponse) ='D') then
		    			    ('Declined')    
		    			else (if (data($newOrderResponse/ns0:return/ns0:approvalStatus) = 0) then
				   			(fn:concat('Declined',':', data($newOrderResponse/ns0:return/ns0:procStatusMessage)))
			    			else 
				   			if (data($newOrderResponse/ns0:return/ns0:approvalStatus) = 1) then
					     			('Approved')
				   			else 
					     			(fn:concat('System Error',':', data($newOrderResponse/ns0:return/ns0:procStatusMessage)))
		    			)  
		    			    			
		    	else (
		    	
			     if (data($newOrderResponse/ns0:return/ns0:approvalStatus) = 0) then
				   (fn:concat('Declined',':', data($newOrderResponse/ns0:return/ns0:procStatusMessage)))
			    else 
				   if (data($newOrderResponse/ns0:return/ns0:approvalStatus) = 1) then
					     ('Approved')
				   else 
					     (fn:concat('System Error',':', data($newOrderResponse/ns0:return/ns0:procStatusMessage)))
			   )		     
                           }
	           </TransactionStatusMessage>
                           <TransactionStatusDetail>
                           {
                      	                   	 
			    if (exists($newOrderResponse/ns0:return/ns0:fraudAnalysisResponse)) then  
			   			             	
			   	
		    			if (data($newOrderResponse/ns0:return/ns0:fraudAnalysisResponse/ns0:autoDecisionResponse)='D') then
                           			('Declined') 
                           		else (if (data($newOrderResponse/ns0:return/ns0:approvalStatus) = 0) then
                                           		(fn:concat('Declined',':', data($newOrderResponse/ns0:return/ns0:procStatusMessage)))
                                  		else (
                                           		if (data($newOrderResponse/ns0:return/ns0:approvalStatus) = 1) then
                                                     		('Approved')
                                           		else (
                                           			(fn:concat('System Error',':', data($newOrderResponse/ns0:return/ns0:procStatusMessage)))
                                           		     )
                            		     	     ))
                           
                           
                           
                           
                           else (
                                  if (data($newOrderResponse/ns0:return/ns0:approvalStatus) = 0) then
                                           (fn:concat('Declined',':', data($newOrderResponse/ns0:return/ns0:procStatusMessage)))
                                  else 
                                           if (data($newOrderResponse/ns0:return/ns0:approvalStatus) = 1) then
                                                     ('Approved')
                                           else 
                                                     (fn:concat('System Error',':', data($newOrderResponse/ns0:return/ns0:procStatusMessage)))
                            	)
                            }
	           </TransactionStatusDetail>
                          {
                           for $RespDateTime in $newOrderResponse/ns0:return/ns0:respDateTime
                    return
                        let $__nullable := ( $RespDateTime )
                        return
                            if (fn:boolean($__nullable))
                            then
                                <EndTime>{ $__nullable}</EndTime>
                            else
                                ()
                             }
                          
               </PaymentGatewayInfo>               
        </ns2:CreditCardResponse>
};

declare variable $newOrderResponse as element(ns0:NewOrderResponse) external;
declare variable $CCode as xs:string external;
declare variable $TotalCurrency as xs:string external;


xf:NewOrderResponse2CreditCardResponse($newOrderResponse,$CCode,$TotalCurrency )
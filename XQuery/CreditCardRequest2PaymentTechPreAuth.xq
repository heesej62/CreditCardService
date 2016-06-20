(:: pragma bea:global-element-parameter parameter="$creditCardRequest1" element="ns0:CreditCardRequest" location="../Schema/CreditCardRequest.xsd" ::)
(:: pragma bea:global-element-return element="ns1:NewOrder" location="../WSDL/PaymentechGateway.wsdl" ::)

declare namespace conn = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://mheducation.com/Common/01";
declare namespace ns1 = "urn:ws.paymentech.net/PaymentechGateway";
declare namespace ns0 = "http://mheducation.com/CreditCardService/CreditCardRequest/01";
declare namespace xf = "http://tempuri.org/MHEducation/CreditCardService/XQuery/CreditCardRequest2PaymentTechPreAuth/";

declare function xf:CreditCardRequest2PaymentTechPreAuth($creditCardRequest1 as element(ns0:CreditCardRequest), $orbitalPaymentechProperties  as element(*),
	$commonDataMapProperties as element(*),$wssecurityusername as xs:string, $safeTechConfig as element(*))   as element(ns1:NewOrder) {

		for $country in $commonDataMapProperties/CountryList/Country
			where $country/@abbreviation = data($creditCardRequest1/OrderCountryCode)
		return  
		let $properties := $orbitalPaymentechProperties/Properties
		return

		<ns1:NewOrder>
			<ns1:newOrderRequest>
				<ns1:orbitalConnectionUsername>
				 {

					if (data($creditCardRequest1/MerchantInfo/UserName) != '') then
						 (data($creditCardRequest1/MerchantInfo/UserName))
					else 
						 data(fn-bea:lookupBasicCredentials('MHEducation/CreditCardService/PaymentTechServiceAccount')/conn:username/text()) 

				}
				</ns1:orbitalConnectionUsername>
				<ns1:orbitalConnectionPassword>
				{

					if (data($creditCardRequest1/MerchantInfo/Password) != '') then
						 (data($creditCardRequest1/MerchantInfo/Password))
					else 
						 data( fn-bea:lookupBasicCredentials('MHEducation/CreditCardService/PaymentTechServiceAccount')/conn:password/text())

				} 
				</ns1:orbitalConnectionPassword>
				<ns1:version>2.9</ns1:version>
				<ns1:industryType>EC</ns1:industryType>
				{
					for $TransactionType in $creditCardRequest1/TransactionType
					return
						let $__nullable := ( data($TransactionType) )
						return
							if (fn:boolean($__nullable))
							then
								if (data($TransactionType) = 'PreAuth') then
									<ns1:transType>A</ns1:transType>

								else 
									if (data($TransactionType) = 'Auth') then
										<ns1:transType>AC</ns1:transType>
								else 
									()

							else 
								()
				}
				<ns1:bin>000001</ns1:bin>
				{
					if (data($creditCardRequest1/MerchantInfo/ClientId) != '') then (

						if($creditCardRequest1/OrderCountryCode/text()='US' or $creditCardRequest1/OrderCountryCode/text()='CA') then 
							let $ClientIds:= $properties/ClientIds[@country=$creditCardRequest1/OrderCountryCode/text()]                            
							for $x in $ClientIds/ClientId     where $x/@wsName=data($wssecurityusername)
							return
								if (data($x) =  data($creditCardRequest1/MerchantInfo/ClientId)  ) then (
									<ns1:merchantID>{ data($creditCardRequest1/MerchantInfo/ClientId) }</ns1:merchantID>
								)
								else
								( 
									<ns1:merchantID>222514</ns1:merchantID>
								)
						else
						()

					)
					else
					(
						if($creditCardRequest1/OrderCountryCode/text()='US' or $creditCardRequest1/OrderCountryCode/text()='CA') then (
							<ns1:merchantID>
							{
								let $ClientIds:= $properties/ClientIds[@country=$creditCardRequest1/OrderCountryCode/text()]                            
								for $x in $ClientIds/ClientId     where $x/@wsName=data($wssecurityusername)
								return data($x) 
							}
							</ns1:merchantID>
						)
						else
						()
					)	

				}
				<ns1:terminalID>001</ns1:terminalID>
				<ns1:ccAccountNum>{ data($creditCardRequest1/CardDetails/CreditCardDetails/CreditCardNumber) }</ns1:ccAccountNum>
				<ns1:ccExp>{ concat('20',data($creditCardRequest1/CardDetails/CreditCardDetails/CardExpYear),data($creditCardRequest1/CardDetails/CreditCardDetails/CardExpMonth)) }</ns1:ccExp>
				{
					if((data($creditCardRequest1/CardDetails/CreditCardDetails/CreditCardType)='VISA' or data($creditCardRequest1/CardDetails/CreditCardDetails/CreditCardType)='DISCOVER') and  fn:string-length($creditCardRequest1/CardDetails/CreditCardDetails/SecurityCode) !=0)
					then
						<ns1:ccCardVerifyPresenceInd>1</ns1:ccCardVerifyPresenceInd>
					else
					()
				}
				<ns1:ccCardVerifyNum>{ data($creditCardRequest1/CardDetails/CreditCardDetails/SecurityCode) }</ns1:ccCardVerifyNum>
				
				{
					for $CustomerName in $creditCardRequest1/CustomerBillingInfo/CustomerName
					return
						let $__nullable := fn:replace(data($CustomerName), '(\&amp;|\%)', '')
						return
							if(fn:boolean($__nullable) )
							then
								
								if (fn:string-length($__nullable) > 30)
								then
									<ns1:avsName>{fn:substring(data($__nullable), 0, 31)}</ns1:avsName>
								else
								(
									<ns1:avsName>{data($__nullable)}</ns1:avsName>
								)
							else
							()
				}
				
				
                                 {
					for $Email in $creditCardRequest1/CustomerBillingInfo/Email
					return
						let $__nullable := (data($Email ))
						return
							if(fn:boolean($__nullable))
							then
								<ns1:customerEmail>{ data($Email) }</ns1:customerEmail>
							else
							()
				}
				<ns1:avsAddress1>
				{
					if (data(fn:replace(data($creditCardRequest1/CustomerBillingInfo/Address/LineOne), '(\%|\||\^|\\|\/|&amp;)' , '')) != '') then
						if (fn:string-length(fn:replace(data($creditCardRequest1/CustomerBillingInfo/Address/LineOne), '(\%|\||\^|\\|\/|&amp;)' , '')) > 30) then
                                                    fn:substring(data(fn:replace(data($creditCardRequest1/CustomerBillingInfo/Address/LineOne), '(\%|\||\^|\\|\/|&amp;)' , '')), 0, 31)
                                                else
                                                (data(fn:replace(data($creditCardRequest1/CustomerBillingInfo/Address/LineOne), '(\%|\||\^|\\|\/|&amp;)' , '')))
					else 
					()
				}
				</ns1:avsAddress1>
				<ns1:avsAddress2>
                                { 
                                        if (fn:string-length(fn:replace(data($creditCardRequest1/CustomerBillingInfo/Address/LineTwo), '(\%|\||\^|\\|\/|&amp;)' , '')) > 30) then
                                                fn:substring(data(fn:replace(data($creditCardRequest1/CustomerBillingInfo/Address/LineTwo), '(\%|\||\^|\\|\/|&amp;)' , '')), 0, 31)
                                        else
                                                (data(fn:replace(data($creditCardRequest1/CustomerBillingInfo/Address/LineTwo), '(\%|\||\^|\\|\/|&amp;)' , '')))
                                }
                                </ns1:avsAddress2>
				<ns1:avsCity>
                                    { 
                                        if (fn:string-length(fn:replace(data($creditCardRequest1/CustomerBillingInfo/Address/City), '(\%|\||\^|\\|\/|&amp;)' , '')) > 20) then
                                                fn:substring(fn:replace(data($creditCardRequest1/CustomerBillingInfo/Address/City), '(\%|\||\^|\\|\/|&amp;)' , ''), 0, 21)
                                        else
                                            (fn:replace(data($creditCardRequest1/CustomerBillingInfo/Address/City), '(\%|\||\^|\\|\/|&amp;)' , ''))
                                    }
                                </ns1:avsCity>
				<ns1:avsState>
                                      { 
                                             if (data($creditCardRequest1/CustomerBillingInfo/Address/CountryCode) = 'US' or data($creditCardRequest1/CustomerBillingInfo/Address/CountryCode) ='CA' or data($creditCardRequest1/CustomerBillingInfo/Address/CountryCode)= 'GB' or data($creditCardRequest1/CustomerBillingInfo/Address/CountryCode) = 'UK') then
						if (fn:string-length(fn:replace(data($creditCardRequest1/CustomerBillingInfo/Address/State), '(\%|\||\^|\\|\/|&amp;)' , '')) > 2) then
                                                        fn:substring(fn:replace(data($creditCardRequest1/CustomerBillingInfo/Address/State), '(\%|\||\^|\\|\/|&amp;)' , ''), 0, 3)
                                                else
                                                        (fn:replace(data($creditCardRequest1/CustomerBillingInfo/Address/State), '(\%|\||\^|\\|\/|&amp;)' , ''))
					     else 
					        ()          
                                      }
                                </ns1:avsState>
                                <ns1:avsZip>
                                    { 
                                            if (fn:string-length(fn:replace(data($creditCardRequest1/CustomerBillingInfo/Address/PostalCode), '(\&amp;|\%|\||\^|\\|\/)', '')) > 10) then
                                                fn:substring(fn:replace(data($creditCardRequest1/CustomerBillingInfo/Address/PostalCode), '(\&amp;|\%|\||\^|\\|\/)', ''), 0, 11)
                                            else
                                                (fn:replace(data($creditCardRequest1/CustomerBillingInfo/Address/PostalCode), '(\&amp;|\%|\||\^|\\|\/)', ''))
                                    }
                                </ns1:avsZip>
				<ns1:avsCountryCode>
                                   {  
                                           if (data($creditCardRequest1/CustomerBillingInfo/Address/CountryCode) = 'US' or data($creditCardRequest1/CustomerBillingInfo/Address/CountryCode) ='CA' or data($creditCardRequest1/CustomerBillingInfo/Address/CountryCode)= 'GB' or data($creditCardRequest1/CustomerBillingInfo/Address/CountryCode) = 'UK') then
						data($creditCardRequest1/CustomerBillingInfo/Address/CountryCode)
					     else 
					        ()          
                                   }
                               	</ns1:avsCountryCode>
                               	{
					for $CustomerName in $creditCardRequest1/CustomerShippingInfo/CustomerName
					return
						let $__nullable := fn:replace(data($CustomerName), '(\&amp;|\%)', '')
						return
							if(fn:boolean($__nullable) )
							then
								if (fn:string-length($__nullable) > 30)
								then
									<ns1:avsDestName>{fn:substring(data($__nullable), 0, 31)}</ns1:avsDestName>
								else
								(
									<ns1:avsDestName>{data($__nullable)}</ns1:avsDestName>
								)
								else
								()
				}
                               	
                                <ns1:avsDestAddress1>
				{
					if (data(fn:replace(data($creditCardRequest1/CustomerShippingInfo/Address/LineOne), '(\%|\||\^|\\|\/|&amp;)' , '')) != '') then
						if (fn:string-length(data(fn:replace(data($creditCardRequest1/CustomerShippingInfo/Address/LineOne), '(\%|\||\^|\\|\/|&amp;)' , ''))) > 28) then
                                                    fn:substring(data(fn:replace(data($creditCardRequest1/CustomerShippingInfo/Address/LineOne), '(\%|\||\^|\\|\/|&amp;)' , '')), 0, 29)
                                                else
                                                    (data(fn:replace(data($creditCardRequest1/CustomerShippingInfo/Address/LineOne), '(\%|\||\^|\\|\/|&amp;)' , '')))
					else 
					()
				}
				</ns1:avsDestAddress1>
				<ns1:avsDestAddress2>
                                { 
                                       if (fn:string-length(data(fn:replace(data($creditCardRequest1/CustomerShippingInfo/Address/LineTwo), '(\%|\||\^|\\|\/|&amp;)' , ''))) > 28) then
                                                    fn:substring(data(fn:replace(data($creditCardRequest1/CustomerShippingInfo/Address/LineTwo), '(\%|\||\^|\\|\/|&amp;)' , '')), 0, 29)
                                                else
                                                    (data(fn:replace(data($creditCardRequest1/CustomerShippingInfo/Address/LineTwo), '(\%|\||\^|\\|\/|&amp;)' , '')))
                                }
                                </ns1:avsDestAddress2>
				<ns1:avsDestCity>
                                { 
                                        if (fn:string-length(fn:replace(data($creditCardRequest1/CustomerShippingInfo/Address/City), '(\%|\||\^|\\|\/|&amp;)' , '')) > 20) then
                                                    fn:substring(fn:replace(data($creditCardRequest1/CustomerShippingInfo/Address/City), '(\%|\||\^|\\|\/|&amp;)' , ''), 0, 21)
                                                else
                                                    (fn:replace(data($creditCardRequest1/CustomerShippingInfo/Address/City), '(\%|\||\^|\\|\/|&amp;)' , ''))
                                }
                                </ns1:avsDestCity>
				<ns1:avsDestState>
                                  { 
                                       if (data($creditCardRequest1/CustomerShippingInfo/Address/CountryCode) = 'US' or data($creditCardRequest1/CustomerShippingInfo/Address/CountryCode) ='CA' or data($creditCardRequest1/CustomerBillingInfo/Address/CountryCode)= 'GB' or data($creditCardRequest1/CustomerBillingInfo/Address/CountryCode) = 'UK') then
						 if (fn:string-length(fn:replace(data($creditCardRequest1/CustomerShippingInfo/Address/State), '(\%|\||\^|\\|\/|&amp;)' , '')) > 2) then
                                                    fn:substring(fn:replace(data($creditCardRequest1/CustomerShippingInfo/Address/State), '(\%|\||\^|\\|\/|&amp;)' , ''), 0, 3)
                                                 else
                                                    (fn:replace(data($creditCardRequest1/CustomerShippingInfo/Address/State), '(\%|\||\^|\\|\/|&amp;)' , ''))
					     else 
					        ()            
                                    
                                  }
                                </ns1:avsDestState>
                                 <ns1:avsDestZip>
                                 { 
                                        if (fn:string-length(fn:replace(data($creditCardRequest1/CustomerShippingInfo/Address/PostalCode), '(\&amp;|\%|\||\^|\\|\/|)', '')) > 10) then
                                                    fn:substring(fn:replace(data($creditCardRequest1/CustomerShippingInfo/Address/PostalCode), '(\&amp;|\%|\||\^|\\|\/|)', ''), 0, 11)
                                                 else
                                                    (fn:replace(data($creditCardRequest1/CustomerShippingInfo/Address/PostalCode), '(\&amp;|\%|\||\^|\\|\/)', ''))
                                 }
                                 </ns1:avsDestZip>
				<ns1:avsDestCountryCode>
                                 { 
                                        if (data($creditCardRequest1/CustomerShippingInfo/Address/CountryCode) = 'US' or data($creditCardRequest1/CustomerShippingInfo/Address/CountryCode) ='CA' or data($creditCardRequest1/CustomerShippingInfo/Address/CountryCode)= 'GB' or data($creditCardRequest1/CustomerShippingInfo/Address/CountryCode) = 'UK') then
                                                    data($creditCardRequest1/CustomerShippingInfo/Address/CountryCode)
					     else 
					        ()                                       

                                 }
                                </ns1:avsDestCountryCode>
				<ns1:orderID>{ data($creditCardRequest1/OrderId) }</ns1:orderID>
				<ns1:retryTrace>{fn:tokenize(data($creditCardRequest1/OrderId), '\D+')}</ns1:retryTrace>

				{
					for $CustomerName in $creditCardRequest1/CustomerBillingInfo/CustomerName
					return
					let $__nullable := fn:replace(data($CustomerName), '(\&amp;|\%)', '')
					return
						if(fn:boolean($__nullable) )
						then
							if (fn:string-length($__nullable) > 30)
							then
								<ns1:customerName>{fn:substring(data($__nullable), 0, 31)}</ns1:customerName>
							else
							(
								<ns1:customerName>{data($__nullable)}</ns1:customerName>
							)
						else
						()
				}
				
			       {
					for $PurchaseOrderNumber in $creditCardRequest1/OrderDetails/PurchaseOrderNumber
					return
					let $__nullable := ( data($PurchaseOrderNumber) )
					return
						if (fn:boolean($__nullable))
						then
						  <ns1:pCardOrderID>{fn:tokenize(data($PurchaseOrderNumber), '\D+')}</ns1:pCardOrderID>
						else
						()
				}
                                <ns1:pCardDestZip>
                        	{
                        	    if ( (fn:string-length(data($creditCardRequest1/OrderDetails/PurchaseOrderNumber)) != 0) and fn:string-length(data($creditCardRequest1/CustomerShippingInfo/Address/PostalCode)) =0) then
                        	        if (fn:string-length(fn:replace(data($creditCardRequest1/CustomerBillingInfo/Address/PostalCode), '(\&amp;|\%|\||\^|\\|\/)', '')) > 10) then
                                                    fn:substring(fn:replace(data($creditCardRequest1/CustomerBillingInfo/Address/PostalCode), '(\&amp;|\%|\||\^|\\|\/)', ''), 0, 9)
                                                 else
                                                    (fn:string(fn:replace(data($creditCardRequest1/CustomerBillingInfo/Address/PostalCode), '(\&amp;|\%|\||\^|\\|\/)', '')))
                        	    else 
                        	        if (fn:string-length(fn:replace(data($creditCardRequest1/CustomerShippingInfo/Address/PostalCode), '(\&amp;|\%|\||\^|\\|\/)', '')) > 10) then
                                                    fn:substring(fn:replace(data($creditCardRequest1/CustomerShippingInfo/Address/PostalCode), '(\&amp;|\%|\||\^|\\|\/)', ''), 0, 11)
                                                 else
                                                    (fn:replace(data($creditCardRequest1/CustomerShippingInfo/Address/PostalCode), '(\&amp;|\%|\||\^|\\|\/)', ''))
                        	}
                                </ns1:pCardDestZip>
                                {
					for $Total in $creditCardRequest1/OrderDetails/Total
					return
					let $__nullable := ( data($Total) )
					return
						if (fn:boolean($__nullable))
						then
							<ns1:amount>{xs:int(round(data($Total)*100))  }</ns1:amount>
						else
						()
				}
		      <ns1:taxAmount>
                        {
                            if ((fn:string-length(data($creditCardRequest1/OrderDetails/PurchaseOrderNumber)) != 0 and fn:string-length(data($creditCardRequest1/OrderDetails/StateTaxAmount)) = 0)) then
                                ('1')
                            else 
                               xs:int(round(data($creditCardRequest1/OrderDetails/StateTaxAmount)*100))
                        }
                     </ns1:taxAmount>
                    <ns1:amexTranAdvAddn1>
                       {                     
                     		if((data($creditCardRequest1/CardDetails/CreditCardDetails/CreditCardType)='AMEX'))
				then
                    ('This is a new Order')
				else
				()
                     }                    
                     </ns1:amexTranAdvAddn1>
                     
                      <ns1:fraudAnalysis>

                                            <ns1:fraudScoreIndicator>2</ns1:fraudScoreIndicator>
	                            <ns1:rulesTrigger>Y</ns1:rulesTrigger>
	     {
                          let $safetechMerchantIDs:= $safeTechConfig/Properties/MerchantIds[@country=$creditCardRequest1/OrderCountryCode/text()] 
                           return
                                            <ns1:safetechMerchantID>{(data($safetechMerchantIDs/MerchantId[@wsName = $wssecurityusername]))  }</ns1:safetechMerchantID>
	     }
					   
                      {
                  if (fn:exists($creditCardRequest1/FraudAnalysis/KaptchaSessionID))  then
                      for $kaptchaSessionID in $creditCardRequest1/FraudAnalysis/KaptchaSessionID
                      return
		let $__nullable := ( data($kaptchaSessionID) )
		return
		if (fn:boolean($__nullable))
		then
		           <ns1:kaptchaSessionID>{(data($kaptchaSessionID))  }</ns1:kaptchaSessionID>
		else  ()
                else (<ns1:kaptchaSessionID>{fn:tokenize(data($creditCardRequest1/OrderId), '\D+')}</ns1:kaptchaSessionID>)
                      }
                      {        
                      if (fn:exists($creditCardRequest1/FraudAnalysis/WebsiteShortName))  then
                          for $websiteShortName in $creditCardRequest1/FraudAnalysis/WebsiteShortName
	            return
                                    let $__nullable := ( data($websiteShortName) )
                                    return
                                          if (fn:boolean($__nullable))
	     	         then
		              <ns1:websiteShortName>{(data($websiteShortName))  }</ns1:websiteShortName>
                                           else ()
                     else 
                          let $websiteShortName := $safeTechConfig/Properties/Websites[@country=$creditCardRequest1/OrderCountryCode/text()] 
                           return
	                      if (fn:boolean($websiteShortName ))
	                       then
		       <ns1:websiteShortName>{ (data($websiteShortName/Website[@wsName = $wssecurityusername])) }</ns1:websiteShortName>
                                       else()                        
                                       

	     }
		            <ns1:kttVersionNumber>1</ns1:kttVersionNumber>
			                
	     {    
                           if (fn:exists($creditCardRequest1/FraudAnalysis/OrderSource ))  then
                                for $OrderSource in $creditCardRequest1/FraudAnalysis/OrderSource
	                return
                                    let $__nullable := ( data($OrderSource ) )
                                     return
                                         if (fn:boolean($__nullable))
		        then
		           <ns1:kttDataLength>{fn:concat('00',fn:sum((13,(fn:string-length($OrderSource)))))  }</ns1:kttDataLength>
                                         else()
                          else                    
                                            let $OrderSource := $safeTechConfig/Properties/OrderSources/OrderSource[@wsName = $wssecurityusername]
	                            return
	                            if (fn:boolean($OrderSource))
	                               then
		                   <ns1:kttDataLength>{fn:concat('00',fn:sum((13,(fn:string-length($OrderSource)))))  }</ns1:kttDataLength>
                                             else ()
	    }
	    {       
                      if (fn:exists($creditCardRequest1/FraudAnalysis/OrderSource ))  then
                                for $OrderSource in $creditCardRequest1/FraudAnalysis/OrderSource
	                return
                                    let $__nullable := ( data($OrderSource ) )
                                     return
                                         if (fn:boolean($__nullable))
		        then
                                               <ns1:kttDataString>{fn:concat('UORDERSOURCE=', data($OrderSource)) }</ns1:kttDataString>
                                          else ()
                 
                      else 

                       let $OrderSource := $safeTechConfig/Properties/OrderSources/OrderSource[@wsName = $wssecurityusername]
	      return
	       if (fn:boolean($OrderSource))
		then
		             <ns1:kttDataString>{fn:concat('UORDERSOURCE=', data($OrderSource)) }</ns1:kttDataString>
		else
		()
                     }  
                    </ns1:fraudAnalysis>
                      
         </ns1:newOrderRequest>
  </ns1:NewOrder>
};

declare variable $creditCardRequest1 as element(ns0:CreditCardRequest) external;
declare variable $commonDataMapProperties as element(*) external;
declare variable $orbitalPaymentechProperties as element(*) external;
declare variable $wssecurityusername as xs:string external;
declare variable $safeTechConfig as element(*) external;

xf:CreditCardRequest2PaymentTechPreAuth($creditCardRequest1,$orbitalPaymentechProperties,
$commonDataMapProperties,$wssecurityusername , $safeTechConfig)
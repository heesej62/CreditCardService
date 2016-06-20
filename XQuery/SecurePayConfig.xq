xquery version "1.0" encoding "Cp1252";
<SecurePay>
	<TransactionType>
		<value label="Payment">0</value>
		<value label="MobilePayment">1</value>
		<value label="BatchPayment">2</value>
		<value label="PeriodicPayment">3</value>
		<value label="Refund">4</value>
		<value label="ErrorReversal">5</value>
		<value label="ClientReversal">6</value>
		<value label="PreAuth">10</value>
		<value label="PreauthComplete">11</value>
		<value label="RecurringPayment">14</value>
		<value label="DirectEntryDebit">15</value>
		<value label="DirectEntryCrebit">17</value>
		<value label="CardPresentPayment">19</value>
		<value label="IVRPayment">20</value>
	</TransactionType>
	<CardType>
		<value label="UNKNOWN">0</value>
		<value label="JCB">1</value>
		<value label="AMEX">2</value>
		<value label="DINERS CLUB">3</value>
		<value label="BANK CARD">4</value>
		<value label="MASTERCARD">5</value>
		<value label="VISA">6</value>
	</CardType>
	<ResponseStatus>
		<Status statusCode="000" responseCode="00">Success</Status>
		<Status statusCode="000" responseCode="08">Success</Status>
		<Status statusCode="000" responseCode="11">Success</Status>
		<Status statusCode="000" responseCode="16">Success</Status>
		<Status statusCode="000" responseCode="77">Success</Status>
	</ResponseStatus>
	<RequestMode>
		<Mode name="Payment">Prod</Mode>
		<Mode name="Echo">Test</Mode>
	</RequestMode>
	<Properties>
		<TimeoutValue>120</TimeoutValue>
		<APIVersion>xml-4.2</APIVersion>
		<TransactionSource>23</TransactionSource>
		<TransactionCount>1</TransactionCount>
		<TransactionID>1</TransactionID>
		<RequestType>Payment</RequestType>
	</Properties>
</SecurePay>
xquery version "1.0" encoding "Cp1252";
<CreditCardTypes>
          <PrefixCheckEnabled>Y</PrefixCheckEnabled>
        <CreditCard type="MASTERCARD">
                    <Length>16</Length>
                <Algorithm>Luhn</Algorithm>
                <Pattern><![CDATA[^5[1-5]\d{2}-?\d{4}-?\d{4}-?\d{4}$]]></Pattern>
        </CreditCard>
        <CreditCard type="VISA">
                <Length>16,13</Length>
                <Algorithm>Luhn</Algorithm>
                <Pattern><![CDATA[(^(4)\d{3}-?\d{4}-?\d{4}-?\d{4}$)|(^(4)\d{12}$)]]></Pattern>
        </CreditCard>
        <CreditCard type="AMEX">
                <Length>15</Length>
                <Algorithm>Luhn</Algorithm>
                <Pattern><![CDATA[^3[4,7]\d{13}$]]></Pattern>
        </CreditCard>
        <CreditCard type="DISCOVER">
                    <Length>16</Length>
                <Algorithm>Luhn</Algorithm>
                <Pattern><![CDATA[^6011-?\d{4}-?\d{4}-?\d{4}$]]></Pattern>
        </CreditCard>
</CreditCardTypes>
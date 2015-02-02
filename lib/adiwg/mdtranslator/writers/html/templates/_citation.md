>> *Title:* {{ myCitation.citTitle }}
{% if myCitation.citDate[0] %}
    {% assign myDateTime = myCitation.citDate[0] %}
>> *Date:* <br>
    {% include 'dateTime' with myDateTime %}
{% endif %}
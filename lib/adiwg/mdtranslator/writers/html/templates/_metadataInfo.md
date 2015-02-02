## Metadata Information

> ### Metadata Identifier
{% assign identifier = metadata.metadataInfo.metadataId %}
{% include 'identifier' with identifier %} <br>

> ### Parent Metadata
{% if metadata.metadataInfo.parentMetadata %}
   {% assign myCitation = metadata.metadataInfo.parentMetadata %}
   {% include 'citation' with myCitation %}
{% endif %}
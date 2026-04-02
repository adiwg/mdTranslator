# DCAT-US Schema v1.1 Reader

Reads a [DCAT-US Schema v1.1](https://resources.data.gov/resources/dcat-us/) (Project Open Data
Metadata Schema) JSON document and translates the content into the ADIwg mdTranslator
internal object. The input may be either a full catalog document (with a `dataset` array) or
a single dataset object.

## Input formats supported

* Full catalog JSON: `{"conformsTo":"...","dataset":[{...}]}`
* Single dataset JSON: `{"@type":"dcat:Dataset","title":"...",...}`

## Field mapping summary

| DCAT-US Field | Internal Location |
|---|---|
| title | metadata.resourceInfo.citation.title |
| description | metadata.resourceInfo.abstract |
| keyword | metadata.resourceInfo.keywords[] |
| modified | metadata.resourceInfo.citation.dates[dateType=revision] |
| issued | metadata.resourceInfo.citation.dates[dateType=creation] |
| publisher | contacts[] + resourceInfo.citation.responsibleParties[role=publisher] |
| contactPoint | contacts[] + resourceInfo.pointOfContacts[role=pointOfContact] |
| identifier | resourceInfo.citation.identifiers[] + onlineResources[] |
| accessLevel | resourceInfo.constraints[type=legal].legalConstraint.accessCodes |
| bureauCode | contacts[externalIdentifier.namespace=bureauCode] |
| programCode | contacts[externalIdentifier.namespace=programCode] |
| license | resourceInfo.constraints[type=use].reference[].title |
| rights | resourceInfo.constraints[type=use].releasability.statement |
| spatial | resourceInfo.extents[].geographicExtents[].boundingBox |
| temporal | resourceInfo.extents[].temporalExtents[].timePeriod |
| distribution | metadata.distributorInfo[] |
| accrualPeriodicity | metadata.metadataInfo.metadataMaintenance.frequency |
| describedBy | dataDictionaries[].citation.onlineResources[].olResURI |
| describedByType | dataDictionaries[].citation.onlineResources[].olResProtocol |
| isPartOf | metadata.associatedResources[initiativeType=collection] |
| language | metadataInfo.defaultMetadataLocale + otherMetadataLocales |
| landingPage | resourceInfo.citation.onlineResources[function=landingPage] |
| primaryITInvestmentUII | metadataInfo.metadataIdentifier.identifier |
| references | metadata.additionalDocuments[].citation[].onlineResources[] |
| systemOfRecords | metadata.associatedResources[initiativeType=sorn] |
| theme | resourceInfo.keywords[thesaurus.title=ISO Topic Categories] |

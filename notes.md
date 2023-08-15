# DCAT-US - mdTranslator proposed mappings
## Quick references
  - DCAT-US [element definitions](https://resources.data.gov/resources/dcat-us/)
  - DCAT-US v1.1 [JSON schema](https://resources.data.gov/schemas/dcat-us/v1.1/schema/catalog.json)
  - DCAT-US v1.1 [JSON-LD schema](https://resources.data.gov/schemas/dcat-us/v1.1/schema/catalog.jsonld)
  - [Element crosswalks](https://resources.data.gov/resources/podm-field-mapping/#field-mappings) to other standards

## DCAT-US - mdTranslator

### Always (always required)

| Field Name | DCAT Name | mdJson Source |
| --- | --- | --- |
| Title | dcat:title | citation.title |
| Description | dcat:description | citation.abstract |
| Tags | dcat:keyword | [resourceInfo.keywords *flatten*] **thesauri dropped** |
| Last Update | dcat:modified | if resourceInfo.citation.date[any].dateType = "lastUpdated" or "lastRevised" or "revision" then <br> resourceInfo.citation.date[most recent] |
| Publisher | dcat:publisher{name} | if citation.responsibleParty.[any].role = "publisher" then <br> contactId -> contact.name where isOrganization IS TRUE <br> else if exists resourceDistribution.distributor.contact then <br> [first contact] contactId -> contact.name where isOrganization IS TRUE |
| Publisher Parent Organization | dcat:publisher{subOrganizationOf} | if citation.responsibleParty[any].role = "publisher" and exists contactId -> memberOfOrganization[0] and isOrganization is true <br> contactId -> contact.name <br> else if exists resourceDistribution.distributor.contact and exists contactId -> memberOfOrganization[0] and isOrganization IS TRUE <br> contactId -> contact.name |
| Contact Name | dcat:contactPoint{fn} | resourceInfo.pointOfContact.parties[0].contactId -> contact.name |
| Contact Email | dcat:contactPoint{email} | resourceInfo.pointOfContact.parties[0].contactId -> contact.eMailList[0] |
| Unique Identifier | dcat:identifier | if resourceInfo.citation.identifier.namespace = "DOI" then resourceInfo.citation.onlineResource.uri <br> else if "DOI" within resourceInfo.citation.onlineResource.uri then <br> resourceInfo.citation.onlineResource.uri |
| Public Access Level | dcat:accessLevel | [*extend codelist MD_RestrictionCode to include "public",  "restricted  public", "non-public"*] <br> if resourceInfo.constraints.legal[any] one of {"public", "restricted public", "non-public"} then <br>resourceInfo.constraints.legal[first] |
| Bureau Code | dcat:bureauCode | [*extend role codelist to include "bureau", extend namespace codelist to include "bureauCode"*] <br> for each resourceInfo.citation.responsibleParty[any] role = "bureau" <br>contactId -> contact.identifier [*identifier must conform to https://resources.data.gov/schemas/dcat-us/v1.1/omb_bureau_codes.csv*] |
| Program Code | dcat:programCode | [*add new element of program resourceInfo.programCode, add new codelist of programCode*] <br> resourceInfo.program[0,n] |

### If-Applicable (required if it exists)

| Field Name | DCAT Name | mdJson Source |
| --- | --- | --- |
| Distribution | dcat:distribution | if exists resourceDistribution[any] and if exists resourceDistribution.distributor[any].transferOption[any].onlineOption[any].uri <br> for each resourceDistribution[0, n] where exists resourceDistribution.distributor.transferOption.onlineOption.uri then <br> {description, accessURL, downloadURL, mediaType, title} |
| - Description | dcat:distribution.description | resourceDistribution.description |
| - AccessURL | dcat:distribution.accessURL | if citation.onlineResources[first occurence].uri [path ends in ".html"] [*required if applicable*] then <br> resourceDistribution.distributor.transferOption.onlineOption.uri |
| - DownloadURL | dcat.distribution.downloadURL | if citation.onlineResources[first occurence].uri [path does not end in ".html"] [*required if applicable*] then <br> resourceDistribution.distributor.transferOption.onlineOption.uri |
| - MediaType | dcat:distribution.mediaType | [*add codelist of "dataFormat"*] <br> transferOption.distributionFormat.formatSpecification.title [dataFormat] [*dataFormat should conform to: https://www.iana.org/assignments/media-types/media-types.xhtml*] |
| - Title | dcat:distribution.title | resourceDistribution.distributor.transferOption.onlineOption.name |
| License | dcat:license | [*add resourceInfo.constraint.reference to mdEditor*] <br> if exists resourceInfo.constraint.reference[0] then <br> resourceInfo.constraint.reference[0] <br> else https://creativecommons.org/publicdomain/zero/1.0/ <br> [*allows author to identify a license to use, or default to CC0 if none provided, CC0 would cover international usage as opposed to publicdomain*] <br> [*others: http://www.usa.gov/publicdomain/label/1.0/, http://opendatacommons.org/licenses/pddl/1.0*] |
| Rights | dcat:rights | if constraint.accessLevel in {"restricted public", "non-public"} then <br>resourceInfo.constraint.releasibility.statement + " " + each constraint.releasibility.dessiminationConstraint[0, n] |
| Endpoint | *removed* | *ignored* |
| Spatial | dcat:spatial | if exists resourceInfo.extents[0].geographicExtents[0].boundingBox then <br> boundingBox.eastLongitude + "," + boundingBox.southLatitude + "," + boundingBox.westLongitude + "," + boundingBox.northLatitude [*decimal degrees*] <br> else if exists resourceInfo.extents[0].geographicExtents[0].geographicElement[0].type = "point" then <br> geographicElement[0].coordinate[1] + "," + geographicElement[0].coordinate[0] [*lat, long decimal degrees*] |
| Temporal | dcat:temporal | if exists resourceInfo.extent[0].temporalExtent[0] then <br> if exists tempororalExtent[0].timePeriod.startDate and exists temporaralExtent[0].timePeriod.endDate then <br> timePeriod[0].startDate + "/" + timePeriod.endDate <br> else if exists  tempororalExtent[0].timePeriod.startDate and not exists temporaralExtent[0].timePeriod.endDate then tempororalExtent[0].timePeriod.startDate <br> else if not exists temporalExtent[0].timePeriod.startDate and exists temporaralExtent[0].timePeriod.endDate then <br> tempororalExtent[0].timePeriod.endDate <br> [*may need revisiting relative to decision on date only formatting*] |

### No (not required)

| Field Name | DCAT Name | mdJson Source |
| --- | --- | --- |
| Release Date | dcat:issued | if resourceInfo.citation.date[any].dateType = "publication" or "distributed" then <br> resourceInfo.citation.date[earliest] |
| Frequency | dcat:accrualPeriodicity | [*ISO codelist MD_maintenanceFrequency can be used and several codes intersect with accrualPeriod codelist they are partially corresponding. A column of ISO8601 code equivalents could be added to MD_maintenanceFrequency to provide the coding expected https://resources.data.gov/schemas/dcat-us/v1.1/iso8601_guidance/#accrualperiodicity, community valuation should be determined*]  |
| Language | dcat:language | [*language codelist could be used but needs to be bound with country corresponding to the RFC 5646 format https://datatracker.ietf.org/doc/html/rfc5646, such as "en-US", community valuation should be determined* |
| Data Quality | dcat:dataQuality | [*this is a boolean to indicate whether data "conforms" to agency standards, value seems negligble*] |
| Category | dcat:theme | where resourceInfo.keyword[any].thesaurus.title = "ISO Topic Category" <br> [resourceInfo.keyword.keyword[0, n] *flatten*]  |
| Related Documents | dcat:references | associatedResource[all].resourceCitation.onlineResource[all].uri + additionalDocumentation[all].citation[all].onlineResource[all].uri [*comma separated*]|
| Homepage URL | dcat:landingPage | [*Add code "landingPage" to CI_OnlineFunctionCode*] <br> if resourceInfo.citation.onlineResource[any].function = "landingPage" then <br> resourceInfo.citation.onlineResource.uri |
| Collection | dcat:isPartOf | for each associatedResource[0, n].initiativeType = "collection" and associatedResource.associationType = "collectiveTitle" then <br> associatedResource.resourceCitation[0].uri |
| System of Records | dcat:systemOfRecords | [*Add code "sorn" to DS_InitiativeTypeCode*] <br> for each associatedResource[0, n].initiativeType = "sorn" and  then <br> associatedResource.resourceCitation[0].uri |
| Primary IT Investment | dcat:primaryITInvestmentUII | [*Links data to an IT investment identifier relative to Exhibit 53 docs, community valuation should be determined*] |
| Data Dictionary | dcat:describedBy | if dataDictionary.dictionaryIncludedWithResource IS NOT TRUE and citation[0].onlineResource[0].uri exists then <br> dataDictionary.citation[0].onlineResource[0].uri |
| Data Dictionary Type | dcat:describedByType | [*For simplicity, leave blank implying html page, community decision needed whether to support other format types using mime type and in the form of "application/pdf"*]|
| Data Standard | dcat:conformsTo | [*Currently not able to identify the schema standard the data conforms to, though this has been proposed. Should this be built and there is community decision to support it, then it can be mapped*] |

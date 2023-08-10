DCAT-US - mdTranslator

## DCAT-US - mdTranslator

### Always (always required)

| Field Name | DCAT Name | mdJson Source |
| --- | --- | --- |
| Title | dcat:title | citation.title |
| Description | dcat:description | citation.abstract |
| Tags | dcat:keyword | [resourceInfo.keywords *flatten*] **thesauri dropped** |
| Last Update | dcat:modified | citation.dates.[most recent].date |
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
| Release Date | dcat:issued | ** |
| Frequency | dcat:accrualPeriodicity | ** |
| Language | dcat:language | ** |
| Data Quality | dcat:dataQuality | ** |
| Category | dcat:theme | ** |
| Related Documents | dcat:references | ** |
| Homepage URL | dcat:landingPage | ** |
| Collection | dcat:isPartOf | ** |
| System of Records | dcat:systemOfRecords | ** |
| Primary IT Investment | dcat:primaryITInvestmentUII | ** |
| Data Dictionary | dcat:describedBy | ** |
| Data Dictionary Type | dcat:describedByType | ** |
| Data Standard | dcat:conformsTo | ** |

DCAT-US - mdTranslator

## DCAT-US - mdTranslator

### Always (always required)

| Field Name | DCAT Name | mdJson Source |
| --- | --- | --- |
| Title | dcat:title | citation.title |
| Description | dcat:description | citation.abstract |
| Tags | dcat:keyword | [resourceInfo.keywords *flatten*] **thesauri dropped** |
| Last Update | dcat:modified | citation.dates.[most recent].date |
| Publisher | dcat:publisher{name} | if citation.responsibleParty.[any].role = "publisher" then <br>contactId -> contact.name where isOrganization IS TRUE <br>else if resourceDistribution.distributor.contact NOT NULL then <BR>[first contact] contactId -> contact.name where isOrganization IS TRUE <br> |
| Publisher Parent Organization | dcat:publisher{subOrganizationOf} | if citation.responsibleParty[any].role = "publisher" and contactId -> memberOfOrganization[0] NOT NULL and isOrganization IS TRUE <br> contactId -> contact.name <br>else if resourceDistribution.distributor.contact NOT NULL and contactId -> memberOfOrganization[0] NOT NULL and isOrganization IS TRUE <br>contactId -> contact.name |
| Contact Name | dcat:contactPoint{fn} | resourceInfo.pointOfContact.parties[0].contactId -> contact.name |
| Contact Email | dcat:contactPoint{email} | resourceInfo.pointOfContact.parties[0].contactId -> contact.eMailList[0] |
| Unique Identifier | dcat:identifier | if resourceInfo.citation.identifier.namespace = "DOI" then resourceInfo.citation.onlineResource.uri <br>else if "DOI" within resourceInfo.citation.onlineResource.uri then <br>resourceInfo.citation.onlineResource.uri |
| Public Access Level | dcat:accessLevel | [extend codelist MD_RestrictionCode to include "public",  "restricted  public", "non-public"] <br>if resourceInfo.constraints.legal[any] one of {"public", "restricted public", "non-public"} then <br>resourceInfo.constraints.legal[first] |
| Bureau Code | dcat:bureauCode | [extend role codelist to include "bureau"] [extend namespace codelist to include "bureauCode"] <br>for each resourceInfo.citation.responsibleParty[any] role = "bureau" <br>contactId -> contact.identifier (identifier must conform to *https://resources.data.gov/schemas/dcat-us/v1.1/omb_bureau_codes.csv*) |
| Program Code | dcat:programCode | [add new element of program resourceInfo.programCode] [add new codelist of programCode] <br>resourceInfo.program[0,n] |

### If-Applicable (required if it exists)

| Field Name | DCAT Name | mdJson Source |
| --- | --- | --- |
| Distribution | dcat:distribution | if resourceDistribution [0] and for each resourceDistribution [0, n] where resourceDistribution.distributor.transferOption.onlineOption.uri NOT NULL then |
| - Description | dcat:distribution.description | resourceDistribution.description |
| - AccessURL | dcat:distribution.accessURL | if citation.onlineResources [first occurence].uri [path ends in ".html"] then <br> resourceDistribution.distributor.transferOption.onlineOption.uri |
| - DownloadURL | dcat.distribution.downloadURL | if citation.onlineResources [first occurence].uri [path does not end in ".html"] then <br> resourceDistribution.distributor.transferOption.onlineOption.uri |
| - MediaType | dcat:distribution.mediaType | add code of ZIP to mediumName codelist; mediumName is not used in mdJSON schema, needs research, add to schema, not clear where it goes in ISO |
| - Title | dcat:distribution.title | resourceDistribution.distributor.transferOption.onlineOption.name |
| License | dcat:license | 'https://creativecommons.org/publicdomain/zero/1.0/' [shall we default or read from constraint.reference.citation.uri?]<br>'http://www.usa.gov/publicdomain/label/1.0/'<br>'http://opendatacommons.org/licenses/pddl/1.0/' |
| Rights | dcat:rights | if constraint.accessLevel<>'public' then constraint.releasibility.statement + " " + each constraint.releasibility.dessiminationConstraint[0, n] |
| Endpoint | *removed* | *ignored* |
| Spatial | dcat:spatial | if exists resourceInfo.extents[0].geographicExtents[0].boundingBox else if exists resourceInfo.extents[0].geographicExtents[0].description |
| Temporal | dcat:temporal | if exists resourceInfo.extents.temporalExtent[0] then |

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

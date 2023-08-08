DCAT-US - mdTranslator

## DCAT-US - mdTranslator

### Always (always required)

| Field Name | DCAT Name | mdJson Source |
| --- | --- | --- |
| Title | dcat:title | citation.title |
| Description | dcat:description | citation.abstract |
| Tags | dcat:keyword | [resourceInfo.keywords *flatten*] **thesauri dropped** |
| Last Update | dcat:modified | citation.dates.[most recent].date |
| Publisher | dcat:publisher{name} | **if citation.responsibleParty [any] role="publisher" then contactId -> contact.name, else if resourceDistribution.distributor.contact NOT NULL then [first contact] contactId -> contact.name** <br>*Does the publisher need to be an organization?* |
| Publisher Parent Organization | dcat:publisher{subOrganizationOf} | ** |
| Contact Name | dcat:contactPoint{fn} | resourceInfo.pointOfContact.parties[0].contactId -> contact.name |
| Contact Email | dcat:contactPoint{email} | resourceInfo.pointOfContact.parties[0].contactId -> contact.eMailList[0] |
| Unique Identifier | dcat:identifier | ~~metadataInfo.metadataIdentifier.identifier~~ **resourceInfo.citation.onlineResource.uri** |
| Public Access Level | dcat:accessLevel | ~~'public'~~ **[need new code under constraints to distinguish 'public', 'restricted  public', 'non-public']** |
| Bureau Code | dcat:bureauCode | **[add new role of 'bureau'] [add new namespace code for bureauCode] resourceInfo.citation.responsibleParty [any] role='bureau' then contactId -> contact.identifier** |
| Program Code | dcat:programCode | **[add new element of programCode resourceInfo.programCode] [add new codelist of programCode]** |

### If-Applicable (required if it exists)

| Distribution | dcat:distribution | ~~[citation.onlineResources[].uri *object*]~~**if resourceDistribution [0] and for each resourceDistribution [0, n] where resourceDistribution.distributor.transferOption.onlineOption.uri NOT NULL then** |
| --- | --- | --- |
| Description | dcat:distribution.description | resourceDistribution.description |
| AccessURL | dcat:distribution.accessURL | if citation.onlineResources[].uri [has 'doi' in path] then dcat:distribution.accessURL = resourceDistribution.distributor.transferOption.onlineOption.uri [only one access URL allowed, take first one] |
| DownloadURL | dcat.distribution.downloadURL | if citation.onlineResources[].uri [does not have 'doi' in path] then dcat:distribution.downloadURL = resourceDistribution.distributor.transferOption.onlineOption.uri [only one download URL allowed, take first one] |
| MediaType | dcat:distribution.mediaType | [add code of ZIP to mediumName codelist] [mediumName is not used in mdJSON schema, needs research, add to schema, not clear where it goes in ISO] |
| Title | dcat:distribution.title | resourceDistribution.distributor.transferOption.onlineOption.name |

| License | dcat:license | 'https://creativecommons.org/publicdomain/zero/1.0/' [shall we default or read from constraint.reference.citation.uri?]<br>'http://www.usa.gov/publicdomain/label/1.0/'<br>'http://opendatacommons.org/licenses/pddl/1.0/' |
| --- | --- | --- |
| Rights | dcat:rights | **if constraint.accessLevel<>'public' then constraint.releasibility.statement + " " + each constraint.releasibility.dessiminationConstraint[0, n]** |
| Endpoint | *removed* | *ignored* |
| Spatial | dcat:spatial | **if exists** resourceInfo.extents[0].geographicExtents[0].boundingBox **else if exists resourceInfo.extents[0].geographicExtents[0].description** |
| Temporal | dcat:temporal | resourceInfo.extents[0].temporalExtents[0].timeInstant.timeInstant.dateTime |

### No (not required)

| Release Date | dcat:issued | ** |
| --- | --- | --- |
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

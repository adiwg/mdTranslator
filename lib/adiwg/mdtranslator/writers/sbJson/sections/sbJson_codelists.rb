# sbJson 1.0 writer

# History:
#  Stan Smith 2017-05-26 original script

require 'adiwg-mdcodes'

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            module Codelists

               @iso_sb_role = [
                  {iso: 'resourceProvider', sb: 'Resource Provider'},
                  {iso: 'custodian', sb: 'Custodian'},
                  {iso: 'owner', sb: 'Data Owner'},
                  {iso: 'use', sb: 'User'},
                  {iso: 'distributor', sb: 'Distributor'},
                  {iso: 'originator', sb: 'Originator'},
                  {iso: 'pointOfContact', sb: 'Point of Contact'},
                  {iso: 'principalInvestigator', sb: 'Principal Investigator'},
                  {iso: 'processor', sb: 'Processor'},
                  {iso: 'publisher', sb: 'publisher'},
                  {iso: 'author', sb: 'Author'},
                  {iso: 'sponsor', sb: 'sponsor'},
                  {iso: 'coAuthor', sb: 'Author'},
                  {iso: 'collaborator', sb: 'Cooperator/Partner'},
                  {iso: 'editor', sb: 'Editor'},
                  {iso: 'mediator', sb: 'mediator'},
                  {iso: 'rightsHolder', sb: 'Data Owner'},
                  {iso: 'contributor', sb: 'Cooperator/Partner'},
                  {iso: 'contributor', sb: 'Cooperator/Partner'},
                  {iso: 'funder', sb: 'funder'},
                  {iso: 'stakeholder', sb: 'stakeholder'},
                  {iso: 'administrator', sb: 'administrator'},
                  {iso: 'client', sb: 'client'},
                  {iso: 'logistics', sb: 'logistics'},
                  {iso: 'coPrincipalInvestigator', sb: 'Co-Investigator'},
                  {iso: nil, sb: 'Associate Project Chief'},
                  {iso: nil, sb: 'Contact'},
                  {iso: nil, sb: 'Data Provider'},
                  {iso: nil, sb: 'Funding Agency'},
                  {iso: nil, sb: 'Lead Organization'},
                  {iso: nil, sb: 'Material Request Contact'},
                  {iso: nil, sb: 'Metadata Contact'},
                  {iso: nil, sb: 'Participant'},
                  {iso: nil, sb: 'Photographer'},
                  {iso: nil, sb: 'Process Contact'},
                  {iso: nil, sb: 'Project Chief'},
                  {iso: nil, sb: 'Project Team'},
                  {iso: nil, sb: 'Referred By'},
                  {iso: nil, sb: 'Report Prepared By'},
                  {iso: nil, sb: 'SoftwareEngineer'},
                  {iso: nil, sb: 'Subtask Leader'},
                  {iso: nil, sb: 'Supporter'},
                  {iso: nil, sb: 'Task Leader'},
                  {iso: nil, sb: 'Transmitted'},
                  {iso: nil, sb: 'User'},
                  {iso: nil, sb: 'USGS Mission Area'},
                  {iso: nil, sb: 'USGS Program'}
               ]

               @iso_sb_onlineFunction = [
                  {iso: 'download', sb: 'download'},
                  {iso: 'information', sb: 'webLink'},
                  {iso: 'offlineAccess', sb: 'offlineAccess'},
                  {iso: 'order', sb: 'order'},
                  {iso: 'search', sb: 'search'},
                  {iso: 'completeMetadata', sb: 'originalMetadata'},
                  {iso: 'browseGraphic', sb: 'browseImage'},
                  {iso: 'upload', sb: 'upload'},
                  {iso: 'emailService', sb: 'emailService'},
                  {iso: 'browsing', sb: 'browsing'},
                  {iso: 'fileAccess', sb: 'fileAccess'},
                  {iso: 'webApplication', sb: 'webapp'},
                  {iso: 'doi', sb: nil},
                  {iso: 'orcid', sb: nil},
                  {iso: 'dataUri', sb: nil},
                  {iso: nil, sb: 'arcgis'},
                  {iso: nil, sb: 'citation'},
                  {iso: nil, sb: 'configFile'},
                  {iso: nil, sb: 'kml'},
                  {iso: nil, sb: 'mapapp'},
                  {iso: nil, sb: 'method'},
                  {iso: nil, sb: 'oia-pmh'},
                  {iso: nil, sb: 'dpf'},
                  {iso: nil, sb: 'publicationReferenceSouce'},
                  {iso: nil, sb: 'repo'},
                  {iso: nil, sb: 'serviceCapabilitiesUri'},
                  {iso: nil, sb: 'serviceFeatureInfoUri'},
                  {iso: nil, sb: 'serviceLegendUri'},
                  {iso: nil, sb: 'serviceLink'},
                  {iso: nil, sb: 'serviceMapUri'},
                  {iso: nil, sb: 'serviceWfsBackingUri'},
                  {iso: nil, sb: 'siteMap'},
                  {iso: nil, sb: 'sourceCode'},
                  {iso: nil, sb: 'txt'},
                  {iso: nil, sb: 'WAF'},
                  {iso: nil, sb: 'xls'},
                  {iso: nil, sb: 'zip'}

               ]

               @iso_sb_scope = [
                  {iso: 'collectionHardware', sb: 'Collection'},
                  {iso: 'collectionSession', sb: 'Collection'},
                  {iso: 'dataset', sb: 'Data'},
                  {iso: 'document', sb: 'Document'},
                  {iso: 'collection', sb: 'Collection'},
                  {iso: 'application', sb: 'Application'},
                  {iso: 'sciencePaper', sb: 'Report'},
                  {iso: 'project', sb: 'Project'},
                  {iso: 'map', sb: 'Data'},
                  {iso: 'photographicImage', sb: 'Image'},
                  {iso: 'publication', sb: 'Publication'},
                  {iso: 'tabularDataset', sb: 'Data'},
                  {iso: 'report', sb: 'Report'},
                  {iso: 'sample', sb: 'Physical Item'},
                  {iso: 'attribute', sb: nil},
                  {iso: 'attributeType', sb: nil},
                  {iso: 'series', sb: nil},
                  {iso: 'nonGeographicDataset', sb: nil},
                  {iso: 'dimensionGroup', sb: nil},
                  {iso: 'feature', sb: nil},
                  {iso: 'featureType', sb: nil},
                  {iso: 'propertyType', sb: nil},
                  {iso: 'fieldSession', sb: nil},
                  {iso: 'software', sb: nil},
                  {iso: 'model', sb: nil},
                  {iso: 'tile', sb: nil},
                  {iso: 'metadata', sb: nil},
                  {iso: 'repository', sb: nil},
                  {iso: 'aggregate', sb: nil},
                  {iso: 'product', sb: nil},
                  {iso: 'coverage', sb: nil},
                  {iso: 'userGuide', sb: nil},
                  {iso: 'dataDictionary', sb: nil},
                  {iso: 'website', sb: nil},
                  {iso: 'publication', sb: nil},
                  {iso: 'awardInfo', sb: nil},
                  {iso: 'collectionSite', sb: nil},
                  {iso: 'factSheet', sb: nil},
                  {iso: 'drawing', sb: nil},
                  {iso: 'presentation', sb: nil}
               ]

               @iso_sb_date = [
                  {iso: 'creation', sb: 'creation'},
                  {iso: 'publication', sb: 'Publication'},
                  {iso: 'revision', sb: 'revision'},
                  {iso: 'expiry', sb: nil},
                  {iso: 'lastUpdate', sb: 'lastUpdate'},
                  {iso: 'lastRevision', sb: 'lastRevision'},
                  {iso: 'nextUpdate', sb: 'nextUpdate'},
                  {iso: 'unavailable', sb: 'unavailable'},
                  {iso: 'inForce', sb: 'inForce'},
                  {iso: 'adopted', sb: 'Adopted'},
                  {iso: 'deprecated', sb: 'deprecated'},
                  {iso: 'suspended', sb: 'suspended'},
                  {iso: 'validityBegins', sb: 'validityBegins'},
                  {iso: 'validityExpires', sb: 'validityExpires'},
                  {iso: 'released', sb: 'Release'},
                  {iso: 'distribution', sb: 'distribution'},
                  {iso: 'acquisition', sb: 'Acquisition'},
                  {iso: 'assessment', sb: 'AssessmentDate'},
                  {iso: 'award', sb: 'Award'},
                  {iso: nil, sb: 'beginPosition'},
                  {iso: 'collected', sb: 'Collected'},
                  {iso: 'deprecated', sb: 'deprecated'},
                  {iso: 'due', sb: 'Due'},
                  {iso: 'end', sb: 'End'},
                  {iso: nil, sb: 'endPosition'},
                  {iso: nil, sb: 'Info'},
                  {iso: 'received', sb: 'Received'},
                  {iso: 'reported', sb: 'Reported'},
                  {iso: nil, sb: 'Repository Created'},
                  {iso: nil, sb: 'Repository Updated'},
                  {iso: 'start', sb: 'Start'},
                  {iso: 'transmitted', sb: 'Transmitted'}
               ]

               @iso_sb_progress = [
                  {iso: 'completed', sb: 'Completed'},
                  {iso: 'historicalArchive', sb: nil},
                  {iso: 'obsolete', sb: nil},
                  {iso: 'onGoing', sb: 'In Progress'},
                  {iso: 'onGoing', sb: 'Active'},
                  {iso: 'planned', sb: nil},
                  {iso: 'required', sb: nil},
                  {iso: 'underDevelopment', sb: nil},
                  {iso: 'final', sb: nil},
                  {iso: 'pending', sb: nil},
                  {iso: 'retired', sb: nil},
                  {iso: 'superseded', sb: nil},
                  {iso: 'tentative', sb: nil},
                  {iso: 'valid', sb: nil},
                  {iso: 'accepted', sb: 'Approved'},
                  {iso: 'notAccepted', sb: nil},
                  {iso: 'withdrawn', sb: nil},
                  {iso: 'proposed', sb: 'Proposed'},
                  {iso: 'deprecated', sb: nil},
                  {iso: 'funded', sb: nil},
                  {iso: 'cancelled', sb: nil},
                  {iso: 'suspended', sb: nil}
               ]

               # translate iso/adiwg code to sb
               def self.codelist_iso_to_sb(codelist, isoCode: nil, sbCode: nil)

                  codeList = instance_variable_get("@#{codelist}")

                  unless isoCode.nil?
                     codeList.each do |obj|
                        if obj[:iso] == isoCode
                           return obj[:sb]
                        end
                     end
                  end

                  unless sbCode.nil?
                     codeList.each do |obj|
                        if obj[:sb] == sbCode
                           return obj[:iso]
                        end
                     end
                  end

                  # not found
                  return nil

               end

               # test if provided code is a valid sb code
               def self.is_sb_code(codelist, sbCode)
                  codeList = instance_variable_get("@#{codelist}")
                  unless sbCode.nil?
                     codeList.each do |obj|
                        if obj[:sb] == sbCode
                           return true
                        end
                     end
                  end
                  return false
               end

               # get requested codelist from the adiwg-mdcodes gem
               def self.get_code_definition(codeList, code)
                  hCodelist = ADIWG::Mdcodes.getCodelistDetail(codeList, @hResponseObj)
                  hCodelist['codelist'].each do |item|
                     if item['codeName'] == code
                        return item['description']
                     end
                  end
                  return nil
               end

            end

         end
      end
   end
end

# sbJson 1.0 writer

# History:
#  Stan Smith 2017-05-26 original script

require 'adiwg-mdcodes'

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            module Codelists

               @role_adiwg2sb = [
                  {adiwg: 'administrator', sb: 'administrator'},
                  {adiwg: 'author', sb: 'Author'},
                  {adiwg: 'client', sb: 'client'},
                  {adiwg: 'coAuthor', sb: 'Author'},
                  {adiwg: 'collaborator', sb: 'Cooperator/Partner'},
                  {adiwg: 'contributor', sb: 'Cooperator/Partner'},
                  {adiwg: 'coPrincipalInvestigator', sb: 'Co-Investigator'},
                  {adiwg: 'custodian', sb: 'Custodian'},
                  {adiwg: 'distributor', sb: 'Distributor'},
                  {adiwg: 'editor', sb: 'Editor'},
                  {adiwg: 'funder', sb: 'funder'},
                  {adiwg: 'logistics', sb: 'logistics'},
                  {adiwg: 'mediator', sb: 'mediator'},
                  {adiwg: 'originator', sb: 'Originator'},
                  {adiwg: 'owner', sb: 'Data Owner'},
                  {adiwg: 'pointOfContact', sb: 'Point of Contact'},
                  {adiwg: 'principalInvestigator', sb: 'Principal Investigator'},
                  {adiwg: 'processor', sb: 'Processor'},
                  {adiwg: 'publisher', sb: 'publisher'},
                  {adiwg: 'resourceProvider', sb: 'Resource Provider'},
                  {adiwg: 'rightsHolder', sb: 'Data Owner'},
                  {adiwg: 'sponsor', sb: 'sponsor'},
                  {adiwg: 'stakeholder', sb: 'stakeholder'},
                  {adiwg: 'use', sb: 'User'}
               ]

               @onlineFunction_adiwg2sb = [
                  {adiwg: 'browseGraphic', sb: 'browseImage'},
                  {adiwg: 'browsing', sb: 'browsing'},
                  {adiwg: 'completeMetadata', sb: 'originalMetadata'},
                  {adiwg: 'dataUri', sb: nil},
                  {adiwg: 'doi', sb: nil},
                  {adiwg: 'download', sb: 'download'},
                  {adiwg: 'emailService', sb: 'emailService'},
                  {adiwg: 'fileAccess', sb: 'fileAccess'},
                  {adiwg: 'information', sb: 'webLink'},
                  {adiwg: 'offlineAccess', sb: 'offlineAccess'},
                  {adiwg: 'orcid', sb: nil},
                  {adiwg: 'order', sb: 'order'},
                  {adiwg: 'search', sb: 'search'},
                  {adiwg: 'upload', sb: 'upload'},
                  {adiwg: 'webApplication', sb: 'webapp'}
               ]

               @scope_adiwg2sb = [
                  {adiwg: 'aggregate', sb: nil},
                  {adiwg: 'application', sb: 'Application'},
                  {adiwg: 'attribute', sb: nil},
                  {adiwg: 'attributeType', sb: nil},
                  {adiwg: 'awardInfo', sb: nil},
                  {adiwg: 'collection', sb: 'Collection'},
                  {adiwg: 'collectionHardware', sb: nil},
                  {adiwg: 'collectionSession', sb: nil},
                  {adiwg: 'collectionSite', sb: nil},
                  {adiwg: 'coverage', sb: nil},
                  {adiwg: 'dataDictionary', sb: nil},
                  {adiwg: 'dataset', sb: 'Data'},
                  {adiwg: 'dimensionGroup', sb: nil},
                  {adiwg: 'document', sb: 'Document'},
                  {adiwg: 'drawing', sb: nil},
                  {adiwg: 'factSheet', sb: nil},
                  {adiwg: 'feature', sb: nil},
                  {adiwg: 'featureType', sb: nil},
                  {adiwg: 'fieldSession', sb: nil},
                  {adiwg: 'initiative', sb: nil},
                  {adiwg: 'map', sb: 'map'},
                  {adiwg: 'metadata', sb: nil},
                  {adiwg: 'model', sb: nil},
                  {adiwg: 'nonGeographicDataset', sb: nil},
                  {adiwg: 'photographicImage', sb: 'Image'},
                  {adiwg: 'presentation', sb: nil},
                  {adiwg: 'product', sb: nil},
                  {adiwg: 'project', sb: 'Project'},
                  {adiwg: 'propertyType', sb: nil},
                  {adiwg: 'publication', sb: 'Publication'},
                  {adiwg: 'report', sb: 'Report'},
                  {adiwg: 'repository', sb: nil},
                  {adiwg: 'sample', sb: 'Physical Item'},
                  {adiwg: 'sciencePaper', sb: 'Report'},
                  {adiwg: 'series', sb: nil},
                  {adiwg: 'service', sb: nil},
                  {adiwg: 'software', sb: 'Software'},
                  {adiwg: 'tabularDataset', sb: 'Data'},
                  {adiwg: 'tile', sb: nil},
                  {adiwg: 'userGuide', sb: nil},
                  {adiwg: 'website', sb: 'Web Site'}
               ]

               @date_adiwg2sb = [
                  {adiwg: 'acquisition', sb: 'Acquisition'},
                  {adiwg: 'adopted', sb: 'Adopted'},
                  {adiwg: 'assessment', sb: 'AssessmentDate'},
                  {adiwg: 'award', sb: 'Award'},
                  {adiwg: 'collected', sb: 'Collected'},
                  {adiwg: 'creation', sb: 'creation'},
                  {adiwg: 'deprecated', sb: 'deprecated'},
                  {adiwg: 'distribution', sb: 'distribution'},
                  {adiwg: 'due', sb: 'Due'},
                  {adiwg: 'end', sb: 'End'},
                  {adiwg: 'expiry', sb: nil},
                  {adiwg: 'inForce', sb: 'inForce'},
                  {adiwg: 'lastRevision', sb: 'lastRevision'},
                  {adiwg: 'lastUpdate', sb: 'lastUpdate'},
                  {adiwg: 'nextUpdate', sb: 'nextUpdate'},
                  {adiwg: 'publication', sb: 'Publication'},
                  {adiwg: 'received', sb: 'Received'},
                  {adiwg: 'released', sb: 'Release'},
                  {adiwg: 'reported', sb: 'Reported'},
                  {adiwg: 'revision', sb: 'revision'},
                  {adiwg: 'start', sb: 'Start'},
                  {adiwg: 'suspended', sb: 'suspended'},
                  {adiwg: 'transmitted', sb: 'Transmitted'},
                  {adiwg: 'unavailable', sb: 'unavailable'},
                  {adiwg: 'validityBegins', sb: 'validityBegins'},
                  {adiwg: 'validityExpires', sb: 'validityExpires'}
               ]

               @progress_adiwg2sb = [
                  {adiwg: 'accepted', sb: 'Approved'},
                  {adiwg: 'cancelled', sb: nil},
                  {adiwg: 'completed', sb: 'Completed'},
                  {adiwg: 'deprecated', sb: nil},
                  {adiwg: 'final', sb: nil},
                  {adiwg: 'funded', sb: nil},
                  {adiwg: 'historicalArchive', sb: nil},
                  {adiwg: 'notAccepted', sb: nil},
                  {adiwg: 'obsolete', sb: nil},
                  {adiwg: 'onGoing', sb: 'In Progress'},
                  {adiwg: 'pending', sb: nil},
                  {adiwg: 'planned', sb: nil},
                  {adiwg: 'proposed', sb: 'Proposed'},
                  {adiwg: 'required', sb: nil},
                  {adiwg: 'retired', sb: nil},
                  {adiwg: 'superseded', sb: nil},
                  {adiwg: 'suspended', sb: nil},
                  {adiwg: 'tentative', sb: nil},
                  {adiwg: 'underDevelopment', sb: nil},
                  {adiwg: 'valid', sb: nil},
                  {adiwg: 'withdrawn', sb: nil}
               ]

               @association_adiwg2sb = [
                  {adiwg: 'collectiveTitle', sb: nil},
                  {adiwg: 'crossReference', sb: 'alternate'},
                  {adiwg: 'dependency', sb: nil},
                  {adiwg: 'derivativeProduct', sb: 'derivativeOf'},
                  {adiwg: 'isComposedOf', sb: 'constituentOf'},
                  {adiwg: 'largerWorkCitation', sb: nil},
                  {adiwg: 'parentProject', sb: 'productOf'},
                  {adiwg: 'partOfSeamlessDatabase', sb: nil},
                  {adiwg: 'product', sb: 'productOf'},
                  {adiwg: 'revisionOf', sb: nil},
                  {adiwg: 'series', sb: nil},
                  {adiwg: 'source', sb: nil},
                  {adiwg: 'stereoMate', sb: nil},
                  {adiwg: 'subProject', sb: 'subprojectOf'},
                  {adiwg: 'supplementalResource', sb: nil},

                  {adiwg: 'mainprojectOf', sb: 'subprojectOf', deprecated: true},
                  {adiwg: 'produced', sb: 'productOf', deprecated: true},
                  {adiwg: 'productOf', sb: 'productOf', deprecated: true},
                  {adiwg: 'projectProduct', sb: 'productOf', deprecated: true},
                  {adiwg: 'subprojectOf', sb: 'subprojectOf', deprecated: true}
               ]

               # translate iso/adiwg code to sb
               def self.codelist_adiwg2sb(codelist, adiwgCode)
                  codeList = instance_variable_get("@#{codelist}")
                  unless adiwgCode.nil?
                     codeList.each do |obj|
                        if obj[:adiwg] == adiwgCode
                           return obj[:sb]
                        end
                     end
                  end
                  return nil
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

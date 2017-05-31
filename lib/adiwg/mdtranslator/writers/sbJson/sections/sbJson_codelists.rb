# sbJson 1.0 writer

# History:
#  Stan Smith 2017-05-26 original script

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            module Codelists

               @iso_sb_role = [
                  {iso: 'resourceProvider', sb: 'Resource Provider'},
                  {iso: 'custodian', sb: 'Custodian'},
                  {iso: 'rightsHolder', sb: 'Data Owner'},
                  {iso: 'use', sb: 'User'},
                  {iso: 'distributor', sb: 'Distributor'},
                  {iso: 'originator', sb: 'Originator'},
                  {iso: 'pointOfContact', sb: 'Point of Contact'},
                  {iso: 'principalInvestigator', sb: 'Principal Investigator'},
                  {iso: 'processor', sb: 'Processor'},
                  {iso: 'author', sb: 'Author'},
                  {iso: 'coAuthor', sb: 'Author'},
                  {iso: 'collaborator', sb: 'Cooperator/Partner'},
                  {iso: 'contributor', sb: 'Cooperator/Partner'},
                  {iso: 'editor', sb: 'Editor'},
                  {iso: 'coPrincipalInvestigator', sb: 'Co-Investigator'}
               ]

               @iso_sb_onlineFunction = [
                  {iso: 'information', sb: 'webLink'},
                  {iso: 'completeMetadata', sb: 'originalMetadata'},
                  {iso: 'browseGraphic', sb: 'browseImage'},
                  {iso: 'webApplication', sb: 'webapp'}
               ]

               def self.codelist_iso_to_sb(codelist, isoCode: nil, sbCode: nil)

                  codeList = instance_variable_get("@#{codelist}")

                  unless isoCode.nil?
                     codeList.each do |obj|
                        if obj[:iso] == isoCode
                           return obj[:sb]
                        end
                     end
                     return isoCode
                  end

                  unless sbCode.nil?
                     codeList.each do |obj|
                        if obj[:sb] == sbCode
                           return obj[:iso]
                        end
                     end
                     return sbCode
                  end

                  # both isoCode and sbCode nil
                  return nil

               end

            end

         end
      end
   end
end

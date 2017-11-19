# FGDC <<Class>> Citation
# FGDC CSDGM writer output in XML

# History:
#   Stan Smith 2017-11-17 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class Citation

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hCitation)

                  @xml.tag!('citeinfo') do

                     # citation 1.1.1 (origin) - originator [] (required)
                     # <- hCitation[:responsibleParties] role = 'originator'
                     haveOriginator = false
                     aOriginators = []
                     hCitation[:responsibleParties].each do |hRParty|
                        if hRParty[:roleName] == 'originator'
                           aOriginators = aOriginators.concat(hRParty[:parties])
                        end
                     end
                     aOriginators.each do |hParty|
                        hContact = ADIWG::Mdtranslator::Writers::Fgdc.getContact(hParty[:contactId])
                        unless hContact.empty?
                           name = hContact[:name]
                           unless name.nil?
                              @xml.tag!('origin', name)
                              haveOriginator = true
                           end
                        end
                     end
                     unless haveOriginator
                        @hResponseObj[:writerPass] = false
                        @hResponseObj[:writerMessages] << 'Citation is missing originator'
                     end

                     # citation 1.1.2 (pubdate) - publication date (required)
                     # citation 1.1.3 (pubtime) - publication time
                     # citation 1.1.4 (title) - title (required)
                     # citation 1.1.5 (edition) - edition
                     # citation 1.1.6 (geoform) - geospatial data presentation form
                     # citation 1.1.7 (serinfo) - series information
                     # citation 1.1.8 (pubinfo) - publication information
                     # citation 1.1.9 (othercit) - other citation details
                     # citation 1.1.10 (onlink) - online linkage []
                     # citation 1.1.11 (lworkcit) - larger work citation

                  end # citeinfo tag
               end # writeXML
            end # Citation

         end
      end
   end
end

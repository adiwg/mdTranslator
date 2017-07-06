# unpack web link (resource)
# Reader - ScienceBase JSON to internal data structure

# History:
#   Stan Smith 2016-06-22 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module SbJson

            module WebLinkDocument

               def self.unpack(hSbJson, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  aLinks = []

                  if hSbJson.has_key?('webLinks')

                     hSbJson['webLinks'].each do |hLink|
                        unless hLink.empty?

                           # web link - type (required)
                           type = nil
                           if hLink.has_key?('type')
                              type = hLink['type']
                           end
                           if type.nil? || type == ''
                              hResponseObj[:readerExecutionMessages] << 'WebLinks type is missing'
                              hResponseObj[:readerExecutionPass] = false
                              return nil
                           end

                           # handle non-browse links
                           if type != 'browseImage'

                              hDocument = intMetadataClass.newAdditionalDocumentation
                              hResType = intMetadataClass.newResourceType

                              # web link - type
                              hResType[:type] = type

                              # web link - type label
                              if hLink.has_key?('typeLabel')
                                 unless hLink['typeLabel'].nil? || hLink['typeLabel'] == ''
                                    hResType[:name] = hLink['typeLabel']
                                 end
                              end

                              # web link - title
                              hCitation = intMetadataClass.newCitation
                              if hLink.has_key?('title')
                                 hCitation[:title] = hLink['title']
                              end
                              if hCitation[:title].nil? || hCitation[:title] == ''
                                 hCitation[:title] = 'Online Resource'
                              end

                              # web link - uri (required)
                              hOlRes = intMetadataClass.newOnlineResource
                              if hLink.has_key?('uri')
                                 hOlRes[:olResURI] = hLink['uri']
                              end
                              if hOlRes[:olResURI].nil? || hOlRes[:olResURI] == ''
                                 hResponseObj[:readerExecutionMessages] << 'WebLinks URI is missing'
                                 hResponseObj[:readerExecutionPass] = false
                                 return nil
                              end
                              hCitation[:onlineResources] << hOlRes

                              hDocument[:resourceTypes] << hResType
                              hDocument[:citation] << hCitation
                              aLinks << hDocument

                           end

                        end

                     end

                     return aLinks

                  end

                  return nil

               end

            end

         end
      end
   end
end

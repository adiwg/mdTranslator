# unpack web link (graphic)
# Reader - ScienceBase JSON to internal data structure

# History:
#   Stan Smith 2016-06-22 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module SbJson

            module WebLinkGraphic

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
                              hResponseObj[:readerExecutionMessages] << 'WebLink type is missing'
                              return nil
                           end

                           # only handle browse links
                           if type == 'browseImage'

                              hGraphic = intMetadataClass.newGraphic

                              # web link - type
                              hGraphic[:graphicType] = type

                              # web link - type label
                              if hLink.has_key?('typeLabel')
                                 unless hLink['typeLabel'].nil? || hLink['typeLabel'] == ''
                                    hGraphic[:graphicDescription] = hLink['typeLabel']
                                 end
                              end

                              # web link - title
                              if hLink.has_key?('title')
                                 hGraphic[:graphicName] = hLink['title']
                              end

                              # web link - uri (required)
                              hOlRes = intMetadataClass.newOnlineResource
                              if hLink.has_key?('uri')
                                 hOlRes[:olResURI] = hLink['uri']
                              end
                              if hOlRes[:olResURI].nil? || hOlRes[:olResURI] == ''
                                 hResponseObj[:readerExecutionMessages] << 'WebLink URI is missing'
                                 hResponseObj[:readerExecutionMessages] << 'WebLink skipped'
                                 return nil
                              end
                              hGraphic[:graphicURI] << hOlRes

                              aLinks << hGraphic

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

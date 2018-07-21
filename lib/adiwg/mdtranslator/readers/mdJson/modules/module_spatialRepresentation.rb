# unpack spatial representation
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-25 refactored error and warning messaging
#  Stan Smith 2016-10-19 original script

require_relative 'module_gridRepresentation'
require_relative 'module_vectorRepresentation'
require_relative 'module_georectifiedRepresentation'
require_relative 'module_georeferenceableRepresentation'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module SpatialRepresentation

               def self.unpack(hRepresent, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hRepresent.empty?
                     @MessagePath.issueWarning(790, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intRepresent = intMetadataClass.newSpatialRepresentation

                  outContext = 'spatial representation'
                  outContext = inContext + ' > ' + outContext unless inContext.nil?

                  haveOne = false

                  # spatial representation - grid representation (required if not others)
                  if hRepresent.has_key?('gridRepresentation')
                     hRep = hRepresent['gridRepresentation']
                     unless hRep.empty?
                        hObject = GridRepresentation.unpack(hRep, responseObj, outContext)
                        unless hObject.nil?
                           intRepresent[:gridRepresentation] = hObject
                           haveOne = true
                        end
                     end
                  end

                  # spatial representation - vector representation (required if not others)
                  if hRepresent.has_key?('vectorRepresentation')
                     hRep = hRepresent['vectorRepresentation']
                     unless hRep.empty?
                        hObject = VectorRepresentation.unpack(hRep, responseObj, outContext)
                        unless hObject.nil?
                           intRepresent[:vectorRepresentation] = hObject
                           haveOne = true
                        end
                     end
                  end

                  # spatial representation - georectified representation (required if not others)
                  if hRepresent.has_key?('georectifiedRepresentation')
                     hRep = hRepresent['georectifiedRepresentation']
                     unless hRep.empty?
                        hObject = GeorectifiedRepresentation.unpack(hRep, responseObj, outContext)
                        unless hObject.nil?
                           intRepresent[:georectifiedRepresentation] = hObject
                           haveOne = true
                        end
                     end
                  end

                  # spatial representation - georeferenceable representation (required if not others)
                  if hRepresent.has_key?('georeferenceableRepresentation')
                     hRep = hRepresent['georeferenceableRepresentation']
                     unless hRep.empty?
                        hObject = GeoreferenceableRepresentation.unpack(hRep, responseObj, outContext)
                        unless hObject.nil?
                           intRepresent[:georeferenceableRepresentation] = hObject
                           haveOne = true
                        end
                     end
                  end

                  # error messages
                  unless haveOne
                     @MessagePath.issueError(791, responseObj, inContext)
                  end

                  return intRepresent

               end

            end

         end
      end
   end
end

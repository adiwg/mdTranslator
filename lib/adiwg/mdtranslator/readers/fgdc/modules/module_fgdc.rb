# Reader - fgdc to internal data structure
# unpack fgdc metadata

# History:
#  Stan Smith 2017-08-10 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_identification'
require_relative 'module_quality'
require_relative 'module_spatialOrganization'
require_relative 'module_spatialReference'
require_relative 'module_entityAttribute'
require_relative 'module_distribution'
require_relative 'module_metadataInfo'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module Fgdc

               def self.unpack(xDoc, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  intObj = intMetadataClass.newBase
                  @intObj = intObj
                  @contacts = intObj[:contacts]
                  @xDoc = xDoc

                  # build basic mdTranslator internal object
                  hMetadata = intMetadataClass.newMetadata
                  hMetadataInfo = intMetadataClass.newMetadataInfo
                  hResourceInfo = intMetadataClass.newResourceInfo
                  hMetadata[:metadataInfo] = hMetadataInfo
                  hMetadata[:resourceInfo] = hResourceInfo
                  intObj[:metadata] = hMetadata

                  xMetadata = xDoc.xpath('./metadata')

                  # metadata (idinfo 1) - identification information (required)
                  xIdInfo = xMetadata.xpath('./idinfo')
                  unless xIdInfo.empty?
                     Identification.unpack(xIdInfo, intObj, hResponseObj)
                  end
                  if xIdInfo.empty?
                     hResponseObj[:readerExecutionMessages] << 'FGDC is missing identification information section (idinfo)'
                  end

                  # metadata (dataqual 2) - data quality
                  xDataQual = xMetadata.xpath('./dataqual')
                  unless xDataQual.empty?
                     Quality.unpack(xDataQual, hResponseObj)
                  end

                  # metadata (spdoinfo 3) - spatial data organization
                  xSpatialOrg = xMetadata.xpath('./spdoinfo')
                  unless xSpatialOrg.empty?
                     SpatialOrganization.unpack(xSpatialOrg, hResponseObj)
                  end

                  # metadata (spref 4) - spatial reference
                  xSpatialRef = xMetadata.xpath('./spref')
                  unless xSpatialRef.empty?
                     SpatialReference.unpack(xSpatialRef, hResponseObj)
                  end

                  # metadata (eainfo 5) - entity and attribute
                  xEntity = xMetadata.xpath('./eainfo')
                  unless xEntity.empty?
                     EntityAttribute.unpack(xEntity, hResponseObj)
                  end

                  # metadata (distinfo 6) - distribution information
                  xDistribution = xMetadata.xpath('./distinfo')
                  unless xDistribution.empty?
                     Distribution.unpack(xDistribution, hResponseObj)
                  end

                  # metadata (metainfo 7) - metadata reference (required)
                  xMetaInfo = xMetadata.xpath('./metainfo')
                  unless xMetaInfo.empty?
                     MetadataInformation.unpack(xMetaInfo, hResponseObj)
                  end
                  if xMetaInfo.empty?
                     hResponseObj[:readerExecutionMessages] << 'FGDC is missing metadata information section (metainfo)'
                  end

                  return intObj

               end

               # find the array pointer and type for a contact
               def self.find_contact_by_id(contactId)
                  contactIndex = nil
                  contactType = nil
                  @contacts.each_with_index do |contact, i|
                     if contact[:contactId] == contactId
                        contactIndex = i
                        if contact[:isOrganization]
                           contactType = 'organization'
                        else
                           contactType = 'individual'
                        end
                     end
                  end
                  return contactIndex, contactType
               end

               # find contact id for a name
               def self.find_contact_by_name(contactName)
                  @contacts.each do |contact|
                     if contact[:name] == contactName
                        return contact[:contactId]
                     end
                  end
                  return nil
               end

               # add new contact to contacts array
               def self.add_contact(hContact)
                  @contacts << hContact
               end

               # set an internal object for tests
               def self.set_intObj(intObj)
                  @intObj = intObj
                  @contacts = @intObj[:contacts]
               end

               # get internal object for test modules
               def self.get_intObj
                  return @intObj
               end

               # get metadata time convention
               def self.get_metadata_time_convention
                  return @xDoc.xpath('./metadata/metainfo/mettc').text
               end

               # set @xDoc for minitests
               def self.set_xDoc(xDoc)
                  @xDoc = xDoc
               end

               # add new associated resource
               def self.add_associated_resource(hResource)
                  @intObj[:metadata][:associatedResources] << hResource
               end

            end

         end
      end
   end
end

# Reader - fgdc to internal data structure
# unpack fgdc metadata

# History:
#  Stan Smith 2017-08-10 original script

require 'nokogiri'
require 'uuidtools'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative '../version'
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
                  hResourceInfo = intMetadataClass.newResourceInfo
                  hMetadata[:resourceInfo] = hResourceInfo
                  intObj[:metadata] = hMetadata

                  xMetadata = xDoc.xpath('./metadata')

                  # schema
                  hSchema = intMetadataClass.newSchema
                  hSchema[:name] = 'fgdc'
                  hSchema[:version] = ADIWG::Mdtranslator::Readers::Fgdc::VERSION
                  @intObj[:schema] = hSchema

                  # metadata (idinfo 1) - identification information (required)
                  xIdInfo = xMetadata.xpath('./idinfo')
                  unless xIdInfo.empty?
                     Identification.unpack(xIdInfo, intObj, hResponseObj)
                  end
                  if xIdInfo.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC identification information section (idinfo) missing'
                  end

                  # metadata (dataqual 2) - data quality
                  xDataQual = xMetadata.xpath('./dataqual')
                  unless xDataQual.empty?
                     Quality.unpack(xDataQual, hMetadata, hResponseObj)
                  end

                  # metadata (spdoinfo 3) - spatial data organization
                  xSpatialOrg = xMetadata.xpath('./spdoinfo')
                  unless xSpatialOrg.empty?
                     SpatialOrganization.unpack(xSpatialOrg, hResourceInfo, hResponseObj)
                  end

                  # metadata (spref 4) - spatial reference
                  xSpatialRef = xMetadata.xpath('./spref')
                  unless xSpatialRef.empty?
                     SpatialReference.unpack(xSpatialRef, hResourceInfo, hResponseObj)
                  end

                  # metadata (eainfo 5) - entity and attribute
                  xEntity = xMetadata.xpath('./eainfo')
                  unless xEntity.empty?
                     hDictionary = EntityAttribute.unpack(xEntity, hResponseObj)
                     unless hDictionary.nil?
                        @intObj[:dataDictionaries] << hDictionary
                     end
                  end

                  # metadata (distinfo 6) - distribution information []
                  axDistribution = xMetadata.xpath('./distinfo')
                  unless axDistribution.empty?
                     axDistribution.each do |xDistribution|
                        hDistribution = Distribution.unpack(xDistribution, hResponseObj)
                        unless hDistribution.nil?
                           hMetadata[:distributorInfo] << hDistribution
                        end
                     end
                  end

                  # metadata (metainfo 7) - metadata reference (required)
                  xMetaInfo = xMetadata.xpath('./metainfo')
                  unless xMetaInfo.empty?
                     hMetadataInfo = MetadataInformation.unpack(xMetaInfo, hResponseObj)
                     unless hMetadataInfo.nil?
                        hMetadata[:metadataInfo] = hMetadataInfo
                     end
                  end
                  if xMetaInfo.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC metadata information section (metainfo) missing'
                  end

                  return intObj

               end

               # find the array pointer and type for a contact
               def self.find_contact_by_id(contactId)
                  contactIndex = nil
                  contactType = nil
                  unless @contacts.empty?
                     @contacts.each_with_index do |contact, i|
                        if contact[:contactId] == contactId
                           if contact[:isOrganization]
                              contactType = 'organization'
                           else
                              contactType = 'individual'
                           end
                           contactIndex = i
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
               def self.add_contact(name, isOrg)
                  contactId = find_contact_by_name(name)
                  if contactId.nil?
                     intMetadataClass = InternalMetadata.new
                     hContact = intMetadataClass.newContact
                     contactId = UUIDTools::UUID.random_create.to_s
                     hContact[:contactId] = contactId
                     hContact[:name] = name
                     hContact[:isOrganization] = isOrg
                     @contacts << hContact
                  end
                  return contactId
               end

               # return contact by id
               def self.get_contact_by_id(contactId)
                  index = find_contact_by_id(contactId)[0]
                  unless index.nil?
                     return @contacts[index]
                  end
                  return nil
               end

               # add or replace the contact
               def self.set_contact(hContact)
                  index = find_contact_by_id(hContact[:contactId])[0]
                  if index.nil?
                     @contacts << hContact
                     index = @contacts.length - 1
                  else
                     @contacts[index] = hContact
                  end
                  return index
               end

               # set an internal object for tests
               def self.set_intObj(intObj)
                  @intObj = intObj
                  @contacts = @intObj[:contacts]
               end

               # get internal object
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

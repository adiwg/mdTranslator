# unpack mdJson
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-21 refactored error and warning messaging
#  Stan Smith 2016-11-07 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_schema'
require_relative 'module_contact'
require_relative 'module_contactPostprocess'
require_relative 'module_metadata'
require_relative 'module_dataDictionary'
require_relative 'module_metadataRepository'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module MdJson

               def self.unpack(hMdJson, responseObj)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # load error messages
                  loadMessages

                  # return nil object if input is empty
                  if hMdJson.empty?
                     @MessagePath.issueError(530, responseObj)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intObj = intMetadataClass.newBase

                  # mdJson - schema {schema} (required)
                  if hMdJson.has_key?('schema')
                     hObject = hMdJson['schema']
                     unless hObject.empty?
                        hReturn = Schema.unpack(hObject, responseObj)
                        unless hReturn.nil?
                           intObj[:schema] = hReturn
                        end
                     end
                  end
                  if intObj[:schema].empty?
                     @MessagePath.issueError(531, responseObj)
                  end

                  # mdJson - contact [] {contact} (required)
                  if hMdJson.has_key?('contact')
                     aItems = hMdJson['contact']
                     aItems.each do |item|
                        hReturn = Contact.unpack(item, responseObj)
                        unless hReturn.nil?
                           intObj[:contacts] << hReturn
                           @contacts = intObj[:contacts]
                        end
                     end
                     ContactPost.examine(@contacts, responseObj)
                     unless responseObj[:readerExecutionPass]
                        return nil
                     end
                  end
                  if intObj[:contacts].empty?
                     @MessagePath.issueError(532, responseObj)
                  end

                  # mdJson - metadata {metadata}
                  if hMdJson.has_key?('metadata')
                     hObject = hMdJson['metadata']
                     unless hObject.empty?
                        hReturn = Metadata.unpack(hObject, responseObj)
                        unless hReturn.nil?
                           intObj[:metadata] = hReturn
                        end
                     end
                  end
                  if intObj[:metadata].empty?
                     @MessagePath.issueNotice(533, responseObj)
                  end

                  # mdJson - data dictionary [] {dataDictionary}
                  if hMdJson.has_key?('dataDictionary')
                     aItems = hMdJson['dataDictionary']
                     aItems.each do |hItem|
                        hReturn = DataDictionary.unpack(hItem, responseObj)
                        unless hReturn.nil?
                           intObj[:dataDictionaries] << hReturn
                        end
                     end
                  end

                  # metadata - metadata distribution [] {metadataDistribution}
                  if hMdJson.has_key?('metadataRepository')
                     aItems = hMdJson['metadataRepository']
                     aItems.each do |item|
                        hReturn = MetadataRepository.unpack(item, responseObj)
                        unless hReturn.nil?
                           intObj[:metadataRepositories] << hReturn
                        end
                     end
                  end

                  return intObj

               end

               # helper methods
               # set contacts array for reader test modules
               def self.setContacts(contacts)
                  @contacts = contacts
               end

               # find the array pointer and type for a contact
               def self.findContact(contactId)

                  contactIndex = nil
                  contactType = nil
                  contactName = nil
                  @contacts.each_with_index do |contact, i|
                     if contact[:contactId] == contactId
                        contactIndex = i
                        if contact[:isOrganization]
                           contactType = 'organization'
                        else
                           contactType = 'individual'
                        end
                        contactName = contact[:name]
                     end
                  end
                  return contactIndex, contactType, contactName

               end

               # load error message array
               def self.loadMessages
                  messageFile = File.join(File.dirname(__FILE__), '../mdJson_reader_messages_eng') + '.yml'
                  hMessageList = YAML.load_file(messageFile)
                  @messages = hMessageList['messageList']
               end

               def self.findMessage(messageId)
                  @messages.each do |hMessage|
                     if hMessage['id'] == messageId
                        return hMessage['message']
                     end
                  end
                  return nil
               end

               def self.issueError(messageId, hResponseObj, context = nil)
                  message = findMessage(messageId)
                  unless message.nil?
                     message += ': CONTEXT is ' + context unless context.nil?
                     hResponseObj[:readerExecutionMessages] << 'ERROR: mdJson reader: ' + message
                     hResponseObj[:readerExecutionPass] = false
                  end
               end

               def self.issueWarning(messageId, hResponseObj, context = nil)
                  message = findMessage(messageId)
                  unless message.nil?
                     message += ': CONTEXT is ' + context unless context.nil?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: mdJson reader: ' + message
                  end
               end

               def self.issueNotice(messageId, hResponseObj, context = nil)
                  message = findMessage(messageId)
                  unless message.nil?
                     message += ': CONTEXT is ' + context unless context.nil?
                     hResponseObj[:readerExecutionMessages] << 'NOTICE: mdJson reader: ' + message
                  end
               end

            end

         end
      end
   end
end

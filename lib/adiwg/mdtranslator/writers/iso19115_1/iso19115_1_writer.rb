# Writer - internal data structure to ISO 19115-1:2014

# History:
# 	Stan Smith 2019-03-12 original script

require 'builder'
require 'adiwg/mdtranslator/writers/iso19115_1/version'
require_relative 'classes/class_mdMetadata'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            def self.startWriter(intObj, hResponseObj)

               # make contact available to the instance
               @contacts = intObj[:contacts]
               @hResponseObj = hResponseObj

               # load error message array
               file = File.join(File.dirname(__FILE__), 'iso19115_1_writer_messages_eng') + '.yml'
               hMessageList = YAML.load_file(file)
               @aMessagesList = hMessageList['messageList']

               # set the format of the output file based on the writer specified
               hResponseObj[:writerOutputFormat] = 'xml'
               hResponseObj[:writerVersion] = ADIWG::Mdtranslator::Writers::Iso19115_1::VERSION

               # create new XML document
               @xml = Builder::XmlMarkup.new(indent: 3)

               # start writing the ISO 19115-1 XML record
               metadataWriter = MD_Metadata.new(@xml, hResponseObj)
               metadata = metadataWriter.writeXML(intObj)

               return metadata

            end

            # find contact in contact array and return the contact hash
            def self.getContact(contactId)

               @contacts.each do |contact|
                  if contact[:contactId] == contactId
                     return contact
                  end
               end
               return {}

            end

            def self.findMessage(messageId)
               @aMessagesList.each do |hMessage|
                  if hMessage['id'] == messageId
                     return hMessage['message']
                  end
               end
               return nil
            end

            def self.issueError(messageId, context = nil)
               message = findMessage(messageId)
               unless message.nil?
                  message += ': CONTEXT is ' + context unless context.nil?
                  @hResponseObj[:writerMessages] << 'ERROR: ISO-19115-1 writer: ' + message
                  @hResponseObj[:writerPass] = false
               end
            end

            def self.issueWarning(messageId, tag = nil, context = nil)
               message = findMessage(messageId)
               unless message.nil?
                  message += ': CONTEXT is ' + context unless context.nil?
                  if @hResponseObj[:writerForceValid]
                     if tag.nil?
                        issueError(messageId, context)
                     else
                        @xml.tag!(tag, {'gco:nilReason' => 'missing'})
                        @hResponseObj[:writerMessages] << 'WARNING: ISO-19115-1 writer: ' + message
                     end
                  else
                     @hResponseObj[:writerMessages] << 'WARNING: ISO-19115-1 writer: ' + message
                  end
               end
            end

            def self.issueNotice(messageId, context = nil)
               message = findMessage(messageId)
               unless message.nil?
                  message += ': CONTEXT is ' + context unless context.nil?
                  @hResponseObj[:writerMessages] << 'NOTICE: ISO-19115-1 writer: ' + message
               end
            end

         end
      end
   end
end

# Writer - internal data structure to ISO 19115-2:2009

# History:
#  Stan Smith 2018-04-09 add error/warning/notice message methods
#  Stan Smith 2016-11-14 refactor for mdJson/mdTranslator 2.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2015-06-11 change all codelists to use 'class_codelist' method
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#  Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#  Stan Smith 2014-06-04 add internal object pre-scan to create extents
#  ... for geometry supplemental information
# 	Stan Smith 2013-08-10 original script

require 'builder'
require 'adiwg/mdtranslator/writers/iso19115_2/version'
require_relative 'classes/class_miMetadata'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            def self.startWriter(intObj, hResponseObj)

               # make contact available to the instance
               @contacts = intObj[:contacts]
               @hResponseObj = hResponseObj

               # load error message array
               file = File.join(File.dirname(__FILE__), 'iso19115_2_writer_messages_eng') + '.yml'
               hMessageList = YAML.load_file(file)
               @aMessagesList = hMessageList['messageList']

               # set the format of the output file based on the writer specified
               hResponseObj[:writerOutputFormat] = 'xml'
               hResponseObj[:writerVersion] = ADIWG::Mdtranslator::Writers::Iso19115_2::VERSION

               # create new XML document
               @xml = Builder::XmlMarkup.new(indent: 3)

               # start writing the ISO 19115-2 XML record
               metadataWriter = MI_Metadata.new(@xml, hResponseObj)
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
                  @hResponseObj[:writerMessages] << 'ERROR: ISO-19115-2 writer: ' + message
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
                        @hResponseObj[:writerMessages] << 'WARNING: ISO-19115-2 writer: ' + message
                     end
                  else
                     @hResponseObj[:writerMessages] << 'WARNING: ISO-19115-2 writer: ' + message
                  end
               end
            end

            def self.issueNotice(messageId, context = nil)
               message = findMessage(messageId)
               unless message.nil?
                  message += ': CONTEXT is ' + context unless context.nil?
                  @hResponseObj[:writerMessages] << 'NOTICE: ISO-19115-2 writer: ' + message
               end
            end

         end
      end
   end
end

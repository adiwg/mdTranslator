# Writer - internal data structure to ISO 19110:2003

# History:
#  Stan Smith 2018-07-02 fix bug with handling of empty or missing dictionary
#  Stan Smith 2017-05-26 allow choice of which dictionary to translate
#                    ... fix bug when no dictionary is provided in mdJson
#  Stan Smith 2017-01-20 refactor for mdJson/mdTranslator 2.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#  Stan Smith 2015-03-02 added test and return for missing data dictionary
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
# 	Stan Smith 2014-12-01 original script

require 'builder'
require_relative 'version'
require_relative 'classes/class_fcFeatureCatalogue'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19110

            def self.startWriter(intObj, hResponseObj, whichDict = 0)

               # load error message array
               file = File.join(File.dirname(__FILE__), 'iso19110_writer_messages_eng') + '.yml'
               hMessageList = YAML.load_file(file)
               @aMessagesList = hMessageList['messageList']

               # make objects available to the instance
               @intObj = intObj
               @contacts = intObj[:contacts]
               @hResponseObj = hResponseObj

               if intObj[:dataDictionaries].empty?
                  issueError(110)
                  return nil
               end
               if intObj[:dataDictionaries].length > 1
                  issueNotice(111)
               end

               dictionary = intObj[:dataDictionaries][whichDict]
               @domains = dictionary[:domains]

               # set the format of the output file based on the writer specified
               hResponseObj[:writerOutputFormat] = 'xml'
               hResponseObj[:writerVersion] = ADIWG::Mdtranslator::Writers::Iso19110::VERSION

               # create new XML document
               @xml = Builder::XmlMarkup.new(indent: 3)

               # start writing the ISO 19110 XML record
               metadataWriter = FC_FeatureCatalogue.new(@xml, hResponseObj)
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

            # find domain in domain array and return the domain hash
            def self.getDomain(domainId)
               @domains.each do |domain|
                  if domain[:domainId] == domainId
                     return domain
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
                  @hResponseObj[:writerMessages] << 'ERROR: ISO-19110 writer: ' + message
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
                        @hResponseObj[:writerMessages] << 'WARNING: ISO-19110 writer: ' + message
                     end
                  else
                     @hResponseObj[:writerMessages] << 'WARNING: ISO-19110 writer: ' + message
                  end
               end
            end

            def self.issueNotice(messageId, context = nil)
               message = findMessage(messageId)
               unless message.nil?
                  message += ': CONTEXT is ' + context unless context.nil?
                  @hResponseObj[:writerMessages] << 'NOTICE: ISO-19110 writer: ' + message
               end
            end

         end
      end
   end
end


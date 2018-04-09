# Writer - internal data structure to FGDC CSDGM FGDC-STD-001-1998

# History:
#  Stan Smith 2017-11-16 original script

require 'yaml'
require 'builder'
require_relative 'version'
require_relative 'classes/class_fgdc'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            def self.startWriter(intObj, responseObj, whichDict: 0)

               # make objects available to the instance
               @intObj = intObj
               @contacts = intObj[:contacts]
               @hResponseObj = responseObj

               # load error message array
               file = File.join(File.dirname(__FILE__), 'fgdc_writer_messages_eng') + '.yml'
               hMessageList = YAML.load_file(file)
               @aMessagesList = hMessageList['messageList']

               # set the format of the output file based on the writer
               responseObj[:writerOutputFormat] = 'xml'
               responseObj[:writerVersion] = ADIWG::Mdtranslator::Writers::Fgdc::VERSION

               # create new XML document
               @xml = Builder::XmlMarkup.new(indent: 3)

               # start writing the FGDC XML record
               metadataWriter = Fgdc.new(@xml, responseObj)
               metadata = metadataWriter.writeXML(intObj)

               return metadata

            end

            # find contact and return the contact hash
            def self.get_contact(contactId)
               @contacts.each do |contact|
                  if contact[:contactId] == contactId
                     return contact
                  end
               end
               return {}
            end

            def self.find_responsibility(aResponsibility, roleName)
               aParties = []
               aResponsibility.each do |hRParty|
                  if hRParty[:roleName] == roleName
                     hRParty[:parties].each do |hParty|
                        aParties << hParty[:contactId]
                     end
                  end
               end
               aParties = aParties.uniq
               return aParties
            end

            def self.get_intObj
               return @intObj
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
                  @hResponseObj[:writerMessages] << 'ERROR: FGDC writer: ' + message
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
                        @xml.tag!(tag, 'missing')
                        @hResponseObj[:writerMessages] << 'WARNING: FGDC writer: ' + message
                     end
                  else
                     @hResponseObj[:writerMessages] << 'WARNING: FGDC writer: ' + message
                  end
               end
            end

            def self.issueNotice(messageId, context = nil)
               message = findMessage(messageId)
               unless message.nil?
                  message += ': CONTEXT is ' + context unless context.nil?
                  @hResponseObj[:writerMessages] << 'NOTICE: FGDC writer: ' + message
               end
            end

         end
      end
   end
end


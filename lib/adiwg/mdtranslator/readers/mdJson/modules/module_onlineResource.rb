# unpack online resources
# Reader - ADIwg JSON V1 to internal data structure

# History:
#  Stan Smith 2018-06-22 refactored error and warning messaging
# 	Stan Smith 2016-10-03 original script
#  Stan Smith 2015-07-14 refactored to remove global namespace constants
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#  Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#  Stan Smith 2014-12-10 changed to return nil intOlRes if input empty
#  Stan Smith 2014-08-21 changed url to uri for json 0.6.0
#  Stan Smith 2014-08-18 removed doi section for json 0.6.0
#  Stan Smith 2014-04-23 modified for json 0.3.0
# 	Stan Smith 2013-09-25 original script

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module OnlineResource

               def self.unpack(hOnlineRes, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hOnlineRes.empty?
                     @MessagePath.issueWarning(600, responseObj, inContext)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intOLRes = intMetadataClass.newOnlineResource

                  # resource - web link (required)
                  if hOnlineRes.has_key?('uri')
                     intOLRes[:olResURI] = hOnlineRes['uri']
                  end
                  if intOLRes[:olResURI].nil? || intOLRes[:olResURI] == ''
                     @MessagePath.issueError(601, responseObj, inContext)
                  end

                  # resource - web link protocol
                  if hOnlineRes.has_key?('protocol')
                     unless hOnlineRes['protocol'] == ''
                        intOLRes[:olResProtocol] = hOnlineRes['protocol']
                     end
                  end

                  # resource - web link name
                  if hOnlineRes.has_key?('name')
                     unless hOnlineRes['name'] == ''
                        intOLRes[:olResName] = hOnlineRes['name']
                     end
                  end

                  # resource - web link description
                  if hOnlineRes.has_key?('description')
                     unless hOnlineRes['description'] == ''
                        intOLRes[:olResDesc] = hOnlineRes['description']
                     end
                  end

                  # resource - web link function
                  if hOnlineRes.has_key?('function')
                     unless hOnlineRes['function'] == ''
                        intOLRes[:olResFunction] = hOnlineRes['function']
                     end
                  end

                  return intOLRes
               end

            end

         end
      end
   end
end

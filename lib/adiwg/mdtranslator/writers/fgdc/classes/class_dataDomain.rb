# FGDC <<Class>> DataDomain
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-02-26 refactored error and warning messaging
#  Stan Smith 2018-01-24 original script

require_relative '../fgdc_writer'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class DataDomain

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(domainId, inContext = nil)
                  
                  # get the domain
                  hIntObj = ADIWG::Mdtranslator::Writers::Fgdc.get_intObj
                  hDictionary = hIntObj[:dataDictionaries][0]
                  hDomain = {}
                  hDictionary[:domains].each do |hItem|
                     if hItem[:domainId] == domainId
                        hDomain = hItem
                     end
                  end
                  if hDomain.empty?
                     @NameSpace.issueError(70, domainId)
                  end

                  outContext = domainId
                  haveDomain = false

                  # attribute 5.1.2.4.1 (edom) - enumerated domain
                  hDomain[:domainItems].each do |hItem|
                     haveDomain = true
                     @xml.tag!('attrdomv') do
                        @xml.tag!('edom') do

                           # value 5.1.2.4.1.1 (edomv) - enumerated value (required)
                           unless hItem[:itemValue].nil?
                              @xml.tag!('edomv', hItem[:itemValue])
                           end
                           if hItem[:itemValue].nil?
                              @NameSpace.issueWarning(71,'edomv', outContext)
                           end

                           # definition 5.1.2.4.1.2 (edomvd) - enumerated value definition (required)
                           unless hItem[:itemDefinition].nil?
                              @xml.tag!('edomvd', hItem[:itemDefinition])
                           end
                           if hItem[:itemDefinition].nil?
                              @NameSpace.issueWarning(72,'edomvd', outContext)
                           end

                           # source 5.1.2.4.1.3 (edomvds) - enumerated value definition source (default='author defined')
                           unless hItem[:itemReference].empty?
                              @xml.tag!('edomvds', hItem[:itemReference][:title])
                           end
                           if hItem[:itemReference].empty?
                              @NameSpace.issueWarning(76, 'edomvds', outContext)
                           end

                        end
                     end
                  end
                  return if haveDomain

                  # attribute 5.1.2.4.3 (codesetd) - codeset domain
                  unless hDomain[:domainReference].empty?
                     haveDomain = true
                     @xml.tag!('attrdomv') do
                        @xml.tag!('codesetd') do

                           # codeset 5.1.2.4.3.1 (codesetn) - codeset name (required)
                           # <- domain.name
                           unless hDomain[:domainName].nil?
                              @xml.tag!('codesetn', hDomain[:domainName])
                           end
                           if hDomain[:domainName].nil?
                              @NameSpace.issueWarning(74, 'codesetn', outContext)
                           end

                           # codeset 5.1.2.4.3.2 (codesets) - codeset source (required)
                           # <- domain.domainReference.title
                           unless hDomain[:domainReference][:title].nil?
                              @xml.tag!('codesets', hDomain[:domainReference][:title])
                           end
                           if hDomain[:domainReference][:title].nil?
                              @NameSpace.issueWarning(75,'codesets', outContext)
                           end

                        end
                     end
                  end
                  return if haveDomain

                  # attribute 5.1.2.4.4 (4dom) - unrepresented domain
                  if hDomain[:domainItems].empty?
                     if hDomain[:domainReference].empty?
                        unless hDomain[:domainDescription].nil?
                           @xml.tag!('attrdomv') do
                              @xml.tag!('udom', hDomain[:domainDescription])
                           end
                        end
                     end
                  end

               end # writeXML
            end # DataDomain

         end
      end
   end
end

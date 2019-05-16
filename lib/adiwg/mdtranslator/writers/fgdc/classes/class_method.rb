# FGDC <<Class>> Method
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-03-19 refactored error and warning messaging
#  Stan Smith 2017-12-20 original script

require_relative '../fgdc_writer'
require_relative 'class_methodKeywords'
require_relative 'class_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class Method

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(hLineage)
                  
                  # classes used
                  keywordClass = MethodKeyword.new(@xml, @hResponseObj)
                  citationClass = Citation.new(@xml, @hResponseObj)

                  hIntObj = @NameSpace.get_intObj
                  haveMethod = false
                  haveMethod = true unless hLineage[:statement].nil?
                  haveMethod = true unless hLineage[:lineageCitation].empty?
                  aKeywords = hIntObj[:metadata][:resourceInfo][:keywords]
                  aKeywords.each do |hKeyword|
                     if %w(method methodology).include?(hKeyword[:keywordType])
                        haveMethod = true
                     end
                  end

                  if haveMethod
                     @xml.tag!('method') do

                        # methodology bio (methtype) - method type (required)
                        # <- resourceLineage.statement
                        unless hLineage[:statement].nil?
                           @xml.tag!('methtype', hLineage[:statement])
                        end
                        if hLineage[:statement].nil?
                           @NameSpace.issueWarning(210, 'methtype')
                        end

                        # methodology bio (methodid) - method id [] {keywords} (required)
                        # <- resourceInfo.keywords.keywordType = 'method'
                        keywordClass.writeXML(aKeywords)

                        # methodology bio (methdesc) - method description (required)
                        # <- resourceLineage.statement
                        unless hLineage[:statement].nil?
                           @xml.tag!('methdesc', hLineage[:statement])
                        end
                        if hLineage[:statement].nil?
                           @NameSpace.issueWarning(211, 'methdesc')
                        end

                        # methodology bio (methcite) - method citation [] (required)
                        # <- resourceLineage.lineageCitation
                        hLineage[:lineageCitation].each do |hCitation|
                           unless hCitation.empty?
                              @xml.tag!('methcite') do
                                 citationClass.writeXML(hCitation, [], 'lineage method')
                              end
                           end
                        end
                        if hLineage[:lineageCitation].empty?
                           @NameSpace.issueWarning(212, nil)
                        end

                     end
                  end

                  if !haveMethod && @hResponseObj[:writerShowTags]
                     @xml.tag!('method')
                  end

               end # writeXML
            end # Method

         end
      end
   end
end

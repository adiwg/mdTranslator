# FGDC <<Class>> Method
# FGDC CSDGM writer output in XML

# History:
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
               end

               def writeXML(hLineage)

                  # classes used
                  keywordClass = MethodKeyword.new(@xml, @hResponseObj)
                  citationClass = Citation.new(@xml, @hResponseObj)

                  hIntObj = ADIWG::Mdtranslator::Writers::Fgdc.get_intObj
                  haveMethod = false
                  haveMethod = true unless hLineage[:statement].nil?
                  haveMethod = true unless hLineage[:lineageCitation].empty?
                  aKeywords = hIntObj[:metadata][:resourceInfo][:keywords]
                  aKeywords.each do |hKeyword|
                     if hKeyword[:keywordType] == 'method'
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
                           @hResponseObj[:writerPass] = false
                           @hResponseObj[:writerMessages] << 'Lineage Method is missing type and/or description'
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
                           @hResponseObj[:writerPass] = false
                           @hResponseObj[:writerMessages] << 'Lineage Method is missing type and/or description'
                        end

                        # methodology bio (methcite) - method citation [] (required)
                        # <- resourceLineage.lineageCitation
                        hLineage[:lineageCitation].each do |hCitation|
                           unless hCitation.empty?
                              @xml.tag!('methcite') do
                                 citationClass.writeXML(hCitation, [])
                              end
                           end
                        end
                        if hLineage[:lineageCitation].empty?
                           @hResponseObj[:writerPass] = false
                           @hResponseObj[:writerMessages] << 'Lineage Method is missing citation'
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

# ISO <<Class>> CI_Address
# 19115-2 writer output in XML

# History:
#   Stan Smith 2016-11-19 original script

require_relative 'class_codelist'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class Hierarchy

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(aTypes)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)

                  # metadata information - hierarchy level [] {MD_ScopeCode}
                  aTypes.each do |hResType|
                     s = hResType[:type]
                     @xml.tag!('gmd:hierarchyLevel') do
                        codelistClass.writeXML('gmd', 'iso_scope', s)
                     end
                  end
                  if aTypes.empty? && @hResponseObj[:writerShowTags]
                     @xml.tag!('gmd:hierarchyLevel')
                  end

                  # metadata information - hierarchy level Name []
                  haveName = false
                  aTypes.each do |hResType|
                     s = hResType[:name]
                     unless s.nil?
                        @xml.tag!('gmd:hierarchyLevelName') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                        haveName = true
                     end
                  end
                  if !haveName && @hResponseObj[:writerShowTags]
                     @xml.tag!('gmd:hierarchyLevelName')
                  end

               end # writeXML
            end # CI_Address class

         end
      end
   end
end

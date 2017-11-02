# ISO <<Class>> FC_DefinitionReference
# 19110 writer output in XML

# History:
# 	Stan Smith 2017-11-02 original script.

require_relative 'class_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19110

            class FC_DefinitionReference

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hReference)

                  # classes used
                  citationClass = CI_Citation.new(@xml, @hResponseObj)

                  unless hReference.empty?
                     @xml.tag!('gfc:FC_DefinitionReference') do
                        @xml.tag!('gfc:definitionSource') do
                           @xml.tag!('gfc:FC_DefinitionSource') do
                              @xml.tag!('gfc:source') do
                                 citationClass.writeXML(hReference)
                              end
                           end
                        end

                     end
                  end

               end # write XML
            end # FC_DefinitionReference

         end
      end
   end
end

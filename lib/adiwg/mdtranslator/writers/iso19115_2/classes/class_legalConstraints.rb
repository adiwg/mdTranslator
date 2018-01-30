# ISO <<Class>> MD_LegalConstraints
# 19115-2 writer output in XML

# History:
#  Stan Smith 2018-01-29 add legal constraint for distribution liability statement
#  Stan Smith 2016-12-13 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2015-06-11 change all codelists to use 'class_codelist' method
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#  Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
# 	Stan Smith 2013-11-01 original script.

require_relative 'class_codelist'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class MD_LegalConstraints

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hConstraint)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)

                  @xml.tag!('gmd:MD_LegalConstraints') do

                     # constraints - use limitation []
                     aUse = hConstraint[:useLimitation]
                     aUse.each do |useCon|
                        @xml.tag!('gmd:useLimitation') do
                           @xml.tag!('gco:CharacterString', useCon)
                        end
                     end
                     if aUse.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:useLimitation')
                     end

                     hLegalCon = hConstraint[:legalConstraint]

                     # legal constraints - access constraints
                     aAccess = hLegalCon[:accessCodes]
                     aAccess.each do |code|
                        @xml.tag!('gmd:accessConstraints') do
                           codelistClass.writeXML('gmd', 'iso_restriction', code)
                        end
                     end
                     if aAccess.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:accessConstraints')
                     end

                     # legal constraints - use constraints
                     aUse = hLegalCon[:useCodes]
                     aUse.each do |code|
                        @xml.tag!('gmd:useConstraints') do
                           codelistClass.writeXML('gmd', 'iso_restriction', code)
                        end
                     end
                     if aUse.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:useConstraints')
                     end

                     # legal constraints - other constraints
                     aOther = hLegalCon[:otherCons]
                     aOther.each do |con|
                        @xml.tag!('gmd:otherConstraints') do
                           @xml.tag!('gco:CharacterString', con)
                        end
                     end
                     if aOther.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:otherConstraints')
                     end

                  end # gmd:MD_LegalConstraints tag
               end # writeXML
            end # MD_LegalConstraints class

         end
      end
   end
end

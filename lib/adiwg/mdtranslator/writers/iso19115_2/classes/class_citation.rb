# ISO <<Class>> CI_Citation
# 19115-2 writer output in XML

# History:
#  Stan Smith 2018-04-09 add error and warning messaging
#  Stan Smith 2016-11-29 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-08-28 added alternate title
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2015-06-11 change all codelists to use 'class_codelist' method
#  Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#  Stan Smith 2014-08-18 process isbn and ISSN from identifier section per 0.6.0
#  Stan Smith 2014-08-18 modify identifier section for schema 0.6.0
#  Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#  Stan Smith 2014-05-28 modified for json schema 0.5.0
#  Stan Smith 2014-05-16 added MD_Identifier
#  Stan Smith 2014-05-16 modified for JSON schema 0.4.0
# 	Stan Smith 2013-12-30 added ISBN, ISSN
# 	Stan Smith 2013-08-26 original script

require_relative '../iso19115_2_writer'
require_relative 'class_codelist'
require_relative 'class_responsibleParty'
require_relative 'class_date'
require_relative 'class_mdIdentifier'
require_relative 'class_series'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class CI_Citation

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_2
               end

               def writeXML(hCitation, inContext = nil)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                  rPartyClass = CI_ResponsibleParty.new(@xml, @hResponseObj)
                  dateClass = CI_Date.new(@xml, @hResponseObj)
                  idClass = MD_Identifier.new(@xml, @hResponseObj)
                  seriesClass = CI_Series.new(@xml, @hResponseObj)

                  outContext = 'citation'
                  outContext = inContext + ' citation' unless inContext.nil?

                  @xml.tag!('gmd:CI_Citation') do

                     # citation - title (required)
                     s = hCitation[:title]
                     if s.nil?
                        @NameSpace.issueWarning(30, 'gmd:title', inContext)
                     else
                        @xml.tag!('gmd:title') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end

                     # citation - alternate title []
                     aTitles = hCitation[:alternateTitles]
                     aTitles.each do |title|
                        @xml.tag!('gmd:alternateTitle') do
                           @xml.tag!('gco:CharacterString', title)
                        end
                     end
                     if aTitles.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:alternateTitle')
                     end

                     # citation - date [] (required)
                     aDate = hCitation[:dates]
                     aDate.each do |hDate|
                        @xml.tag!('gmd:date') do
                           dateClass.writeXML(hDate, outContext)
                        end
                     end
                     if aDate.empty?
                        @NameSpace.issueWarning(31, 'gmd:date', outContext)
                     end

                     # citation - edition
                     s = hCitation[:edition]
                     unless s.nil?
                        @xml.tag!('gmd:edition') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:edition')
                     end

                     # citation - resource identifier []
                     # process ISBN and ISSN as MD_identifier(s)
                     # ... then also write separately in ISBN or ISSN tag
                     isbn = ''
                     issn = ''
                     aIds = hCitation[:identifiers]
                     aIds.each do |hIdentifier|
                        unless hIdentifier[:namespace].nil?
                           if hIdentifier[:namespace].downcase == 'isbn'
                              isbn = hIdentifier[:identifier]
                           elsif hIdentifier[:namespace].downcase == 'issn'
                              issn = hIdentifier[:identifier]
                           end
                        end
                        @xml.tag!('gmd:identifier') do
                           idClass.writeXML(hIdentifier, outContext)
                        end
                     end
                     if aIds.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:identifier')
                     end

                     # citation - cited responsible party [{CI_ResponsibleParty}]
                     # responsibilities are grouped by role in the internal object
                     # to output in ISO ...
                     # create a separate record for each role-contact pair
                     # check for duplicates and eliminate
                     aRoleParty = []
                     aRParties = hCitation[:responsibleParties]
                     aRParties.each do |hRParty|
                        role = hRParty[:roleName]
                        aParties = hRParty[:parties]
                        aParties.each do |hParty|
                           aRoleParty << {role: role, hParty: hParty}
                        end
                     end
                     aRoleParty.uniq!
                     aRoleParty.each do |hRoleParty|
                        @xml.tag!('gmd:citedResponsibleParty') do
                           rPartyClass.writeXML(hRoleParty[:role], hRoleParty[:hParty], outContext)
                        end
                     end
                     if aRoleParty.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:citedResponsibleParty')
                     end

                     # citation - presentation forms [{CI_PresentationFormCode}]
                     aPresForms = hCitation[:presentationForms]
                     aPresForms.each do |presForm|
                        @xml.tag!('gmd:presentationForm') do
                           codelistClass.writeXML('gmd', 'iso_presentationForm', presForm)
                        end
                     end
                     if aPresForms.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:presentationForm')
                     end

                     # citation - series {CI_Series}
                     hSeries = hCitation[:series]
                     unless hSeries.empty?
                        @xml.tag!('gmd:series') do
                           seriesClass.writeXML(hSeries)
                        end
                     end
                     if hSeries.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:series')
                     end

                     # citation - other citation details
                     aOther = hCitation[:otherDetails]
                     unless aOther.empty?
                        other = aOther[0]
                        @xml.tag!('gmd:otherCitationDetails') do
                           @xml.tag!('gco:CharacterString', other)
                        end
                     end
                     if aOther.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:otherCitationDetails')
                     end

                     # citation - ISBN
                     unless isbn == ''
                        @xml.tag!('gmd:ISBN') do
                           @xml.tag!('gco:CharacterString', isbn)
                        end
                     end
                     if isbn == '' && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:ISBN')
                     end

                     # citation - ISSN
                     unless issn == ''
                        @xml.tag!('gmd:ISSN') do
                           @xml.tag!('gco:CharacterString', issn)
                        end
                     end
                     if issn == '' && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:ISSN')
                     end

                  end # CI_Citation tag

               end # writeXML
            end # CI_Citation class

         end
      end
   end
end

# ISO <<Class>> CI_Citation
# 19110 writer output in XML

# History:
#  Stan Smith 2018-03-30 refactored error and warning messaging
# 	Stan Smith 2017-11-02 original script.

require_relative '../iso19110_writer'
require_relative 'class_codelist'
require_relative 'class_responsibleParty'
require_relative 'class_date'
require_relative 'class_mdIdentifier'
require_relative 'class_series'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19110

            class CI_Citation

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19110
               end

               def writeXML(hCitation)

                  unless hCitation.empty?

                     # classes used
                     codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                     rPartyClass = CI_ResponsibleParty.new(@xml, @hResponseObj)
                     dateClass = CI_Date.new(@xml, @hResponseObj)
                     idClass = MD_Identifier.new(@xml, @hResponseObj)
                     seriesClass = CI_Series.new(@xml, @hResponseObj)

                     @xml.tag!('gmd:CI_Citation') do

                        # citation - title (required)
                        s = hCitation[:title]
                        if s.nil?
                           @NameSpace.issueWarning(1, 'gmd:title')
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
                              dateClass.writeXML(hDate)
                           end
                        end
                        if aDate.empty?
                           @NameSpace.issueWarning(2,'gmd:date')
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
                        # do not process ISBN and ISSN as MD_identifier(s)
                        # ... these are written separately in ISO 19115-x
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
                           if issn == '' && isbn == ''
                              @xml.tag!('gmd:identifier') do
                                 idClass.writeXML(hIdentifier)
                              end
                           end
                        end
                        if aIds.empty? && @hResponseObj[:writerShowTags]
                           @xml.tag!('gmd:identifier')
                        end

                        # citation - cited responsible party [{CI_ResponsibleParty}]
                        # contacts are grouped by role in the internal object
                        # output a separate <gmd:contact> for each role:contact pairing
                        aRParties = hCitation[:responsibleParties]
                        aRParties.each do |hRParty|
                           role = hRParty[:roleName]
                           aParties = hRParty[:parties]
                           aParties.each do |hParty|
                              @xml.tag!('gmd:citedResponsibleParty') do
                                 rPartyClass.writeXML(role, hParty)
                              end
                           end
                        end
                        if aRParties.empty? && @hResponseObj[:writerShowTags]
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

                     end
                  end

               end # write XML
            end # CI_Citation

         end
      end
   end
end

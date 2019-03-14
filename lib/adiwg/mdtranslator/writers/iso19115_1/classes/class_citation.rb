# ISO <<Class>> CI_Citation
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-03-13 original script

require_relative '../iso19115_1_writer'
require_relative 'class_codelist'
require_relative 'class_responsibleParty'
require_relative 'class_date'
require_relative 'class_mdIdentifier'
require_relative 'class_series'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class CI_Citation

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_1
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

                  @xml.tag!('cit:CI_Citation') do

                     # citation - title (required)
                     s = hCitation[:title]
                     if s.nil?
                        @NameSpace.issueWarning(30, 'cit:title', inContext)
                     else
                        @xml.tag!('cit:title') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end

                     # citation - alternate title []
                     aTitles = hCitation[:alternateTitles]
                     aTitles.each do |title|
                        @xml.tag!('cit:alternateTitle') do
                           @xml.tag!('gco:CharacterString', title)
                        end
                     end
                     if aTitles.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('cit:alternateTitle')
                     end

                     # citation - date [] {CI_Date}
                     aDate = hCitation[:dates]
                     aDate.each do |hDate|
                        @xml.tag!('cit:date') do
                           dateClass.writeXML(hDate, outContext)
                        end
                     end
                     if aDate.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('cit:date')
                     end

                     # citation - edition
                     s = hCitation[:edition]
                     unless s.nil?
                        @xml.tag!('cit:edition') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('cit:edition')
                     end

                     # citation - edition date {DateTime}

                     # citation - resource identifier [] {MD_Identifier}
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
                        @xml.tag!('cit:identifier') do
                           idClass.writeXML(hIdentifier, outContext)
                        end
                     end
                     if aIds.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('cit:identifier')
                     end

                     # citation - cited responsible party [] {CI_Responsibility}
                     # contacts are grouped by role in the internal object
                     # output a separate <cit:contact> for each role:contact pairing
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
                        @xml.tag!('cit:citedResponsibleParty') do
                           rPartyClass.writeXML(hRoleParty[:role], hRoleParty[:hParty], outContext)
                        end
                     end
                     if aRoleParty.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('cit:citedResponsibleParty')
                     end

                     # citation - presentation forms [] {CI_PresentationFormCode}
                     aPresForms = hCitation[:presentationForms]
                     aPresForms.each do |presForm|
                        @xml.tag!('cit:presentationForm') do
                           codelistClass.writeXML('gmd', 'iso_presentationForm', presForm)
                        end
                     end
                     if aPresForms.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('cit:presentationForm')
                     end

                     # citation - series {CI_Series}
                     hSeries = hCitation[:series]
                     unless hSeries.empty?
                        @xml.tag!('cit:series') do
                           seriesClass.writeXML(hSeries)
                        end
                     end
                     if hSeries.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('cit:series')
                     end

                     # citation - other citation details []
                     aOther = hCitation[:otherDetails]
                     unless aOther.empty?
                        other = aOther[0]
                        @xml.tag!('cit:otherCitationDetails') do
                           @xml.tag!('gco:CharacterString', other)
                        end
                     end
                     if aOther.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('cit:otherCitationDetails')
                     end

                     # citation - ISBN
                     unless isbn == ''
                        @xml.tag!('cit:ISBN') do
                           @xml.tag!('gco:CharacterString', isbn)
                        end
                     end
                     if isbn == '' && @hResponseObj[:writerShowTags]
                        @xml.tag!('cit:ISBN')
                     end

                     # citation - ISSN
                     unless issn == ''
                        @xml.tag!('cit:ISSN') do
                           @xml.tag!('gco:CharacterString', issn)
                        end
                     end
                     if issn == '' && @hResponseObj[:writerShowTags]
                        @xml.tag!('cit:ISSN')
                     end

                     # citation - online resources [] {CI_OnlineResource}

                     # citation - graphic [] {MD_BrowseGraphic}

                  end # CI_Citation tag

               end # writeXML
            end # CI_Citation class

         end
      end
   end
end

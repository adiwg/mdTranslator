# FGDC <<Class>> Identification Information
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-03-19 refactored error and warning messaging
#  Stan Smith 2017-11-17 original script

require_relative '../fgdc_writer'
require_relative 'class_citation'
require_relative 'class_description'
require_relative 'class_timePeriod'
require_relative 'class_status'
require_relative 'class_spatialDomain'
require_relative 'class_keyword'
require_relative 'class_contact'
require_relative 'class_taxonomy'
require_relative 'class_constraint'
require_relative 'class_security'
require_relative 'class_browse'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class Identification

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(intObj)

                  # classes used
                  citationClass = Citation.new(@xml, @hResponseObj)
                  descriptionClass = Description.new(@xml, @hResponseObj)
                  timePeriodClass = TimePeriod.new(@xml, @hResponseObj)
                  statusClass = Status.new(@xml, @hResponseObj)
                  spDomainClass = SpatialDomain.new(@xml, @hResponseObj)
                  keywordClass = Keyword.new(@xml, @hResponseObj)
                  contactClass = Contact.new(@xml, @hResponseObj)
                  taxonomyClass = Taxonomy.new(@xml, @hResponseObj)
                  constraintClass = Constraint.new(@xml, @hResponseObj)
                  securityClass = Security.new(@xml, @hResponseObj)
                  browseClass = Browse.new(@xml, @hResponseObj)

                  hResourceInfo = intObj[:metadata][:resourceInfo]
                  aAssocResource = intObj[:metadata][:associatedResources]

                  outContext = 'identification section'

                  # identification information 1.1 (citation) - citation (required)
                  # <- hResourceInfo[:citation]
                  hCitation = hResourceInfo[:citation]
                  unless hCitation.empty?
                     @xml.tag!('citation') do
                        citationClass.writeXML(hCitation, aAssocResource, 'main resource citation')
                     end
                  end
                  if hCitation.empty?
                     @NameSpace.issueWarning(180, nil, outContext)
                  end

                  # identification information 1.2 (descript) - description (required)
                  # <- hResourceInfo[:abstract,:purpose,:supplementalInfo] (required)
                  haveDescription = false
                  haveDescription = true unless hResourceInfo[:abstract].nil?
                  haveDescription = true unless hResourceInfo[:purpose].nil?
                  haveDescription = true unless hResourceInfo[:supplementalInfo].nil?
                  if haveDescription
                     @xml.tag!('descript') do
                        descriptionClass.writeXML(hResourceInfo)
                     end
                  end
                  unless haveDescription
                     @NameSpace.issueWarning(181, nil, outContext)
                  end

                  # identification information 1.3 (timeperd) - time period of content (required)
                  # <- hResourceInfo[:timePeriod]
                  unless hResourceInfo[:timePeriod].empty?
                     @xml.tag!('timeperd') do
                        timePeriodClass.writeXML(hResourceInfo[:timePeriod], 'current')
                     end
                  end
                  if hResourceInfo[:timePeriod].empty?
                     @NameSpace.issueWarning(182, nil, outContext)
                  end

                  # identification information 1.4 (status) - status
                  statusClass.writeXML(hResourceInfo)

                  # identification information 1.5 (spdom) - spatial domain
                  # not required under biological extension rules
                  unless hResourceInfo[:extents].empty?
                     spDomainClass.writeXML(hResourceInfo[:extents])
                  end

                  # identification information 1.6 (keywords) - keywords [] (required)
                  unless hResourceInfo[:keywords].empty?
                     @xml.tag!('keywords') do
                        keywordClass.writeXML(hResourceInfo[:keywords])
                     end
                  end
                  if hResourceInfo[:keywords].empty?
                     @NameSpace.issueWarning(183, nil, outContext)
                  end

                  # identification information bio (taxonomy) - taxonomy
                  unless hResourceInfo[:taxonomy].empty?
                     @xml.tag!('taxonomy') do
                        taxonomyClass.writeXML(hResourceInfo[:taxonomy][0], hResourceInfo[:keywords])
                     end
                  end
                  if hResourceInfo[:taxonomy].length > 1
                     @NameSpace.issueNotice(186)
                     @NameSpace.issueNotice(187)
                  end
                  if hResourceInfo[:taxonomy].empty? && @hResponseObj[:writerShowTags]
                     @xml.tag!('taxonomy')
                  end

                  # identification information 1.7 (accconst) - access constraint (required)
                  # identification information 1.8 (useconst) - use constraint (required)
                  unless hResourceInfo[:constraints].empty?
                     constraintClass.writeXML(hResourceInfo[:constraints])
                  end
                  if hResourceInfo[:constraints].empty?
                     @NameSpace.issueWarning(184,'accconst', outContext)
                     @NameSpace.issueWarning(185,'useconst', outContext)
                  end

                  # identification information 1.9 (ptcontac) - point of contact
                  unless hResourceInfo[:pointOfContacts].empty?
                     aRParties = hResourceInfo[:pointOfContacts]
                     aParties = ADIWG::Mdtranslator::Writers::Fgdc.find_responsibility(aRParties, 'pointOfContact')
                     unless aParties.empty?
                        hContact = ADIWG::Mdtranslator::Writers::Fgdc.get_contact(aParties[0])
                        unless hContact.empty?
                           @xml.tag!('ptcontac') do
                              contactClass.writeXML(hContact)
                           end
                        end
                     end
                  end
                  if hResourceInfo[:pointOfContacts].empty? && @hResponseObj[:writerShowTags]
                     @xml.tag!('ptcontac')
                  end

                  # identification information 1.10 (browse) - browse graphic []
                  hResourceInfo[:graphicOverviews].each do |hGraphic|
                     @xml.tag!('browse') do
                        browseClass.writeXML(hGraphic)
                     end
                  end
                  if hResourceInfo[:graphicOverviews].empty? && @hResponseObj[:writerShowTags]
                     @xml.tag!('browse')
                  end

                  # identification information 1.11 (datacred) - dataset credit
                  # <- concatenate  resourceInfo.credits[]
                  unless hResourceInfo[:credits].empty?
                     dataCred = ''
                     hResourceInfo[:credits].each do |credit|
                        dataCred += credit + '; '
                     end
                     dataCred.chomp!('; ')
                     @xml.tag!('datacred', dataCred)
                  end
                  if hResourceInfo[:credits].empty? && @hResponseObj[:writerShowTags]
                     @xml.tag!('datacred')
                  end

                  # identification information 1.12 (secinfo) - security information
                  unless hResourceInfo[:constraints].empty?
                     securityClass.writeXML(hResourceInfo[:constraints])
                  end
                  if hResourceInfo[:constraints].empty? && @hResponseObj[:writerShowTags]
                     @xml.tag!('secinfo')
                  end

                  # identification information 1.13 (native) - native dataset environment
                  unless hResourceInfo[:environmentDescription].nil?
                     @xml.tag!('native', hResourceInfo[:environmentDescription])
                  end
                  if hResourceInfo[:environmentDescription].nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('native')
                  end

                  # identification information 1.14 (crossref) - cross reference []
                  # <- associatedResources[:associationType] = 'crossReference'
                  haveXRef = false
                  aAssocResource.each do |hAssocRes|
                     if hAssocRes[:associationType] == 'crossReference'
                        haveXRef = true
                        @xml.tag!('crossref') do
                           citationClass.writeXML(hAssocRes[:resourceCitation], [], 'identification section cross reference')
                        end
                     end
                  end
                  if !haveXRef && @hResponseObj[:writerShowTags]
                     @xml.tag!('crossref')
                  end

                  # identification information bio (tool) - analytical tool [] (not supported)

               end # writeXML
            end # Identification

         end
      end
   end
end

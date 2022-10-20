# FGDC <<Class>> Distribution
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-03-16 refactored error and warning messaging
#  Stan Smith 2018-01-28 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative '../fgdc_writer'
require_relative 'class_contact'
require_relative 'class_orderProcess'
require_relative 'class_timePeriod'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class Distribution

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(hDistribution)

                  # classes used
                  intMetadataClass = InternalMetadata.new
                  contactClass = Contact.new(@xml, @hResponseObj)
                  orderClass = OrderProcess.new(@xml, @hResponseObj)
                  timePeriodClass = TimePeriod.new(@xml, @hResponseObj)

                  # in FGDC each distribution can have only one distributor
                  # the passed in mdJson hDistribution may contain multiple distributors
                  # therefore, create a separate FGDC distribution record for each distributor
                  # and repeat the distribution information

                  if hDistribution[:distributor].empty?
                     @xml.tag!('distinfo') do
                        # distribution 6.2 (resdesc) - resource description
                        # <- distribution.description
                        unless hDistribution[:description].nil?
                           @xml.tag!('resdesc', hDistribution[:description])
                        end
                        if hDistribution[:description].nil? && @hResponseObj[:writerShowTags]
                           @xml.tag!('resdesc')
                        end

                        # distribution 6.3 (distliab) - liability (required)
                        # <- distribution.liabilityStatement
                        unless hDistribution[:liabilityStatement].nil?
                           @xml.tag!('distliab', hDistribution[:liabilityStatement])
                        end
                        if hDistribution[:liabilityStatement].nil?
                           @NameSpace.issueWarning(111,'distliab')
                        end
                     end
                  end

                  hDistribution[:distributor].each do |hDistributor|

                     outContext = nil

                     @xml.tag!('distinfo') do

                        # distribution 6.1 (distrib) - distributor {contact} (required)
                        # <- distribution.distributor.contact{}.responsibility.roleName = 'distributor'
                        haveContact = false
                        unless hDistributor.empty?
                           unless hDistributor[:contact].empty?
                              contactId = hDistributor[:contact][:parties][0][:contactId]
                              hContact = ADIWG::Mdtranslator::Writers::Fgdc.get_contact(contactId)
                              unless hContact.empty?
                                 @xml.tag!('distrib') do
                                    contactClass.writeXML(hContact)
                                 end
                                 outContext = 'distributor ' + hContact[:name]
                                 haveContact = true
                              end
                           end
                        end
                        unless haveContact
                           @NameSpace.issueWarning(110,nil)
                        end

                        # distribution 6.2 (resdesc) - resource description
                        # <- distribution.description
                        unless hDistribution[:description].nil?
                           @xml.tag!('resdesc', hDistribution[:description])
                        end
                        if hDistribution[:description].nil? && @hResponseObj[:writerShowTags]
                           @xml.tag!('resdesc')
                        end

                        # distribution 6.3 (distliab) - liability (required)
                        # <- distribution.liabilityStatement
                        unless hDistribution[:liabilityStatement].nil?
                           @xml.tag!('distliab', hDistribution[:liabilityStatement])
                        end
                        if hDistribution[:liabilityStatement].nil?
                           @NameSpace.issueWarning(111,'distliab')
                        end

                        # distribution 6.4 (stdorder) - standard order [] {standardOrder}
                        # <- distribution.distributor.orderProcess
                        # in FGDC transferOptions are children of orderProcess
                        # pass the entire distribution object
                        haveOrder = false
                        unless hDistributor.empty?
                           unless hDistributor[:orderProcess].empty?
                              @xml.tag!('stdorder') do
                                 orderClass.writeXML(hDistributor, outContext)
                              end
                              haveOrder = true
                           end
                        end
                        if !haveOrder && @hResponseObj[:writerShowTags]
                           @xml.tag!('custom')
                        end

                        # distribution 6.5 (custom) - custom order process
                        # <- where transferOptions[] is empty
                        # <- distribution.distributor.orderProcess[0].orderingInstructions
                        haveCustom = false
                        unless hDistributor.empty?
                           if hDistributor[:transferOptions].empty?
                              unless hDistributor[:orderProcess].empty?
                                 unless hDistributor[:orderProcess][0].empty?
                                    unless hDistributor[:orderProcess][0][:orderingInstructions].nil?
                                       @xml.tag!('custom', hDistributor[:orderProcess][0][:orderingInstructions])
                                    end
                                 end
                                 haveCustom = true
                              end
                           end
                        end
                        if !haveCustom && @hResponseObj[:writerShowTags]
                           @xml.tag!('custom')
                        end

                        # distribution 6.6 (techpreq) - technical prerequisites
                        # -> distribution.distributor[all].transferOption[all].distributionFormat[all].technicalPrerequisite
                        # collect these and string unique together
                        techPre = ''
                        aTechPre = []
                        unless hDistributor.empty?
                           hDistributor[:transferOptions].each do |hTransOpt|
                              hTransOpt[:distributionFormats].each do |hFormat|
                                 unless hFormat[:technicalPrerequisite].nil?
                                    aTechPre << hFormat[:technicalPrerequisite]
                                 end
                              end
                           end
                        end
                        aTechPre = aTechPre.uniq
                        aTechPre.each do |prereq|
                           techPre += prereq + '; '
                        end
                        techPre.chomp!('; ')
                        unless techPre == ''
                           @xml.tag!('techpreq', techPre)
                        end
                        if techPre == '' && @hResponseObj[:writerShowTags]
                           @xml.tag!('techpreq')
                        end

                        # distribution 6.7 (availabl) - available timePeriod  {timePeriod}
                        # <- distribution.distributor[0].orderProcess[0].plannedAvailability
                        # for FGDC only the first orderProcess can be accepted
                        haveTime = false
                        unless hDistributor.empty?
                           unless hDistributor[:orderProcess].empty?
                              unless hDistributor[:orderProcess][0][:plannedAvailability].empty?
                                 hAvailDate = hDistributor[:orderProcess][0][:plannedAvailability]
                                 hTimePeriod = intMetadataClass.newTimePeriod
                                 hTimePeriod[:startDateTime] = hAvailDate
                                 @xml.tag!('availabl') do
                                    timePeriodClass.writeXML(hTimePeriod, nil)
                                 end
                                 haveTime = true
                              end
                           end
                        end
                        if !haveTime && @hResponseObj[:writerShowTags]
                           @xml.tag!('availabl')
                        end
                     end

                  end

               end # writeXML
            end # Distribution

         end
      end
   end
end

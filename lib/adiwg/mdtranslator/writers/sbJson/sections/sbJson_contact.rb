# sbJson 1.0 writer

# History:
#  Stan Smith 2017-05-25 refactored for mdJson/mdTranslator 2.0
#  Josh Bradley original script

require 'jbuilder'
require_relative 'sbJson_codelists'
require_relative 'sbJson_hours'

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            module Contact

               def self.build(hParty)

                  Jbuilder.new do |json|

                     role = hParty[:role]
                     hContact = ADIWG::Mdtranslator::Writers::SbJson.get_contact_by_index(hParty[:index])

                     unless hContact.empty?

                        type = hContact[:isOrganization] ? 'organization' : 'person'

                        orgName = nil
                        unless hContact[:memberOfOrgs].empty?
                           orgContact = ADIWG::Mdtranslator::Writers::SbJson.get_contact_by_id(hContact[:memberOfOrgs][0])
                           orgName = orgContact[:name]
                        end
                        logoUrl = nil
                        unless hContact[:logos].empty?
                           logo0 = hContact[:logos][0]
                           unless logo0[:graphicURI].empty?
                              logoUrl = logo0[:graphicURI][0][:olResURI]
                           end
                        end

                        json.name hContact[:name]
                        json.contactType type
                        json.personalTitle hContact[:positionName] if type == 'person'
                        json.type Codelists.role_iso_to_sbJson(role)
                        json.email hContact[:eMailList][0] unless hContact[:eMailList].empty?
                        json.hours Hours.build(hContact[:hoursOfService]) unless hContact[:hoursOfService].empty?
                        json.instructions hContact[:contactInstructions]
                        json.tty hContact[:phones].collect {|ph| ph[:phoneNumber] if
                           ph[:phoneServiceTypes].include?('tty')}.reject(&:nil?).first
                        json.organization {json.displayText orgName} unless orgName.nil?
                        json.logoUrl logoUrl unless logoUrl.nil?

                        if !hContact[:addresses].empty? || !hContact[:phones].empty?
                           json.primaryLocation do
                              unless hContact[:phones].empty?
                                 json.officePhone hContact[:phones].collect {|ph| ph[:phoneNumber] if
                                    ph[:phoneServiceTypes].include?('voice')}.reject(&:nil?).first
                                 json.faxPhone hContact[:phones].collect {|ph| ph[:phoneNumber] if
                                    ph[:phoneServiceTypes].include?('fax')}.reject(&:nil?).first
                              end
                              unless hContact[:addresses].empty?
                                 aAddress = hContact[:addresses]
                                 json.description aAddress[0][:description]
                                 aAddress.each do |hAddress|
                                    if hAddress[:addressTypes].include?('physical')
                                       json.streetAddress do
                                          unless hAddress[:deliveryPoints].empty?
                                             json.line1 hAddress[:deliveryPoints][0]
                                             json.line2 hAddress[:deliveryPoints][1]
                                          end
                                          json.city hAddress[:city]
                                          json.state hAddress[:adminArea]
                                          json.zip hAddress[:postalCode]
                                          json.country hAddress[:country]
                                       end
                                    end
                                    if hAddress[:addressTypes].include?('mailing')
                                       json.mailAddress do
                                          unless hAddress[:deliveryPoints].empty?
                                             json.line1 hAddress[:deliveryPoints][0]
                                             json.line2 hAddress[:deliveryPoints][1]
                                          end
                                          json.city hAddress[:city]
                                          json.state hAddress[:adminArea]
                                          json.zip hAddress[:postalCode]
                                          json.country hAddress[:country]
                                       end
                                    end
                                 end
                              end
                           end
                        end
                     end
                  end

               end # build
            end # Module Contacts

         end
      end
   end
end

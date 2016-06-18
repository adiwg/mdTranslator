require 'jbuilder'

module ADIWG
  module Mdtranslator
    module Writers
      module SbJson
        module Contact
          def self.build(intObj)
            Jbuilder.new do |json|
              if intObj[:internal]
                json.nil!
              else
                type = intObj[:indName].nil? ? 'organization' : 'person'
                json.name intObj[:indName] || intObj[:orgName]
                json.contactType type
                json.email intObj[:address][:eMailList][0] unless intObj[:address].empty?
                json.organization type == 'person' ? {:displayText => intObj[:orgName]} : nil
                json.primaryLocation do
                  json.officePhone intObj[:phones].collect { |ph|
                    ph[:phoneNumber] if ph[:phoneServiceType] == 'voice'
                  }.reject(&:nil?).first
                  json.faxPhone intObj[:phones].collect { |ph|
                    ph[:phoneNumber] if ph[:phoneServiceType] == 'fax'
                  }.reject(&:nil?).first
                  json.streetAddress do
                    add = intObj[:address]
                    unless [:deliveryPoints].empty?
                      json.line1 add[:deliveryPoints][0]
                      json.line2 add[:deliveryPoints][1]
                    end
                    json.city add[:city]
                    json.state add[:adminArea]
                    json.zip add[:postalCode]
                    json.country add[:country]
                  end unless intObj[:address].empty?
                end
              end
            end
          end
        end
      end
    end
  end
end

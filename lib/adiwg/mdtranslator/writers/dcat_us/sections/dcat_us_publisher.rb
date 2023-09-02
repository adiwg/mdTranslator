module ADIWG
  module Mdtranslator
    module Writers
      module Dcat_us
        module Publisher
          def self.build(intObj)
            contacts = intObj.dig(:contacts)
            metadata = intObj.dig(:metadata)
            responsible_parties = metadata&.dig(:resourceInfo, :citation, :responsibleParties)
            resource_distributions = metadata&.dig(:distributorInfo)
            
            publisher = find_publisher(responsible_parties) || find_distributions_publisher(intObj)
            
            return if publisher.nil?
            
            name, org_name = extract_names(publisher, contacts)
            
            return if name.nil?
            
            build_json(name, org_name)
          end
          
          private
          
          def self.find_publisher(responsible_parties)
            responsible_parties&.detect do |party|
              party[:roleName] == 'publisher' && party.dig(:parties)&.first&.dig(:contactType) == 'organization'
            end
          end

          def self.find_distributions_publisher(intObj)
            distributor_info = intObj.dig(:metadata, :distributorInfo) || []
            distributor_info.each do |distribution|
              distributors = distribution[:distributor] || []
              distributors.each do |dist|
                contact_type = dist.dig(:contact, :parties, 0, :contactType)
                return dist[:contact] if contact_type == 'organization'
              end
            end
            nil
          end            
          
          def self.extract_names(publisher, contacts)
            contact_id = publisher.dig(:parties)&.first&.dig(:contactId) || publisher[:contactId]
            related_contact = contacts&.detect { |contact| contact[:contactId] == contact_id }
            org_name = nil
            if related_contact
              member_of_org_ids = related_contact[:memberOfOrgs]
              member_of_orgs = contacts.select { |contact| member_of_org_ids&.include?(contact[:contactId]) && contact[:isOrganization] }
              org_name = member_of_orgs.first&.dig(:name)
            end
            name = publisher.dig(:parties)&.first&.dig(:contactName) || publisher[:contactName]
            [name, org_name]
          end
          
          def self.build_json(name, org_name)
            Jbuilder.new do |json|
              json.set!('@type', 'org:Organization')
              json.set!('name', name)
              
              if org_name
                json.subOrganizationOf do |json_sub|
                  json_sub.set!('@type', 'org:Organization')
                  json_sub.set!('name', org_name)
                end
              end
            end
          end
          

                     
          
        end
      end
    end
  end
end

# sbJson 1.0 writer

# History:
#  Stan Smith 2017-05-26 original script

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            module Codelists

               def self.role_iso_to_sbJson(role)

                  case role
                     when 'resourceProvider'
                        sbRole = 'Resource Provider'

                     when 'custodian'
                        sbRole = 'Custodian'

                     when 'owner', 'rightsHolder'
                        sbRole = 'Data Owner'

                     when 'use'
                        sbRole = 'User'

                     when 'distributor'
                        sbRole = 'Distributor'

                     when 'originator'
                        sbRole = 'Originator'

                     when 'pointOfContact'
                        sbRole = 'Point of Contact'

                     when 'principalInvestigator'
                        sbRole = 'Principal Investigator'

                     when 'processor'
                        sbRole = 'Processor'

                     when 'author', 'coAuthor'
                        sbRole = 'Author'

                     when 'collaborator', 'contributor'
                        sbRole = 'Cooperator/Partner'

                     when 'editor'
                        sbRole = 'Editor'

                     when 'coPrincipalInvestigator'
                        'Co-Investigator'

                     when 'publisher', 'sponsor', 'mediator', 'funder', 'stakeholder', 'administrator',
                        'client', 'logistics'
                        sbRole = role

                     else
                        sbRole = role

                  end

                  return sbRole

               end

            end

         end
      end
   end
end

# codelist methods
# for ADIwg readers and writers

# History:
# 	Stan Smith 2019-03-22 original script

require 'adiwg-mdcodes'

module CodelistFun

   def self.validateItem(codeList, codeName)

      # get requested codelist from the adiwg-mdcodes gem
      mdCodelist = ADIWG::Mdcodes.getCodelistDetail(codeList)

      aCodes = mdCodelist['codelist']

      # search the codelist for a matching codeName
      aCodes.each do |hCode|
         return true if hCode['codeName'] == codeName
      end
      return false

   end

end

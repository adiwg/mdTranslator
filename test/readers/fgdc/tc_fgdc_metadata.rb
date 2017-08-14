# MdTranslator - minitest of
# readers / fgdc / module_metadata

# History:
#   Stan Smith 2017-09-14 original script

require_relative 'fgdc_test_parent'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'

class TestReaderFgdcMetadata < TestReaderFGDCParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::Fgdc

   # read the FGDC file
   @@xDoc = TestReaderFGDCParent.getXML('blackBrant.xml')

   def test_metadata_complete

      xMetadata = @@NameSpace.unpack(@@xDoc, @@hResponseObj)
      puts '--------------------'

      assert 1==1

   end

end

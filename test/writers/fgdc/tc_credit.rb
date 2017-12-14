# MdTranslator - minitest of
# writers / fgdc / class_identifier

# History:
#  Stan Smith 2017-12-14 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcCredit < TestReaderFgdcParent

   # instance classes needed in script
   TDClass = FgdcWriterTD.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:metadata][:resourceInfo][:credit] = []
   mdHash[:metadata][:resourceInfo][:credit] << 'first credit'
   mdHash[:metadata][:resourceInfo][:credit] << 'second credit'

   @@mdHash = mdHash

   def test_dataCredits_complete

      hReturn = TestReaderFgdcParent.get_complete(@@mdHash, 'credit', './metadata/idinfo/datacred')
      assert_equal hReturn[0], hReturn[1]

   end

end

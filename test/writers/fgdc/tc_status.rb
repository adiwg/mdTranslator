# MdTranslator - minitest of
# writers / fgdc / class_status

# History:
#  Stan Smith 2017-11-25 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcStatus < TestWriterFGDCParent

   # instance classes needed in script
   TDClass = FgdcWriterTD.new

   # build mdJson test file in hash
   mdHash = TDClass.base
   @@mdHash = mdHash

   def test_status_complete

      hReturn = TestWriterFGDCParent.get_complete(@@mdHash, 'status', './metadata/idinfo/status')
      assert_equal hReturn[0], hReturn[1]
      hReturn[2]

   end

   def test_status_maintenance

      # maintenance frequency empty
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:resourceMaintenance] = []

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: maintenance frequency is missing: CONTEXT is status section'

      # maintenance frequency missing
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo].delete(:resourceMaintenance)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: maintenance frequency is missing: CONTEXT is status section'

   end

end

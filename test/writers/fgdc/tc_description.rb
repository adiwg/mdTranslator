# MdTranslator - minitest of
# writers / fgdc / class_description

# History:
#  Stan Smith 2017-11-22 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcDescription < TestWriterFGDCParent

   # instance classes needed in script
   TDClass = FgdcWriterTD.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hResourceInfo = mdHash[:metadata][:resourceInfo]
   hResourceInfo[:abstract] = 'abstract'
   hResourceInfo[:purpose] = 'purpose'
   hResourceInfo[:supplementalInfo] = 'supplemental information'

   @@mdHash = mdHash

   def test_description_complete

      hReturn = TestWriterFGDCParent.get_complete(@@mdHash, 'description', './metadata/idinfo/descript')
      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

   def test_description_purpose

      # purpose empty
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:purpose] = ''

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: description purpose is missing: CONTEXT is identification section'

      # purpose missing
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo].delete(:purpose)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: description purpose is missing: CONTEXT is identification section'

   end

end

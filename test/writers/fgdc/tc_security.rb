# MdTranslator - minitest of
# writers / fgdc / class_identifier

# History:
#  Stan Smith 2017-12-14 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcSecurity < TestReaderFgdcParent

   # instance classes needed in script
   TDClass = FgdcWriterTD.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hConstraint = TDClass.build_securityConstraint('classification', 'security system name', 'handling instructions')
   mdHash[:metadata][:resourceInfo][:constraint] << hConstraint

   @@mdHash = mdHash

   def test_securityConstraint_complete

      hReturn = TestReaderFgdcParent.get_complete(@@mdHash, 'security', './metadata/idinfo/secinfo')
      assert_equal hReturn[0], hReturn[1]

   end

   def test_missing_security_className

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:constraint][1][:security].delete(:classificationSystem)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute hResponseObj[:writerPass]
      assert_includes hResponseObj[:writerMessages], 'Security is missing classification system'

   end

   def test_missing_security_handling

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:constraint][1][:security].delete(:handlingDescription)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute hResponseObj[:writerPass]
      assert_includes hResponseObj[:writerMessages], 'Security is missing handling instructions'

   end

end

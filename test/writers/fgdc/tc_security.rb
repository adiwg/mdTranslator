# MdTranslator - minitest of
# writers / fgdc / class_identifier

# History:
#  Stan Smith 2017-12-14 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcSecurity < TestWriterFGDCParent

   # instance classes needed in script
   TDClass = FgdcWriterTD.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hConstraint = TDClass.build_securityConstraint('classification', 'security system name', 'handling instructions')
   mdHash[:metadata][:resourceInfo][:constraint] << hConstraint

   @@mdHash = mdHash

   def test_securityConstraint_complete

      hReturn = TestWriterFGDCParent.get_complete(@@mdHash, 'security', './metadata/idinfo/secinfo')
      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

   def test_securityConstrain_security

      # missing resource security
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:constraint] = []

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 2, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: access constraint is missing: CONTEXT is identification section'
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: use constraint is missing: CONTEXT is identification section'

      # missing resource security
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:constraint].delete_at(1)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_empty  hResponseObj[:writerMessages]

      # missing resource security elements
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:constraint][1][:security][:classificationSystem] = ''
      hIn[:metadata][:resourceInfo][:constraint][1][:security][:handlingDescription] = ''

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 2, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: security classification system is missing: CONTEXT is identification information section'
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: security handling instructions are missing: CONTEXT is identification information section'

   end

end

# MdTranslator - minitest of
# writers / fgdc / class_constraint

# History:
#  Stan Smith 2017-12-14 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcConstraint < TestWriterFGDCParent

   # instance classes needed in script
   TDClass = FgdcWriterTD.new

   # build mdJson test file in hash
   # constraint is in base
   mdHash = TDClass.base
   @@mdHash = mdHash

   def test_accessConstraint_complete

      hReturn = TestWriterFGDCParent.get_complete(@@mdHash, 'constraint', './metadata/idinfo/accconst')
      assert_equal hReturn[0], hReturn[1]

   end

   def test_useConstraint_complete

      hReturn = TestWriterFGDCParent.get_complete(@@mdHash, 'constraint', './metadata/idinfo/useconst')
      assert_equal hReturn[0], hReturn[1]

   end

   def test_missing_constraints

      # empty
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:constraint] = []

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute hResponseObj[:writerPass]
      assert_includes hResponseObj[:writerMessages], 'Identification section is missing access and use constraints'

      # missing
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo].delete(:constraint)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute hResponseObj[:writerPass]
      assert_includes hResponseObj[:writerMessages], 'Identification section is missing access and use constraints'

   end

   def test_missing_accessConstraint

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:constraint][0][:legal][:accessConstraint] = []

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute hResponseObj[:writerPass]
      assert_includes hResponseObj[:writerMessages], 'Identification section is missing access constraint'

   end

   def test_missing_useConstraint

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:constraint][0][:legal][:useConstraint] = []

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute hResponseObj[:writerPass]
      assert_includes hResponseObj[:writerMessages], 'Identification section is missing use constraint'

   end

end

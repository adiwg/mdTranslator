# MdTranslator - minitest of
# writers / fgdc / class_identifier

# History:
#  Stan Smith 2017-12-14 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcIdentifier < TestWriterFGDCParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:metadata][:resourceInfo][:credit] = []
   mdHash[:metadata][:resourceInfo][:credit] << 'first credit'
   mdHash[:metadata][:resourceInfo][:credit] << 'second credit'

   mdHash[:metadata][:resourceInfo][:environmentDescription] = 'environment description'

   mdHash[:metadata][:associatedResource] = []
   mdHash[:metadata][:associatedResource] << TDClass.build_associatedResource('crossReference', 'cross reference one')
   mdHash[:metadata][:associatedResource] << TDClass.build_associatedResource('other')
   mdHash[:metadata][:associatedResource] << TDClass.build_associatedResource('crossReference', 'cross reference two')

   @@mdHash = mdHash

   def test_complete_identification

      hReturn = TestWriterFGDCParent.get_complete(@@mdHash, 'identification', './metadata/idinfo')
      assert_equal hReturn[0], hReturn[1]

   end

   # the following sections have their own test modules
   # citation, description, timePeriod, spatialDomain, keyword, taxonomy, constraint, contact, browse, security

   def test_identification_timePeriod

      # empty
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:timePeriod] = {}

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: time period is missing: CONTEXT is identification section'

      # missing
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo].delete(:timePeriod)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: time period is missing: CONTEXT is identification section'

   end

   def test_identification_keywords

      # empty
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:keyword] = []

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: keywords are missing: CONTEXT is identification section'

      # missing
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo].delete(:keyword)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: keywords are missing: CONTEXT is identification section'

   end

   def test_identification_constraint

      # empty
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

      # missing
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo].delete(:constraint)

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

   end

end

# MdTranslator - minitest of
# writers / fgdc / class_metadataInfo

# History:
#  Stan Smith 2018-01-27 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcMetadataInfo < TestWriterFGDCParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson in hash
   mdHash = TDClass.base

   hLegal = TDClass.build_legalConstraint(['metadata access constraint'], ['metadata use constraint'])
   mdHash[:metadata][:metadataInfo][:metadataConstraint] = []
   mdHash[:metadata][:metadataInfo][:metadataConstraint] << hLegal

   hSecurity = TDClass.build_securityConstraint('security classification',
                                                'security classification system',
                                                'security handling instructions')
   mdHash[:metadata][:metadataInfo][:metadataConstraint] << hSecurity

   @@mdHash = mdHash

   def test_metadataInfo_complete

      hReturn = TestWriterFGDCParent.get_complete(@@mdHash, 'metadataInfo', './metadata/metainfo')
      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

   def test_metadataInfo_creationDate

      # empty metadata dates
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:metadataInfo][:metadataDate] = []

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: metadata creation date is missing: CONTEXT is metadata information section'

      # missing creation date
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:metadataInfo][:metadataDate][0][:dateType] = 'notCreation'

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: metadata creation date is missing: CONTEXT is metadata information section'

   end

   def test_metadataInfo_security

      # missing metadata security
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:metadataInfo][:metadataConstraint] = []

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_empty  hResponseObj[:writerMessages]

      # missing metadata security
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:metadataInfo][:metadataConstraint].delete_at(1)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_empty  hResponseObj[:writerMessages]

      # missing metadata security elements
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:metadataInfo][:metadataConstraint][1][:security][:classificationSystem] = ''
      hIn[:metadata][:metadataInfo][:metadataConstraint][1][:security][:handlingDescription] = ''

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 2, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: security classification system is missing: CONTEXT is metadata information section'
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: security handling instructions are missing: CONTEXT is metadata information section'

   end

end

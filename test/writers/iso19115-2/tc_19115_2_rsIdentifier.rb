# MdTranslator - minitest of
# writers / iso19115_2 / class_rsIdentifier

# History:
#  Stan Smith 2018-04-30 refactored for error messaging
#  Stan Smith 2017-11-20 replace REXML with Nokogiri
#  Stan Smith 2017-01-09 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152RSIdentifier < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hIdentifier = TDClass.build_identifier('rsIdentifier', 'ISO 19115-2',
                                          'version', 'spatial reference system identifier')
   hRefSystem = TDClass.build_spatialReference(nil, hIdentifier)
   mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hRefSystem

   @@mdHash = mdHash

   def test_rsIdentifier_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_rsIdentifier',
                                                '//gmd:referenceSystemIdentifier[1]',
                                                '//gmd:referenceSystemIdentifier', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_rsIdentifier_missing_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hRefSystem = TDClass.build_spatialReference(nil, { identifier: 'rsIdentifier' })
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem] << hRefSystem

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_rsIdentifier',
                                                '//gmd:referenceSystemIdentifier[2]',
                                                '//gmd:referenceSystemIdentifier', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end

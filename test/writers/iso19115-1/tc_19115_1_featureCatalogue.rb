# MdTranslator - minitest of
# writers / iso19115_1 / class_coverageDescription / FC_FeatureCatalogue

# History:
#  Stan Smith 2019-08-20 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_1_test_parent'

class TestWriter191151FeatureCatalogue < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:dataDictionary] << TDClass.dataDictionary

   @@mdHash = mdHash

   def test_coverageDescription_featureCatalogue

      hReturn = TestWriter191151Parent.run_test(@@mdHash, '19115_1_coverageDescription', '//mdb:contentInfo[1]',
                                                '//mdb:contentInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]
   end

end

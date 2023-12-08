# MdTranslator - minitest of
# writers / iso19115_3 / class_coverageDescription / FC_FeatureCatalogue

# History:
#  Stan Smith 2019-08-20 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151FeatureCatalogue < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:dataDictionary] << TDClass.dataDictionary

   @@mdHash = mdHash

   def test_coverageDescription_featureCatalogue

      hReturn = TestWriter191151Parent.run_test(@@mdHash, '19115_3_featureCatalogue', '//gfc:FC_FeatureCatalogue[1]',
                                                '//gfc:FC_FeatureCatalogue', 0)

      # TODO figure out what is happening here
      # last line of testData XML is imported with an extra space at the fist of the line
      # I can't seem to get rid of it.  So, these extra steps ....
      aExpect = hReturn[0].strip.split("\n")
      aGot = hReturn[1].strip.split("\n")
      lastLine = aExpect.pop
      lastLine = aGot.pop
      assert_equal '</gfc:FC_FeatureCatalogue>', lastLine

      assert_equal aExpect, aGot
      assert hReturn[2]
      assert_includes hReturn[3], 'WARNING: ISO-19110 writer: feature catalogue feature type is missing'

   end

end

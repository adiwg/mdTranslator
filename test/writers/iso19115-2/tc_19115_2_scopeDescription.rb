# MdTranslator - minitest of
# writers / iso19115_2 / class_scopeDescription

# History:
#  Stan Smith 2018-04-30 refactored for error messaging
#  Stan Smith 2017-11-20 replace REXML with Nokogiri
#  Stan Smith 2017-01-10 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152ScopeDescription < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hLineage = TDClass.lineage

   hScope = hLineage[:scope]
   hScope[:scopeDescription] << { dataset: 'dataset one' }
   hScope[:scopeDescription] << { dataset: 'dataset two' }
   hScope[:scopeDescription] << { attributes: 'attribute one' }
   hScope[:scopeDescription] << { features: 'feature one' }
   hScope[:scopeDescription] << { other: 'other one' }

   mdHash[:metadata][:resourceLineage] = []
   mdHash[:metadata][:resourceLineage] << hLineage

   @@mdHash = mdHash

   def test_scopeDescription_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_scopeDescription',
                                                '//gmd:scope[1]',
                                                '//gmd:scope', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end

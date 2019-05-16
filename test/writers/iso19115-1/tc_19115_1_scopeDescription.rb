# MdTranslator - minitest of
# writers / iso19115_1 / class_scopeDescription

# History:
#  Stan Smith 2019-05-14 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_1_test_parent'

class TestWriter191151ScopeDescription < TestWriter191151Parent

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

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_scopeDescription',
                                                '//mrl:scope[1]',
                                                '//mrl:scope', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end

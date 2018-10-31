# mdJson 2.0 writer tests - geologic age

# History:
#  Stan Smith 2018-06-05 refactor to use mdJson construction helpers
#  Stan Smith 2017-11-08 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonGeologicAge < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hTimePeriod = mdHash[:metadata][:resourceInfo][:timePeriod]
   hTimePeriod.delete(:startDateTime)
   hTimePeriod[:startGeologicAge] = TDClass.build_geologicAge
   hTimePeriod[:startGeologicAge][:ageReference] << TDClass.build_citation('start geologic age reference one', 'CID001')
   hTimePeriod[:startGeologicAge][:ageReference] << TDClass.build_citation('start geologic age reference two', 'CID001')
   hTimePeriod[:endGeologicAge] = TDClass.build_geologicAge
   hTimePeriod[:endGeologicAge][:ageReference] << TDClass.build_citation('end geologic age reference one', 'CID001')

   @@mdHash = mdHash

   def test_schema_geologicAge

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hTest = hIn[:metadata][:resourceInfo][:timePeriod][:startGeologicAge]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'geologicAge.json')
      assert_empty errors

   end

   def test_complete_geologicAge

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'none',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['resourceInfo']['timePeriod']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['timePeriod']

      assert metadata[:writerPass]
      assert metadata[:readerStructurePass]
      assert metadata[:readerValidationPass]
      assert metadata[:readerExecutionPass]
      assert_empty metadata[:writerMessages]
      assert_empty metadata[:readerStructureMessages]
      assert_empty metadata[:readerValidationMessages]
      assert_empty metadata[:readerExecutionMessages]
      assert_equal expect, got

   end

end

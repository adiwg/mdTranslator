# mdJson 2.0 writer tests - duration

# History:
#  Stan Smith 2018-06-04 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-16 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonDuration < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   @@mdHash = mdHash

   def test_schema_duration

      hHash = Marshal::load(Marshal.dump(@@mdHash))
      hTimePeriod = hHash[:metadata][:resourceInfo][:timePeriod]
      TDClass.add_duration(hTimePeriod,1,2,3,4,5,6)
      hJson = JSON.parse(hHash.to_json)

      hTest = hJson['metadata']['resourceInfo']['timePeriod']['duration']
      errors = TestWriterMdJsonParent.testSchema(hTest, 'timePeriod.json', :fragment=>'duration')
      assert_empty errors

   end

   def test_complete_duration

      hHash = Marshal::load(Marshal.dump(@@mdHash))
      hTimePeriod = hHash[:metadata][:resourceInfo][:timePeriod]
      TDClass.add_duration(hTimePeriod,1,2,3,4,5,6)

      metadata = ADIWG::Mdtranslator.translate(
         file: hHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(hHash.to_json)
      expect = expect['metadata']['resourceInfo']['timePeriod']['duration']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['timePeriod']['duration']

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

   def test_duration_year

      hHash = Marshal::load(Marshal.dump(@@mdHash))
      hTimePeriod = hHash[:metadata][:resourceInfo][:timePeriod]
      TDClass.add_duration(hTimePeriod,1)

      metadata = ADIWG::Mdtranslator.translate(
         file: hHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(hHash.to_json)
      expect = expect['metadata']['resourceInfo']['timePeriod']['duration']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['timePeriod']['duration']

      assert_equal expect, got

   end

   def test_duration_date

      hHash = Marshal::load(Marshal.dump(@@mdHash))
      hTimePeriod = hHash[:metadata][:resourceInfo][:timePeriod]
      TDClass.add_duration(hTimePeriod,1, 2, 3)

      metadata = ADIWG::Mdtranslator.translate(
         file: hHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(hHash.to_json)
      expect = expect['metadata']['resourceInfo']['timePeriod']['duration']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['timePeriod']['duration']

      assert_equal expect, got

   end

   def test_duration_time

      hHash = Marshal::load(Marshal.dump(@@mdHash))
      hTimePeriod = hHash[:metadata][:resourceInfo][:timePeriod]
      TDClass.add_duration(hTimePeriod,nil, nil, nil, 4, 5, 6)

      metadata = ADIWG::Mdtranslator.translate(
         file: hHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(hHash.to_json)
      expect = expect['metadata']['resourceInfo']['timePeriod']['duration']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['timePeriod']['duration']

      assert_equal expect, got

   end

end

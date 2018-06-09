# mdJson 2.0 writer tests - date time

# History:
#  Stan Smith 2018-06-01 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-16 original script

# not all date formats are testable using this method
# ... date formats with 'Z' input output as '+00:00'
# ... date formats with fractional seconds always out put to 3 decimal places
# ... dates with zone offset '-9' input outputs as '-09:00'

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonDateTime < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   aDates = mdHash[:metadata][:metadataInfo][:metadataDate]
   aDates << TDClass.build_date('2018', 'year')
   aDates << TDClass.build_date('2018-06', 'month')
   aDates << TDClass.build_date('2018-06-01', 'day')
   aDates << TDClass.build_date('2018-06-01T17', 'hour')
   aDates << TDClass.build_date('2018-06-01T18:01', 'minute')
   aDates << TDClass.build_date('2018-06-01T18:01:50', 'second')
   aDates << TDClass.build_date('2018-06-01T18:02:25.678', 'fraction')
   aDates << TDClass.build_date('2018-06-01T18:03:22-09:00', 'zone offset')

   @@mdHash = mdHash

   def test_complete_dateTime

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['metadataInfo']['metadataDate']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['metadataInfo']['metadataDate']

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

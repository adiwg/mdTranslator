require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

require 'pry'

class TestWriterMdJsonDataQuality < TestWriterMdJsonParent
  TDClass = MdJsonHashWriter.new

  mdHash = TDClass.base

  # data quality []
  mdHash[:metadata][:dataQuality] = []
  mdHash[:metadata][:dataQuality] << TDClass.build_dataQuality
  mdHash[:metadata][:dataQuality] << TDClass.build_dataQuality

  @@mdHash = mdHash

  def test_schema_dataQuality
    hTest = @@mdHash[:metadata][:dataQuality][0]
    errors = TestWriterMdJsonParent.testSchema(hTest, 'dataQuality.json')

    assert_empty errors
  end

  def test_schema_conformanceResult
    hTest = @@mdHash[:metadata][:dataQuality][0][:report][0][:conformanceResult][0]
    errors = TestWriterMdJsonParent.testSchema(hTest, 'conformanceResult.json')

    assert_empty errors
  end
end

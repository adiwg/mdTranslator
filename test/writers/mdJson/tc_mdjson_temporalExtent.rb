# mdJson 2.0 writer tests - temporal extent

# History:
#   Stan Smith 2017-03-15 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterTemporalExtent < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('temporalExtent.json')

   def test_schema_temporalExtent

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceInfo']['extent'][0]['temporalExtent']

      ADIWG::MdjsonSchemas::Utils.load_schemas(false)

      # test timeInstant
      errors = JSON::Validator.fully_validate('temporalExtent.json', hTest[0])
      assert_empty errors

      # test timePeriod
      errors = JSON::Validator.fully_validate('temporalExtent.json', hTest[1])
      assert_empty errors

   end

   def test_complete_temporalExtent

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceInfo']['extent'][0]
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['extent'][0]

      assert_equal expect, got

   end

end

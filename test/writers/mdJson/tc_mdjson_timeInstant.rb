# mdJson 2.0 writer tests - time instant

# History:
#   Stan Smith 2017-03-16 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonTimeInstant < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('timeInstant.json')

   def test_schema_timeInstant

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceInfo']['extent'][0]['temporalExtent'][0]

      ADIWG::MdjsonSchemas::Utils.load_schemas(false)

      # test timeInstant
      errors = JSON::Validator.fully_validate('temporalExtent.json', hTest)
      assert_empty errors

   end

   def test_complete_timeInstant

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceInfo']['extent']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['extent']

      assert_equal expect, got

   end

end

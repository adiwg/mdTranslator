# mdJson 2.0 writer tests - oblique line point

# History:
#   Stan Smith 2017-10-24 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonObliqueLinePoint < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('projectionParameters.json')

   # TODO complete after schema update
   # def test_schema_obliqueLinePoint
   #
   #    hIn = JSON.parse(@@jsonIn)
   #    hTest = hIn['metadata']['resourceInfo']['spatialReferenceSystem'][0]
   #    errors = TestWriterMdJsonParent.testSchema(hTest, 'spatialReference.json')
   #    assert_empty errors
   #
   # end

   def test_complete_obliqueLinePoint

      # TODO validate normal after schema update
      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'none',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceInfo']['spatialReferenceSystem'][0]['referenceSystemParameterSet']['projection']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['spatialReferenceSystem'][0]['referenceSystemParameterSet']['projection']

      assert_equal expect, got

   end

end

# mdJson 2.0 writer tests - constraint

# History:
#   Stan Smith 2017-03-17 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterConstraint < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('constraint.json')

   def test_schema_constraint

      hIn = JSON.parse(@@jsonIn)
      hTest = hIn['metadata']['resourceInfo']['constraint'][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'constraint.json')
      assert_empty errors

   end

   def test_complete_constraint

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceInfo']['constraint']
      expect[0].delete('legal')
      expect[0].delete('security')
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['constraint']

      assert_equal expect, got

   end

end

# sbJson 1 writer tests - spatial

# History:
#  Stan Smith 2017-06-01 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'sbjson_test_parent'

class TestWriterSbJsonSpatial < TestWriterSbJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterSbJsonParent.getJson('spatial.json')

   def test_boundingBox

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'sbJson', showAllTags: false)

      expect = {
         'boundingBox' => {
            'maxY' =>67.663378,
            'minY' =>-20.0,
            'maxX' =>-80.0,
            'minX' =>160.0
         }
      }

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['spatial']

      assert_equal expect, got

   end

end



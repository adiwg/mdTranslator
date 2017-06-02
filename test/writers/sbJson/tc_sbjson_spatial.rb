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

   def test_citation

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'sbJson', showAllTags: false)

      expect = {
         'boundingBox' => {
            'maxY' =>67.663378,
            'minY' =>0.0,
            'maxX' =>-10.0,
            'minX' =>90.0
         }
      }

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['spatial']
      File.write('/mnt/hgfs/ShareDrive/writeOut.json', hJsonOut)
      
      assert_equal expect, got

   end

end



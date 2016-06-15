require 'minitest/autorun'
require 'json'
#require 'adiwg-mdtranslator'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/writers/sbJson/sbJson_writer'

class Test_Write_mdJSONv1 < MiniTest::Test
  @@reader = 'mdJson'
  @@writer = 'sbJson'

  def test_full_success
    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../../', 'schemas/v1_0/examples', 'full_example.json')
    file = File.open(file, 'r')
    jsonObj = file.read
    file.close

    # call opening module in mdTranslator
    metadata = ADIWG::Mdtranslator.translate(
      file: jsonObj, reader: @@reader, validate: 'normal',
      writer: @@writer, showAllTags: false)

    version = JSON.parse(jsonObj)['version']['version'].split('.')


    assert_equal('json', metadata[:readerFormat], 'Check reader name')
    assert metadata[:readerStructurePass], metadata[:readerStructureMessages].join(',')
    assert_equal(@@reader, metadata[:readerRequested])

    # major version
    assert_equal(version[0], metadata[:readerVersionUsed].split('.')[0])

    assert metadata[:readerValidationPass], "reader validation failed: \n" + metadata[:readerValidationMessages].join(',')
    assert_equal(@@writer, metadata[:writerName])
    assert metadata[:writerPass], "writer validation failed: \n" + metadata[:writerMessages].join(',')
    refute_nil metadata[:writerOutput]
  end

  def test_minimum_succes
    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../../', 'schemas/v1_0/examples', 'minimum_example.json')
    file = File.open(file, 'r')
    jsonObj = file.read
    file.close

    # call opening module in mdTranslator
    metadata = ADIWG::Mdtranslator.translate(
      file: jsonObj, reader: @@reader, validate: 'normal',
      writer: @@writer, showAllTags: true)

    assert_equal('json', metadata[:readerFormat], 'Check reader name')
    assert metadata[:readerStructurePass], metadata[:readerStructureMessages].join(',')
    assert_equal(@@reader, metadata[:readerRequested])
    assert metadata[:readerValidationPass], "reader validation failed: \n" + metadata[:readerValidationMessages].join(',')
    assert_equal(@@writer, metadata[:writerName])
    assert metadata[:writerPass], "writer validation failed: \n" + metadata[:writerMessages].join(',')
    refute_nil metadata[:writerOutput]
  end
end

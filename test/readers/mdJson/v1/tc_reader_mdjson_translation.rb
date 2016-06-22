# MdTranslator - code to test mdtranslator from Ruby Terminal during development

# History:
# Stan Smith 2014-07-02 original script
# Josh Bradley 2014-09-28 updated to use test/unit
# Stan Smith 2015-01-16 changed ADIWG::Mdtranslator.translate() to keyword parameters
# Stan Smith 2015-06-22 refactored setup to after removal of globals

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'

class TestTranslation_mdJson_v1 < MiniTest::Test
  @@reader = 'mdJson'
  @@writer = 'html'

  def test_full_success
    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../../', 'schemas/v1_0/examples', 'full_example.json')
    file = File.open(file, 'r')
    jsonObj = file.read
    file.close

    # call opening module in mdTranslator
    metadata = ADIWG::Mdtranslator.translate(
      file: jsonObj, reader: @@reader, validate: 'normal',
      writer: @@writer, showAllTags: 'true')
    version = JSON.parse(jsonObj)['version']['version'].split('.')

    assert_equal('json', metadata[:readerFormat], 'Check reader name')
    assert metadata[:readerStructurePass], metadata[:readerStructureMessages].join(',')
    assert_equal(@@reader, metadata[:readerRequested])

    # major version
    assert_equal(version[0], metadata[:readerVersionUsed].split('.')[0])

    assert metadata[:readerValidationPass], "reader validation failed: \n" + metadata[:readerValidationMessages].join(',')
    assert metadata[:readerExecutionPass], "reader execution failed: \n" + metadata[:readerExecutionMessages].join(',')
    assert_equal(@@writer, metadata[:writerName])
    assert metadata[:writerPass], "writer validation failed: \n" + metadata[:writerMessages].join(',')
    refute_nil metadata[:writerOutput]
  end

  def test_minimum_success
    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../../', 'schemas/v1_0/examples', 'minimum_example.json')
    file = File.open(file, 'r')
    jsonObj = file.read
    file.close

    # call opening module in mdTranslator
    metadata = ADIWG::Mdtranslator.translate(
      file: jsonObj, reader: @@reader, validate: 'normal',
      writer: @@writer, showAllTags: 'true')

    assert_equal('json', metadata[:readerFormat], 'Check reader name')
    assert metadata[:readerStructurePass], metadata[:readerStructureMessages].join(',')
    assert_equal(@@reader, metadata[:readerRequested])
    assert metadata[:readerValidationPass], "reader validation failed: \n" + metadata[:readerValidationMessages].join(',')
    assert metadata[:readerExecutionPass], "reader execution failed: \n" + metadata[:readerExecutionMessages].join(',')
    assert_equal(@@writer, metadata[:writerName])
    assert metadata[:writerPass], "writer validation failed: \n" + metadata[:writerMessages].join(',')
    refute_nil metadata[:writerOutput]
  end

  def test_writers
    dir = File.join(File.dirname(__FILE__), '../../../..', 'lib/adiwg/mdtranslator/writers')
    writers = (Dir.glob "#{dir}/*/").map { |a| File.basename(a) }.reject! { |a| a == 'iso19110' }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../../', 'schemas/v1_0/examples', 'full_example.json')
    file = File.open(file, 'r')
    jsonObj = file.read
    file.close

    writers.each do |writer|
      # call opening module in mdTranslator
      metadata = ADIWG::Mdtranslator.translate(
        file: jsonObj, reader: @@reader, validate: 'normal',
        writer: writer, showAllTags: 'true')

      refute_nil metadata[:writerOutput], "Failed to translate #{@@reader} to #{writer}!"
    end
  end
end

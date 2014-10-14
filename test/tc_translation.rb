# MdTranslator - code to test mdtranslator from Ruby Terminal during development

# History:
# Stan Smith 2014-07-02 original script
# Josh Bradley 2014-09-28 updated to use test/unit

require 'minitest/autorun'
require 'json'
require File.join(File.expand_path('..', __FILE__),'..','lib', 'adiwg-mdtranslator.rb')

class TestTranslation_v0_8 < MiniTest::Unit::TestCase
  @@reader = 'adiwgJson'
  @@writer = 'iso19115_2'

  def test_ouput_success
    # read test adiwg full json test
    file = File.open(File.join(File.dirname(__FILE__),'schemas','v0_8','examples','full_example.json'), 'r')
    jsonObj = file.read
    file.close

    # call opening module in mdTranslator

    metadata = ADIWG::Mdtranslator.translate(jsonObj,@@reader,@@writer,'normal','true')
    version = JSON.parse(jsonObj)['version']['version'].split('.')

    assert_equal('json',metadata[:readerFormat])
    assert metadata[:readerStructurePass]
    assert_equal(@@reader,metadata[:readerName])
    #major version
    assert_equal(version[0],metadata[:readerVersionUsed].split('.')[0])
    #minor version
    assert_equal(version[1],metadata[:readerVersionUsed].split('.')[1])
    assert metadata[:readerValidationPass]
    assert_equal(@@writer,metadata[:writerName])
    assert metadata[:writerPass]
    refute_nil metadata[:writerOutput]
  end

  def test_minimum
    # read test adiwg minimum json test
    file = File.open(File.join(File.dirname(__FILE__),'schemas','v0_8','examples','minimum_example.json'), 'r')
    jsonObj = file.read
    file.close

    # call opening module in mdTranslator
    metadata = ADIWG::Mdtranslator.translate(jsonObj,@@reader,@@writer,'normal','true')

    assert_equal('json',metadata[:readerFormat])
    assert metadata[:readerStructurePass]
    assert_equal(@@reader,metadata[:readerName])
    assert metadata[:readerValidationPass]
    assert_equal(@@writer,metadata[:writerName])
    assert metadata[:writerPass]
    refute_nil metadata[:writerOutput]
  end
end

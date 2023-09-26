# MdTranslator - minitest of
# parent class for all tc_mdjson tests

# History:
#  Stan Smith 2018-10-30 add 'addParameters' to testSchema
#  Stan Smith 2017-03-11 original script

require 'minitest/autorun'
require 'json'
require 'json-schema'
require 'adiwg-mdjson_schemas'

class TestWriterMdJsonParent < Minitest::Test

   # get json file for tests from examples folder
   def self.getJson(fileName)

      file = File.join(File.dirname(__FILE__), 'testData', fileName)
      file = File.open(file, 'r')
      jsonFile = file.read
      file.close
      return jsonFile

   end

   # test schema for writer modules
   def self.testSchema(mdJson, schema, fragment: nil, remove: [], addProperties: {})

      # load all schemas with 'true' to prohibit additional parameters
      ADIWG::MdjsonSchemas::Utils.load_schemas(false)

      # load schema segment and make all elements required and prevent additional parameters
      strictSchema = ADIWG::MdjsonSchemas::Utils.load_strict(schema)

      # remove unwanted parameters from the required array
      unless remove.empty?
         strictSchema['required'] = strictSchema['required'] - remove
      end

      # add additional properties for cases of oneOf objects
      unless addProperties.empty?
         strictSchema['properties'].merge!(addProperties)
      end

      # build relative path to schema fragment
      fragmentPath = nil
      if fragment
         fragmentPath = '#/definitions/' + fragment
      end

      # scan
      return JSON::Validator.fully_validate(strictSchema, mdJson, :fragment => fragmentPath)

   end

end

class Hash
   def deep_diff(other)
      (self.keys + other.keys).uniq.inject({}) do |memo, key|
         left = self[key]
         right = other[key]

         next memo if left == right

         if left.respond_to?(:deep_diff) && right.respond_to?(:deep_diff)
            memo[key] = left.deep_diff(right)
         else
            memo[key] = [left, right]
         end

         memo
      end
   end
end

class Array
   def deep_diff(array)
      largest = [self.count, array.count].max
      memo = {}

      0.upto(largest - 1) do |index|
         left = self[index]
         right = array[index]

         next if left == right

         if left.respond_to?(:deep_diff) && right.respond_to?(:deep_diff)
            memo[index] = left.deep_diff(right)
         else
            memo[index] = [left, right]
         end
      end
   end
end

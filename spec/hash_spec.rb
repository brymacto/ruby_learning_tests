RSpec.describe 'Hash' do
  describe '== [other hash]' do

    it "returns true if other hash has exact same keys and values" do 
      h1 = {a: 2, b: 3}
      h2 = {a: 2, b: 3}

      result = (h1 == h2)

      expect(result).to eql(true)
    end

    it "returns true if other hash has same keys and values in different order" do 
      h1 = {a: 2, b: 3}
      h2 = {b: 3, a: 2}

      result = (h1 == h2)

      expect(result).to eql(true)
    end

    it "returns false if other hash has different key/value pairs" do 
      h1 = {a: 2, b: 3, c: 4}
      h2 = {b: 3, a: 2}

      result = (h1 == h2)

      expect(result).to eql(false)
    end
  end

  describe '[key] returns value' do
    it "returns value if key exists" do
      h = {a: 1, b: 2}
      
      val = h[:a]

      expect(val).to eql(1)
    end

    it "returns nil if key doesn't exist" do
      h = {a: 1, b: 2}
      
      val = h[:c]

      expect(val).to eql(nil)
    end
  end

  describe 'element assignment' do
    it 'associates value with the key given' do
      h = {a: 1, b:2}

      h[:a] = 2
      h[:c] = 2

      expect(h).to eql({a: 2, b:2, c: 2})
    end
  end

  describe "#any" do
    it "returns true when value matches block" do
      h = {a: 2, b: 3, c: 5}

      result = h.any? {|key, value| (value % 2) == 0 }

      expect(result).to eql(true)
    end

    it "returns true when key matches block" do
      h = {a: 2, b: 3, c: 5}

      result = h.any? {|key, value| key == :b }

      expect(result).to eql(true)
    end
  end

  describe "#assoc" do
    it "returns key value pair if a match is found" do
      h = {a: 2, b: 3, c: 5}

      result = h.assoc(:a)

      expect(result).to eql([:a, 2])
    end

    it "returns nil if a match is not found" do
      h = {a: 2, b: 3, c: 5}

      result = h.assoc(:d)

      expect(result).to be_nil
    end
  end

  describe "#clear" do
    it "clears all key/value pairs from hash" do
      h = {a: 2, b: 3, c: 5}

      h.clear

      expect(h).to eql({})

    end
  end

  describe "#compare_by_identity" do
    it "makes the hash compare by identity (object_id)" do
      h = {"a" => 1, "b" => 2, "c" => 3}
      
      result_before_action = h["a"]
      h.compare_by_identity
      result_after_action = h["a"]

      expect(result_before_action).to eql(1)
      expect(result_after_action).to be_nil
    end

  end

  describe "#default" do
    it "returns nil if no default specified" do
      h = {a: 1, b: 2}

      result = h.default
      result2 = h[:c]

      expect(result).to be_nil
      expect(result2).to be_nil
    end

    it "returns default if specified" do
      h = Hash.new(0)

      result = h.default
      result2 = h[:c]

      expect(result).to eql(0)
      expect(result2).to eql(0)
    end
  end

  describe "#default_proc" do
    it "returns block if default is a block" do
      h = Hash.new{|hash,key| hash[key] = "Default value for key #{k}"}

      result = h.default_proc

      expect(result).to be_a_kind_of(Proc)
    end

    it "returns nil if default is not a block" do
      h = Hash.new('default')

      result = h.default_proc

      expect(result).to be_nil
    end

  end

  describe "#delete" do
    it "deletes value matching key pair" do
      h = {a: 1, b: 2, c: 3}

      h.delete(:a)

      expect(h).to eql({b:2, c:3})
    end

    it "returns the value matching key pair" do
      h = {a: 1, b: 2, c: 3}

      result = h.delete(:a)

      expect(result).to eql(1)
    end

    it "returns nil if no matching key" do
      h = {a: 1, b: 2, c: 3}

      result = h.delete(:d)

      expect(result).to be_nil
    end

  end

  describe "#delete_if" do
    it "deletes if value matches condition" do
      h = {a: 1, b: 2, c: 3, d: 11, e: 12, f: 13}
      
      h.delete_if { |key, value|
        value > 10
      }

      expect(h).to eql({a: 1, b: 2, c: 3})
    end
  end

  describe "#each" do
    it "calls block with key and value" do
      result = []
      h = {a: 1, b: 2, c: 3}

      h.each{|key, value| result << [key, value]}

      expect(result).to eql([[:a, 1], [:b, 2], [:c, 3]])
    end
  end

  describe "#empty" do
    it "returns true for empty hash" do
      h = {}

      result = h.empty?

      expect(result).to eql(true)
    end
  end

  describe "#fetch" do
    it "raises KeyError if no match found, and no block was provided" do
      h = {a: 1, b: 2, c: 3}

      expect { h.fetch(:d) }.to raise_error(KeyError)
    end
    it "returns result of block if no match found, and block was provided" do
      h = {a: 1, b: 2, c: 3}

      result = h.fetch(:d) {|el| "Error for #{el}"}

      expect(result).to eql("Error for d")      
    end
  end

  describe "#flatten" do
    it "returns a new array that is a one-dimensional flattening of the hash" do
      h = {a: 1, b: 2, c: 3}
      
      result = h.flatten

      expect(result).to eql([:a, 1, :b, 2, :c, 3])
    end

  end

  describe "#has_key" do 
    it "returns true if given key is present, false if it is not" do
      h = {a: 1, b: 2, c: 3}

      result = h.has_key?(:a)
      result2 = h.has_key?(:d)

      expect(result).to eql(true)
      expect(result2).to eql(false)
    end
  end

  describe "#to_s" do
    it "converts hash to string" do
      h = {a: 1, b: 2}

      result = h.to_s

      expect(result).to eql("{:a=>1, :b=>2}")
    end
  end

  describe "#invert" do 
    it "inverts keys and values" do
      h = {a: 1, b: 2}

      result = h.invert

      expect(result).to eql({1=>:a, 2=>:b})
    end
  end

  describe "#keep_if" do
    it "deletes every pair for which block evaluates to false" do
      h = {a: 1, b: 2, c: 3, d: 11, e: 12, f: 13}
      h.keep_if{ |key,value| value < 10 }

      expect(h).to eql({a: 1, b: 2, c: 3})

    end
  end


  describe "#key" do
    it "returns key of given value" do
      h = {a: 1, b: 2, c: 3, d: 11, e: 12, f: 13}

      result = h.key(1)

      expect(result).to eql(:a)
    end
  end

  describe "#keys" do
    it "returns array with keys from hash" do
      h = {a: 1, b: 2, c: 3, d: 11, e: 12, f: 13}

      result = h.keys

      expect(result).to eql([:a, :b, :c, :d, :e, :f])
    end
  end

  describe "#length" do
    it "returns number of pairs in hash" do
      h = {a: 1, b: 2, c: 3, d: 11, e: 12, f: 13}

      result = h.length

      expect(result).to eql(6)
    end
  end

  describe "#merge" do
    it "merges two hashes, using value of 'other' hash when key matches" do
      h1 = {a: 1, b: 2}
      h2 = {b: 3, c: 4}

      result = h1.merge(h2)

      expect(result).to eql({a: 1, b: 3, c: 4})
    end
  end

  describe "#rassoc" do
    it "returns first key value pair as an array that matches" do
      h = {a: 1, b: 2, c: 3, d: 3, e: 3, f: 3}

      result = h.rassoc(3)

      expect(result).to eql([:c, 3])
    end
  end

  describe "#rehash" do    
    it "rehashes current hash based on hash values for each key, when key objects have changed" do
      a = [0,1]
      b = [2,3]

      h = {a => :x, b => :y}

      a[0] = 9
      expect(h[a]).to be_nil

      h.rehash
      expect(h[a]).to eql(:x)
    end
  end

  describe "#reject" do
    it "returns a new hash consisting of entries for which block returns false" do
      h = {a: 1, b: 2, c: 3, d: 11, e: 12, f: 13}

      result = h.reject { |key, value| value > 10}

      expect(result).to eql({a: 1, b: 2, c: 3})
    end
  end

  describe "#replace" do
    it "replaces contents of hash with other hash" do
      h = {a: 1, b: 2}
      h2 = {c: 3, d: 4}

      h.replace(h2)

      expect(h).to eql({c:3, d: 4})
    end
  end

  describe "#select" do 
    it "returns new hash consisting of entries for which block returns true" do
      h = {a: 1, b: 2, c: 3, d: 11, e: 12, f: 13}

      result = h.select{ |key, value| value < 10 }

      expect(result).to eql({a: 1, b: 2, c: 3})
    end

    it "returns enumerator when block is not provided" do
      h = {a: 1, b: 2, c: 3, d: 11, e: 12, f: 13}

      result = h.select

      expect(result).to be_a(Enumerator)
    end
  end

  describe "#shift" do
    it "removes key-value pair from hash" do
      h = {a: 1, b: 2, c: 3}

      h.shift

      expect(h).to eql({b: 2, c:3})
    end

    it "returns removed pair as an array" do
      h = {a: 1, b: 2, c: 3}

      result = h.shift

      expect(result).to eql([:a, 1])
    end
  end

  describe "#store" do
    it "updates value in hash for given key" do
      h = {a: 1, b: 2, c: 3}

      h.store(:a, 0)

      expect(h).to eql({a: 0, b: 2, c: 3})
    end
  end

  describe "#to_a" do
    it "returns nested array converted from hash" do
      h = {a: 1, b: 2, c: 3}

      result = h.to_a

      expect(result).to eql([[:a,1],[:b, 2],[:c, 3]])

    end
  end

  describe "#update" do
    it "adds contents of other hash to hash" do
      h = {a: 1, b: 2}
      h2 = {c: 3, d: 4}

      h.update(h2)

      expect(h).to eql({a: 1, b: 2, c: 3, d: 4})
    end
    it "overwrites duplicates if no block provided" do
      h = {a: 1, b: 2}
      h2 = {b: 3, c: 4}

      h.update(h2)

      expect(h).to eql({a: 1, b: 3, c: 4})
    end

    it "overwrites duplicates based on block, when provided" do
      h = {a: 1, b: 2, c: 3}
      h2 = {a: 4, b: 5, c: 6}

      h.update(h2) { |key, v1, v2|
        if key == :a
          v2
        else
          v1
        end
      }

      expect(h).to eql({a: 4, b: 2, c: 3})
    end
  end

  describe "#values" do
    it "returns array of values from hash" do
      h = {a: 1, b: 2, c: 3}

      result = h.values

      expect(result).to eql([1,2,3])
    end
  end

  describe "#values_at" do
    it "returns array of values associated with given keys" do
      h = {a: 1, b: 2, c: 3, d: 4}

      result = h.values_at(:a, :c)

      expect(result).to eql([1, 3])
    end

    it "returns nil if given keys are not present in hash" do
      h = {a: 1, b: 2, c: 3, d: 4}

      result = h.values_at(:e, :f)

      expect(result).to eql([nil, nil])
    end


  end


end
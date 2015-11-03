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


end
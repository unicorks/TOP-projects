#spec/caesar_spec.rb

require './caesar-cipher.rb'

describe "#caesar_cipher" do
  it 'returns properly ciphered string when cipher < 26' do
    expect(caesar_cipher(3, "hello")).to eql("khoor")
  end

  it 'returns correct string when cipher is > 26' do
    expect(caesar_cipher(29, "hello")).to eql("khoor")
  end

  it 'handles empty string' do
    expect(caesar_cipher(3, "")).to eql("")
  end

  it 'does not change numbers and punctuation' do
    expect(caesar_cipher(3, "hello1!")).to eql("khoor1!")
  end
end
require_relative '../lib/dark_trader'

describe "the trader... method" do
  it "should return something...     not nil" do
    expect(crypto_scrapper).not_to be_nil
  end
end

describe "the data scrapped on this web site... must be at least" do
  it "should return more than 600 values" do
    expect(crypto_scrapper.size).to be >= 190
  end  
end

describe "the hash_tab returned by crypto_scraper must be in a hash" do
  it "return an hash at the first position of the array (mini-hash)" do
    expect(crypto_scrapper[0].class).to eq(Hash)
  end
end 

describe "the Crypto 'BTC' 'EOS' 'ICX' should exist and with a strictly positive value" do

  it "should return a float more than 0 for 'BTC'" do
    expect(value_of_the_crypto_by_name(crypto_scrapper,"BTC").to_f>0).to eq(true)
  end  
  it "should return a float more than 0 for 'EOS'" do
    expect(value_of_the_crypto_by_name(crypto_scrapper,"EOS").to_f>0).to eq(true)
  end  
  it "should return a float more than 0 for 'ICX'" do
    expect(value_of_the_crypto_by_name(crypto_scrapper,"ICX").to_f>0).to eq(true)
  end  

end

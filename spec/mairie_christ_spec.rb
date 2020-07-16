require_relative '../lib/mairie_christ'


describe "the get_townhall_email method, it takes urls and cities and gives back a tab of hash 'townhall' => email" do
  it "it should return nil  with empty input array" do
    expect(get_townhall_email("")).to eq(nil)
  end
  it "it should also return nil  with nil input" do
    expect(get_townhall_email(nil)).to eq(nil)
  end
  # Les tests ne sont pas adaptés aux découpages des méthodes
  # it "the get_townhall_email should return a Array" do
  #   expect(get_townhall_email("http://annuaire-des-mairies.com/95/nerville-la-foret.html")).to be_kind_of(Array)
  # end
  # it "the get_townhall_email method should return good emails adresses for SAINT OUEN L AUMONE " do
  #   expect(get_townhall_email("https://www.annuaire-des-mairies.com/95/saint-ouen-l-aumone.html")).to eq({"SAINT OUEN L AUMONE"=>"courrier@ville-saintouenlaumone.fr"})
  # end
  # it "the get_townhall_email method should return good emails adresses for BELLEFONTAINE " do
  #   expect(get_townhall_email("https://www.annuaire-des-mairies.com/95/bellefontaine.html")).to eq({"SAINT OUEN L AUMONE"=>"mairiebellefontaine2@wanadoo.fr"})
  # end
end

describe "the get_townhall_urls method, scrappe a departement url and return a tab of urls and cities" do
  it "test good url[0]" do
    expect(get_townhall_urls[0].size == 185).to eq(true)
  end
  it "test good url" do
    expect(get_townhall_urls).to be_kind_of(Array)
  end
  # Les test suivant n'est plus adapté aux découpages des méthodes
  # it "the get_townhall_urls method should return good url for toownhall" do
  #   expect(get_townhall_urls().to eq({"https://www.annuaire-des-mairies.com/95/genainville.html"})
  # end
end

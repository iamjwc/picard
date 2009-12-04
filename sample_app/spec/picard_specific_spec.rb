require File.join(File.dirname(__FILE__), 'spec_helper')

describe 'Picard specific tests' do

  it 'should do an asynchronous GET in the callback' do
    res = Curl::Easy.perform(base_url + '/async_example')
    # response will look like /haml
    res.body_str.should include('<div id="name">Name: Jean-Luc Picard</div>')
    res.header_str.should include('200')
  end
  
  it 'should 404 on missing static content' do
    res = Curl::Easy.perform(base_url + '/i_dont_exist.html')
    res.body_str.should include('404')
    res.header_str.should include('404')
  end
  
  describe 'cookies' do
    before do
      @res = Curl::Easy.perform(base_url + '/cookie')
    end

    it 'should read from a set cookie' do
      @res.body_str.should eql('<h1>literature</h1>')
    end

    it 'should set two cookies' do
      @res.header_str.should include('Set-Cookie: hobby=literature;')
      @res.header_str.should include('Set-Cookie: user=LCDR Data;')
    end
  end

end
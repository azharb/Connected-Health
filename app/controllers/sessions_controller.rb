class SessionsController < ApplicationController
	require 'rest_client'
	require 'json'

	def new

	    # Redirect to the Google URL
	    redirect_to login_url.to_s

	  end

	  def create

	    # Get user tokens from GoogleHelper
	    user_tokens = get_tokens(params[:code])

	    profile_info = call_api('/oauth2/v2/userinfo', user_tokens['access_token'])
	    puts profile_info
	    # Get the username from Google
	    user_info = call_api('/plus/v1/people/me', user_tokens['access_token'])

	    puts user_info 
	    puts user_tokens

	    # Get the user, if they exist
	    user = GoogleAccount.where(:email => user_info['emails'].first['value']).first

	    # Create the user if they don't exist
	    if(user == nil)
	      user = GoogleAccount.create(:id => user_info['id'], :email => user_info['emails'].first['value'], 
	      	:name => user_info['name']['givenName'], 
	      	:refresh_token => user_tokens['refresh_token'], :token => user_tokens['access_token'], 
	      	:expires_at => user_tokens["expires_in"],
	      	:id_token => user_tokens['id_token'], :expires_at => user_tokens['expires_in'])
	      session[:user_id] = user.id

	    # Else update their info and save
	    else
    	  user.id = user_info['id']
	      user.refresh_token = user_tokens['refresh_token']
	      user.token = user_tokens['access_token']
	      user.expires_at = user_tokens['expires_in']
	      user.id_token = user_tokens['id_token']
	      user.save

	      session[:user_id] = user.id
	    end

	    # Redirect home
	    redirect_to session[:redirect_to] ||= root_path

	  end

	  def destroy
	    session[:user_id] = nil
	    redirect_to root_path
	  end

	  def code
	  	code = params[:code]
 
	    key = "glassmhealth"
	    secret = "w9WQziFWvYMhFMf81V7GXSp06PzAKFylPtfZ02Sg"
	 
	    auth_code_url = "https://#{key}:#{secret}@mhealth.att.com/access_token.json"
	    puts auth_code_url
	    response = RestClient.post auth_code_url, :nested => {:grant_type => 'authorization_code', 
	    	:code => code, :redirect_uri => "http://localhost:3000", "Content-type" => "application/json", :accept => :json} 
	 
	    access_token = JSON.parse(response)['access_token']

	    puts access_token
	end	 
end

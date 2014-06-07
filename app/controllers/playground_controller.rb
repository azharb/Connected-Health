class PlaygroundController < ApplicationController
	require 'rest-client'
	require 'json'

	attr_accessor :profile

  def dash
  	data = RestClient.get 'https://api-mhealth.att.com/v2/health/user?oauth_token=mhealthv3-voL3kDGLdJ3B30r4ub3u0w-LwFAnMisXEFvSCHwusCsA'
	@profile = JSON.parse(data)
  	puts profile
  end

  def sendToGlass
  	@healthcard_timeline_object = Glass::Healthcard.new(google_account_id:GoogleAccount.first.id)
  	@healthcard = {content: "hi"}
  	@healthcard_timeline_object.serialize(template_variables: {content: params[:text]})
  	@healthcard_timeline_object.insert()

  	redirect_to action: "dash"

  end
end

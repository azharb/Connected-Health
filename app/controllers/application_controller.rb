class ApplicationController < ActionController::Base
	include GoogleHelper
  protect_from_forgery

  CLIENT_ID = '202617025902-8mugdju6g22g45bots6g85k5ruc5fvk0.apps.googleusercontent.com'
  CLIENT_SECRET = 'u69bZrVT43EQlReOtKkidXtH'
  CLIENT_SCOPE = 'https://www.googleapis.com/auth/glass.timeline https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/plus.profile.emails.read'
  BASEURL = 'http://localhost:3000/'

  MHEALTH_ACCESS_CODE = 'mhealthv3-voL3kDGLdJ3B30r4ub3u0w-LwFAnMisXEFvSCHwusCsA'
end

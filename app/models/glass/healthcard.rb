class Glass::Healthcard < Glass::TimelineItem
attr_accessible :google_account_id, :glass_item_id, :glass_etag, :glass_self_link, :glass_kind, :glass_created_at, :glass_updated_at, :glass_content_type, :glass_content

  defaults_template_with  :simple



  ## this feature is experimental and not yet ready
  ## for use:
  # manages_template with: :template_manager


  #### these are your menu items which you define 
  #### for the timeline object.
  #### 


  has_menu_item :delete




  def custom_action_handler(response)
    ## logic for handling custom action
    ##
    ## response is a hash object which google sends back 
    ## when the action is invoked
  end

end

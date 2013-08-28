class SessionsController < Devise::SessionsController
  respond_to :json, :html
 
    def create
        respond_to do |format|
            format.html do
                super
            end

            format.json do
                resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")
                sign_in(resource_name, resource)                
                render :json => { :response => 'ok', :auth_token => current_user.authentication_token }.to_json, :status => :ok
            end
        end
    end


  def destroy
    current_user.authentication_token = nil
    super
  end
 
  protected
    def after_sign_up_path_for(resource)
    '/'
  end

  def verified_request?
    request.content_type == "application/json" || super
  end
end
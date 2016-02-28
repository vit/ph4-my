class HomeController < ApplicationController
    def index
        unless user_signed_in?
            redirect_to :controller => 'devise/sessions', :action => 'new'
        else
            redirect_to :controller => 'users', :action => 'show', :id => current_user
        end
    end
end

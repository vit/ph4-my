class HomeController < ApplicationController
    def index
        unless user_signed_in?
            redirect_to :controller => 'devise/sessions', :action => 'new'
        end
    end
end

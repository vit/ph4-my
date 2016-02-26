class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :ph_link

protected
  def ph_link name
    name = name.to_sym
    {
      home: 'https://station.locomotive.works/_app/vit/preview/',
      lib: 'http://lib.physcon.ru',
      cap: 'http://cap.physcon.ru',
      coms: 'http://coms.physcon.ru',
      my: 'https://ph4-my-vit2.c9users.io/'
    }[name]
  end

end

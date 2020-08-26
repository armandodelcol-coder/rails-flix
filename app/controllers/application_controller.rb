class ApplicationController < ActionController::Base

  # By default, Rails supports setting the :notice and :alert flash types when calling the redirect_to method
  add_flash_types(:danger)

end

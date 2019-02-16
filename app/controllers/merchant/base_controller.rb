class Merchant::BaseController < ApplicationController
  before_action :require_merchant

  def require_merchant
    render file: "/public/404" unless current_merchant?
  end

end

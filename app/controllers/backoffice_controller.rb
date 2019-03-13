# frozen_string_literal: true

class BackofficeController < ApplicationController
  before_action :authenticate_admin!
  layout 'backoffice'

  def pundit_user
    current_admin
  end
end

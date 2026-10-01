class TestErrorController < ApplicationController
  skip_before_action :ensure_valid_session

  def index
    begin
      session.to_h
      render plain: "OK"
    rescue Exception => e
      render plain: "ERR: #{e.class}: #{e.message}\n#{e.backtrace.join("\n")}"
    end
  end
end

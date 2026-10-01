class TestSessionController < ApplicationController
  def test
    begin
      val = session[:user_id]
      render plain: "OK: #{val.inspect}"
    rescue Exception => e
      render plain: "ERR: #{e.class}: #{e.message}\n#{e.backtrace[0..5].join("\n")}"
    end
  end
end

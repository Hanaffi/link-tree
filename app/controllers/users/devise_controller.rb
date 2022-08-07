class Users::DeviseController < ApplicationController

    class Responder < ActionController::Responder

        def to_turbo_stream
            controller.render(options.merge(formats: :html))
        rescue ActionView::MissingTemplate => e
            if get?
                raise e
            elsif has_errors? && default_action
                render rendering_options.merge(format: :html, status: :unprocessable_entity)
            else
                redirect_to navigation_location
            end
        end
    end

    self.responder = Responder
    respond_to :html, :turbo_stream
end
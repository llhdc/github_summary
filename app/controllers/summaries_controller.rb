class SummariesController < ApplicationController

  def search
    redirect_to summary_path(params[:q])
  end

  def show
    @summary = Summary.find_or_create_by(username: params[:username])

    LoadPageJob.perform_later(@summary)

    # if request.xhr?
    #   if @summary.ready?
    #     head 200
    #   else
    #     head 502
    #   end
    # end
  end

end

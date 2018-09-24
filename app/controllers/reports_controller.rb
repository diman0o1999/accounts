class ReportsController < ApplicationController


  def create
    @report = Report.new

    if @report.save
      render :json => true
    else
      render :json => false
    end
  end

  def new
    @report = Report.new

    render layout: false
  end




  private


  def report_params
    params.require(:report).permit( :category_id)
  end

end

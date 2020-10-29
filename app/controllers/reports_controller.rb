class ReportsController < ApplicationController
  before_action :set_report, only: [:edit, :update, :show, :destroy]

  def index
    @reports = Report.page(params[:page])
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)

    if @report.save
      redirect_to @report, notice: t('flash.create')
    else
      render :new
    end
  end

  def update
    if @report.update(report_params)
      redirect_to @report, notice: t('flash.update')
    else
      render :edit
    end
  end


  def destroy
    @report.destroy
    redirect_to reports_path, notice: t('flash.destroy')
  end

  private
    def set_report
      @report = Report.find(params[:id])
    end

    def report_params
      params.require(:report).permit(
        :title, :practice_status, :feeling_status, :learning_day,
        :start_at, :end_at, :content
      )
    end
end

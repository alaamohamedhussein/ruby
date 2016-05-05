class LecturesController < ApplicationController
  before_action :set_lecture, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user! ,only: [:new,:create]
  # GET /lectures
  # GET /lectures.json
  def index
    course=params[:format]
    # @params = course
    @lectures = Lecture.where(:course_id => course);
  end

  # GET /lectures/1
  # GET /lectures/1.json
  def show
  end

  # GET /lectures/new
  def new
    if !current_user.degree || current_user.degree == 'student'
      redirect_to courses_path
    end
    @lecture = Lecture.new()


  end

  # GET /lectures/1/edit
  def edit
  end
  def download

    new_lecture = params[:attachment]
    send_file new_lecture


  end
  # POST /lectures
  # POST /lectures.json
  def create
    @lecture = Lecture.new(lecture_params)
    @lecture.user_id = current_user.id
    # @lecture.course_id=params[:cid]
    respond_to do |format|
      if @lecture.save
        format.html { redirect_to @lecture, notice: 'Lecture was successfully created.' }
        format.json { render :show, status: :created, location: @lecture }
      else
        format.html { render :new }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lectures/1
  # PATCH/PUT /lectures/1.json
  def update
    respond_to do |format|
      if @lecture.update(lecture_params)
        format.html { redirect_to @lecture, notice: 'Lecture was successfully updated.' }
        format.json { render :show, status: :ok, location: @lecture }
      else
        format.html { render :edit }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lectures/1
  # DELETE /lectures/1.json
  def destroy
    @lecture.destroy
    respond_to do |format|
      format.html { redirect_to lectures_url, notice: 'Lecture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def vote
    Lecture.find(params[:lectid]).liked_by current_user  #lect obj +user obj
    render :json => {message: "lecture liked" , type: "successed"}
  end
  def unvote
    Lecture.find(params[:lectid]).unliked_by current_user #lect obj +user obj
    render :json => {message: "lecture unliked" , type: "successed"}
  end
  def spam
    Lecture.find(params[:lectid]).liked_by current_user,:vote_scope => 'spam' #lect obj +user obj
    render :json => {message: "lecture liked" , type: "successed"}
  end



  def unspam
    Lecture.find(params[:lectid]).unliked_by current_user,:vote_scope => 'spam' #lect obj +user obj
    render :json => {message: "lecture unliked" , type: "successed"}
  end
  def comment
    lect=params[:lectid];
    user=current_user.id;
    content=params[:content]
    Comment.create(content: content,user_id: user, lecture_id: lect);
    render :json => {message: "commented success" , type: "successed"}
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lecture
      @lecture = Lecture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lecture_params
      params.require(:lecture).permit(:content, :attachment, :user_id, :course_id)
    end

end

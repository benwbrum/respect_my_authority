require 'test_helper'

class SubjectsControllerTest < ActionController::TestCase
  setup do
    @subject = subjects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subjects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subject" do
    assert_difference('Subject.count') do
      post :create, subject: { analysis_id: @subject.analysis_id, has_loc_sh: @subject.has_loc_sh, items: @subject.items, loc_sh_alias: @subject.loc_sh_alias, loc_sh_url: @subject.loc_sh_url, name: @subject.name }
    end

    assert_redirected_to subject_path(assigns(:subject))
  end

  test "should show subject" do
    get :show, id: @subject
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @subject
    assert_response :success
  end

  test "should update subject" do
    patch :update, id: @subject, subject: { analysis_id: @subject.analysis_id, has_loc_sh: @subject.has_loc_sh, items: @subject.items, loc_sh_alias: @subject.loc_sh_alias, loc_sh_url: @subject.loc_sh_url, name: @subject.name }
    assert_redirected_to subject_path(assigns(:subject))
  end

  test "should destroy subject" do
    assert_difference('Subject.count', -1) do
      delete :destroy, id: @subject
    end

    assert_redirected_to subjects_path
  end
end

require 'test_helper'

class ApiKeysControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => ApiKey.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    ApiKey.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    ApiKey.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to api_key_url(assigns(:api_key))
  end

  def test_edit
    get :edit, :id => ApiKey.first
    assert_template 'edit'
  end

  def test_update_invalid
    ApiKey.any_instance.stubs(:valid?).returns(false)
    put :update, :id => ApiKey.first
    assert_template 'edit'
  end

  def test_update_valid
    ApiKey.any_instance.stubs(:valid?).returns(true)
    put :update, :id => ApiKey.first
    assert_redirected_to api_key_url(assigns(:api_key))
  end

  def test_destroy
    api_key = ApiKey.first
    delete :destroy, :id => api_key
    assert_redirected_to api_keys_url
    assert !ApiKey.exists?(api_key.id)
  end
end

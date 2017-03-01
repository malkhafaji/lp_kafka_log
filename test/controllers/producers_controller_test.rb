require 'test_helper'

class ProducersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @producer = producers(:one)
  end

  test "should get index" do
    get producers_url, as: :json
    assert_response :success
  end

  test "should create producer" do
    assert_difference('Producer.count') do
      post producers_url, params: { producer: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show producer" do
    get producer_url(@producer), as: :json
    assert_response :success
  end

  test "should update producer" do
    patch producer_url(@producer), params: { producer: {  } }, as: :json
    assert_response 200
  end

  test "should destroy producer" do
    assert_difference('Producer.count', -1) do
      delete producer_url(@producer), as: :json
    end

    assert_response 204
  end
end

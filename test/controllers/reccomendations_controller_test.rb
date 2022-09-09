require "test_helper"

class ReccomendationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reccomendation = reccomendations(:one)
  end

  test "should get index" do
    get reccomendations_url
    assert_response :success
  end

  test "should get new" do
    get new_reccomendation_url
    assert_response :success
  end

  test "should create reccomendation" do
    assert_difference("Reccomendation.count") do
      post reccomendations_url, params: { reccomendation: {  } }
    end

    assert_redirected_to reccomendation_url(Reccomendation.last)
  end

  test "should show reccomendation" do
    get reccomendation_url(@reccomendation)
    assert_response :success
  end

  test "should get edit" do
    get edit_reccomendation_url(@reccomendation)
    assert_response :success
  end

  test "should update reccomendation" do
    patch reccomendation_url(@reccomendation), params: { reccomendation: {  } }
    assert_redirected_to reccomendation_url(@reccomendation)
  end

  test "should destroy reccomendation" do
    assert_difference("Reccomendation.count", -1) do
      delete reccomendation_url(@reccomendation)
    end

    assert_redirected_to reccomendations_url
  end
end

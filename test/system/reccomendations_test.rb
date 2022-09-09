require "application_system_test_case"

class ReccomendationsTest < ApplicationSystemTestCase
  setup do
    @reccomendation = reccomendations(:one)
  end

  test "visiting the index" do
    visit reccomendations_url
    assert_selector "h1", text: "Reccomendations"
  end

  test "should create reccomendation" do
    visit reccomendations_url
    click_on "New reccomendation"

    click_on "Create Reccomendation"

    assert_text "Reccomendation was successfully created"
    click_on "Back"
  end

  test "should update Reccomendation" do
    visit reccomendation_url(@reccomendation)
    click_on "Edit this reccomendation", match: :first

    click_on "Update Reccomendation"

    assert_text "Reccomendation was successfully updated"
    click_on "Back"
  end

  test "should destroy Reccomendation" do
    visit reccomendation_url(@reccomendation)
    click_on "Destroy this reccomendation", match: :first

    assert_text "Reccomendation was successfully destroyed"
  end
end

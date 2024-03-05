defmodule AllergyAppWeb.DatapointLiveTest do
  use AllergyAppWeb.ConnCase

  import Phoenix.LiveViewTest
  import AllergyApp.AllergyFixtures

  @create_attrs %{intensity: 42, medicine: true, medicinetype: "some medicinetype", region: "some region", symptom: "some symptom"}
  @update_attrs %{intensity: 43, medicine: false, medicinetype: "some updated medicinetype", region: "some updated region", symptom: "some updated symptom"}
  @invalid_attrs %{intensity: nil, medicine: false, medicinetype: nil, region: nil, symptom: nil}

  defp create_datapoint(_) do
    datapoint = datapoint_fixture()
    %{datapoint: datapoint}
  end

  describe "Index" do
    setup [:create_datapoint]

    test "lists all datapoints", %{conn: conn, datapoint: datapoint} do
      {:ok, _index_live, html} = live(conn, ~p"/datapoints")

      assert html =~ "Listing Datapoints"
      assert html =~ datapoint.medicinetype
    end

    test "saves new datapoint", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/datapoints")

      assert index_live |> element("a", "New Datapoint") |> render_click() =~
               "New Datapoint"

      assert_patch(index_live, ~p"/datapoints/new")

      assert index_live
             |> form("#datapoint-form", datapoint: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#datapoint-form", datapoint: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/datapoints")

      html = render(index_live)
      assert html =~ "Datapoint created successfully"
      assert html =~ "some medicinetype"
    end

    test "updates datapoint in listing", %{conn: conn, datapoint: datapoint} do
      {:ok, index_live, _html} = live(conn, ~p"/datapoints")

      assert index_live |> element("#datapoints-#{datapoint.id} a", "Edit") |> render_click() =~
               "Edit Datapoint"

      assert_patch(index_live, ~p"/datapoints/#{datapoint}/edit")

      assert index_live
             |> form("#datapoint-form", datapoint: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#datapoint-form", datapoint: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/datapoints")

      html = render(index_live)
      assert html =~ "Datapoint updated successfully"
      assert html =~ "some updated medicinetype"
    end

    test "deletes datapoint in listing", %{conn: conn, datapoint: datapoint} do
      {:ok, index_live, _html} = live(conn, ~p"/datapoints")

      assert index_live |> element("#datapoints-#{datapoint.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#datapoints-#{datapoint.id}")
    end
  end

  describe "Show" do
    setup [:create_datapoint]

    test "displays datapoint", %{conn: conn, datapoint: datapoint} do
      {:ok, _show_live, html} = live(conn, ~p"/datapoints/#{datapoint}")

      assert html =~ "Show Datapoint"
      assert html =~ datapoint.medicinetype
    end

    test "updates datapoint within modal", %{conn: conn, datapoint: datapoint} do
      {:ok, show_live, _html} = live(conn, ~p"/datapoints/#{datapoint}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Datapoint"

      assert_patch(show_live, ~p"/datapoints/#{datapoint}/show/edit")

      assert show_live
             |> form("#datapoint-form", datapoint: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#datapoint-form", datapoint: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/datapoints/#{datapoint}")

      html = render(show_live)
      assert html =~ "Datapoint updated successfully"
      assert html =~ "some updated medicinetype"
    end
  end
end

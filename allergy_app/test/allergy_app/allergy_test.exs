defmodule AllergyApp.AllergyTest do
  use AllergyApp.DataCase

  alias AllergyApp.Allergy

  describe "datapoints" do
    alias AllergyApp.Allergy.Datapoint

    import AllergyApp.AllergyFixtures

    @invalid_attrs %{" ": nil}

    test "list_datapoints/0 returns all datapoints" do
      datapoint = datapoint_fixture()
      assert Allergy.list_datapoints() == [datapoint]
    end

    test "get_datapoint!/1 returns the datapoint with given id" do
      datapoint = datapoint_fixture()
      assert Allergy.get_datapoint!(datapoint.id) == datapoint
    end

    test "create_datapoint/1 with valid data creates a datapoint" do
      valid_attrs = %{" ": "some  "}

      assert {:ok, %Datapoint{} = datapoint} = Allergy.create_datapoint(valid_attrs)
      assert datapoint.  == "some  "
    end

    test "create_datapoint/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Allergy.create_datapoint(@invalid_attrs)
    end

    test "update_datapoint/2 with valid data updates the datapoint" do
      datapoint = datapoint_fixture()
      update_attrs = %{" ": "some updated  "}

      assert {:ok, %Datapoint{} = datapoint} = Allergy.update_datapoint(datapoint, update_attrs)
      assert datapoint.  == "some updated  "
    end

    test "update_datapoint/2 with invalid data returns error changeset" do
      datapoint = datapoint_fixture()
      assert {:error, %Ecto.Changeset{}} = Allergy.update_datapoint(datapoint, @invalid_attrs)
      assert datapoint == Allergy.get_datapoint!(datapoint.id)
    end

    test "delete_datapoint/1 deletes the datapoint" do
      datapoint = datapoint_fixture()
      assert {:ok, %Datapoint{}} = Allergy.delete_datapoint(datapoint)
      assert_raise Ecto.NoResultsError, fn -> Allergy.get_datapoint!(datapoint.id) end
    end

    test "change_datapoint/1 returns a datapoint changeset" do
      datapoint = datapoint_fixture()
      assert %Ecto.Changeset{} = Allergy.change_datapoint(datapoint)
    end
  end

  describe "datapoints" do
    alias AllergyApp.Allergy.Datapoint

    import AllergyApp.AllergyFixtures

    @invalid_attrs %{intensity: nil, medicine: nil, medicinetype: nil, region: nil, symptom: nil}

    test "list_datapoints/0 returns all datapoints" do
      datapoint = datapoint_fixture()
      assert Allergy.list_datapoints() == [datapoint]
    end

    test "get_datapoint!/1 returns the datapoint with given id" do
      datapoint = datapoint_fixture()
      assert Allergy.get_datapoint!(datapoint.id) == datapoint
    end

    test "create_datapoint/1 with valid data creates a datapoint" do
      valid_attrs = %{intensity: 42, medicine: true, medicinetype: "some medicinetype", region: "some region", symptom: "some symptom"}

      assert {:ok, %Datapoint{} = datapoint} = Allergy.create_datapoint(valid_attrs)
      assert datapoint.intensity == 42
      assert datapoint.medicine == true
      assert datapoint.medicinetype == "some medicinetype"
      assert datapoint.region == "some region"
      assert datapoint.symptom == "some symptom"
    end

    test "create_datapoint/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Allergy.create_datapoint(@invalid_attrs)
    end

    test "update_datapoint/2 with valid data updates the datapoint" do
      datapoint = datapoint_fixture()
      update_attrs = %{intensity: 43, medicine: false, medicinetype: "some updated medicinetype", region: "some updated region", symptom: "some updated symptom"}

      assert {:ok, %Datapoint{} = datapoint} = Allergy.update_datapoint(datapoint, update_attrs)
      assert datapoint.intensity == 43
      assert datapoint.medicine == false
      assert datapoint.medicinetype == "some updated medicinetype"
      assert datapoint.region == "some updated region"
      assert datapoint.symptom == "some updated symptom"
    end

    test "update_datapoint/2 with invalid data returns error changeset" do
      datapoint = datapoint_fixture()
      assert {:error, %Ecto.Changeset{}} = Allergy.update_datapoint(datapoint, @invalid_attrs)
      assert datapoint == Allergy.get_datapoint!(datapoint.id)
    end

    test "delete_datapoint/1 deletes the datapoint" do
      datapoint = datapoint_fixture()
      assert {:ok, %Datapoint{}} = Allergy.delete_datapoint(datapoint)
      assert_raise Ecto.NoResultsError, fn -> Allergy.get_datapoint!(datapoint.id) end
    end

    test "change_datapoint/1 returns a datapoint changeset" do
      datapoint = datapoint_fixture()
      assert %Ecto.Changeset{} = Allergy.change_datapoint(datapoint)
    end
  end
end

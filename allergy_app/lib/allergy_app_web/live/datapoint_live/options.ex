defmodule AllergyAppWeb.DatapointLive.Options do
  def options() do

    medizinetype = [
      "",
      "Cetirizine ADHC",
      "Cetirizine"
    ]

    region = [
      "",
      "Augen",
      "Nase",
      "Haut",
      "linker Arm",
      "rechter Arm"
    ]

    symptom = [
      "",
      "Jucken",
      "Tränen",
      "Rötung",
      "Ausschlag",
      "Schmerzen",
    ]

    %{
      medizinetype: medizinetype,
      region: region,
      symptom: symptom
    }
  end
end

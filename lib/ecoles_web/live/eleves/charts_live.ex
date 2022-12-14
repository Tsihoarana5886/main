defmodule EcolesWeb.Eleves.ChartsLive do

  use Phoenix.LiveView
  alias Ecoles.Model.Elevesmodeles
  alias Ecoles.Model.Adminmodeles
  # alias Ecoles.Shema
  alias EcolesWeb.StatistiquesView

  #monter = mount
  def mount(_params, %{"curr_user_id" => user_id}, socket) do
    admin = Adminmodeles.get_admin_id(user_id)
    list_study_boys = Elevesmodeles.list_study_boys()
    list_study_girls = Elevesmodeles.list_study_girls()

    labels_eleves_by_class =
    for class <- Elevesmodeles.list_classe do
      elem(class, 0)
    end

    values_eleves_by_class =
    for class <- Elevesmodeles.list_classe do
      class_id = elem(class, 1)

      Elevesmodeles.list_eleves_par_classe(class_id)
        |> Enum.count()
    end

    {:ok, socket
            |> assign(
                      show_dashboard_component: true,
                      list_study_boys: list_study_boys,
                      list_study_girls: list_study_girls,
                      chart_data: %{labels_eleves_by_class: labels_eleves_by_class, values_eleves_by_class: values_eleves_by_class})
    }
  end

  #rendre = render
  def render(assigns) do
    StatistiquesView.render("stat.html", assigns)
  end

end

defmodule Toby.Components.StatusBar do
  @moduledoc """
  A component that displays the status bar for navigation between views.
  """

  @behaviour Toby.Component

  import ExTermbox.Renderer.View

  alias ExTermbox.Constants

  @default_options [
    {:system, "[S]ystem"},
    {:load, "[L]oad Charts"},
    {:memory, "[M]emory Allocators"},
    {:application, "[A]pplications"},
    {:process, "[P]rocesses"},
    {:port, "Po[r]ts"}
  ]

  @style_selected %{
    attributes: [Constants.attribute(:bold)]
  }

  def handle_event(_, state), do: {:ok, state}

  def tick(state), do: {:ok, state}

  def render(%{options: options} = attrs) do
    bar do
      label do
        render_options(options, attrs[:selected])
      end
    end
  end

  def render(%{} = attrs) do
    attrs
    |> Map.merge(%{options: @default_options})
    |> render()
  end

  defp render_options(options, selected) do
    rendered_options =
      for {key, label} <- options do
        if key == selected do
          text(@style_selected, label)
        else
          text(label)
        end
      end

    Enum.intersperse(rendered_options, text(" "))
  end
end
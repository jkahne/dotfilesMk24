import_if_available(Ecto.Query)
import_if_available(Ecto.Changeset)

import_if_available(Montecarlow.Factory)

IEx.configure(
  colors: [
    enabled: true,
    eval_result: [ :cyan, :bright ],
    eval_error:  [ :light_magenta ],
  ],
  inspect: [
    limit: :infinity,
    printable_limit: :infinity,
    charlists: :as_lists,
    pretty: true
  ],
  default_prompt: [
    "\r\e[38;5;220m",         # a pale gold
    "%prefix",                # IEx context
    "\e[38;5;112m(%counter)", # forest green expression count
    "\e[38;5;220m>",          # gold ">"
    "\e[0m",                  # and reset to default color
  ]
  |> IO.chardata_to_string
)

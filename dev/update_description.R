library(desc)
library(usethis)

use_package("grDevices")

set_floors <- function(floors, type = "Imports") {
  for (pkg in names(floors)) {
    desc::desc_set_dep(pkg, type = type, version = floors[[pkg]])
  }
}

set_r_floor <- function() {
  desc::desc_set_dep("R", type = "Depends", version = ">= 4.3")
}


set_r_floor()
set_floors(c(
  dplyr         = ">= 1.1.0",
  tidyr         = ">= 1.0.0",
  sensorstrings = ">= 1.4.1"       # same silent pH skip as qaqcmar
))
desc::desc_set_remotes(c(          # org/repo form, as in the other packages
  "Centre-for-Marine-Applied-Research/qaqcmar",
  "Centre-for-Marine-Applied-Research/sensorstrings"
))

